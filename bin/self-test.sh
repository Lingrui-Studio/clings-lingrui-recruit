#!/bin/bash
# demo-bank 全流程自测脚本（Linux / WSL 环境）
# 验证: 安装 → doctor → 全新题库 score → 参考答案 → 学生流程 → 公开/隐藏判分
#       → 防硬编码演示 → CI 式逐题命令 → reset。结束后恢复初始状态。
# 注意: 在 WSL 中请把本仓库放在 ~ (ext4) 运行，/mnt/d 的 9p 缓存会导致 git 行为异常。
set -u
# uv 默认安装到 ~/.local/bin（非登录 shell 下不在此 PATH 中）
export PATH="$HOME/.local/bin:$PATH"
DEMO="$(cd "$(dirname "$0")/.." && pwd)"
cd "$DEMO" || exit 1

echo "== [0] 行尾保险: 关键文件统一 LF；清除拷贝残留的构建产物 =="
find "$DEMO" -type f \( -name '*.sh' -o -name 'Makefile' -o -name '*.yml' \
    -o -name '*.toml' -o -name '*.c' -o -name '*.md' \) -exec sed -i 's/\r$//' {} +
find "$DEMO/exercises" -type f \( -name app -o -name '*.exe' \) -delete
chmod +x bin/grade.sh setup.sh

echo "== [0.1] 安装 clings（默认本地源码路径，可用 CLINGS_SRC 覆盖）=="
CLINGS_SRC="${CLINGS_SRC:-/mnt/d/Code/Python/clings}"
uv tool install --force "$CLINGS_SRC" 2>&1 | tail -1
clings --version

echo "== [0.2] 校验 setup.sh 中的安装 URL 可达 =="
git ls-remote https://github.com/Lingrui-Studio/clings.git HEAD 2>&1 | head -1

echo "== [1] git 初始化并提交初始状态（reset 依赖 git）=="
rm -rf .git
git init -q
git config user.email demo@local
git config user.name demo
git add -A
git commit -qm "demo-bank initial"
git log --oneline | head -1

echo "== [2] 全新题库 score（应全部 NOT_COMPLETED / FAILED）=="
git checkout -- exercises
clings score --json 2>&1 | tail -4
python3 -c "import json;d=json.load(open('clings_score.json'));print('statuses:',[e['status'] for e in d['exercises']])"

echo "== [3] 参考答案验证（教师模式 --solutions，不触碰进度）=="
CLINGS_SOLUTIONS_DIR="$DEMO/solutions" clings check --solutions
echo "solutions check exit=$?"

echo "== [4] 模拟学生: 填入参考答案（solutions/** → exercises/**）=="
for f in solutions/*/*.c; do
  rel="${f#solutions/}"
  cp "$f" "exercises/$rel"
done

echo "== [5] clings check（公开测试，全过）=="
clings check
echo "check exit=$?"

echo "== [6] clings score --json（公开）=="
clings score --json 2>&1 | tail -3
python3 -c "import json;d=json.load(open('clings_score.json'));print('summary:',d['test_summary'])"

echo "== [7] 隐藏测试判分（CLINGS_HIDDEN_TEST_DIR + --hidden）=="
CLINGS_HIDDEN_TEST_DIR="$DEMO/hidden-tests" clings score --json --hidden 2>&1 | tail -3
python3 -c "import json;d=json.load(open('clings_score.json'));print('hidden summary:',d['test_summary'])"

echo "== [8] 防硬编码演示: 面向公开用例写死输出 =="
cat > exercises/15_count_bits/15a_count_bits_loop.c <<'EOF'
#include <stdio.h>
int main(void) {
    int num;
    scanf("%d", &num);
    if (num == 15) printf("4\n");
    else if (num == 1024) printf("1\n");
    else printf("99\n");
    return 0;
}
EOF
echo "--- 公开判分（硬编码版本能过）: ---"
clings check 15a_count_bits_loop
echo "public check exit=$?"
echo "--- 隐藏判分（应失败）: ---"
CLINGS_HIDDEN_TEST_DIR="$DEMO/hidden-tests" clings check 15a_count_bits_loop --hidden 2>&1 | tail -4
echo "hidden check exit=${PIPESTATUS[0]}"
cp solutions/15_count_bits/15a_count_bits_loop.c exercises/15_count_bits/15a_count_bits_loop.c

echo "== [9] CI 式逐题命令（bin/grade.sh）=="
bash bin/grade.sh 01a_return_zero; echo "grade 01a_return_zero exit=$?"
bash bin/grade.sh 17_word_count;   echo "grade 17_word_count exit=$?"

echo "== [10] 其他学生命令 =="
clings hint
echo "--- clings tests 15a_count_bits_loop ---"
clings tests 15a_count_bits_loop 2>&1 | head -6
echo "--- clings run 04_odd_or_even ---"
clings run 04_odd_or_even 2>&1 | tail -2
echo "--- clings list ---"
clings list 2>&1 | head -8

echo "== [11] clings reset 恢复题目 =="
printf 'broken' > exercises/17_word_count/wordsum.c
clings reset 17_word_count
echo "--- wordsum.c 恢复后的前 40 字节: ---"
head -c 40 exercises/17_word_count/wordsum.c; echo

echo "== [12] 清理，恢复初始状态 =="
git checkout -- exercises
rm -rf .git .clings .clings-state.txt clings_score.json
echo "ALL_DONE"
