# Clings 招新考核题库

Lingrui Studio 招新考核用 C 语言题库，共 **20 道题**，基于 Clings 运行（Rustlings 风格：保存文件即自动编译、运行、反馈）。

## 题目构成

| Unit | 主题 | 题目 | 数量 |
|---|---|---|---|
| unit0 | C Primer 入门 | 01a~05b（main/printf/循环/分支/累加） | 9 |
| unit1 | C Fundamentals 基础 | 06~22（嵌套循环/函数/数位/结构体/字符串/二维数组/位运算/指针/状态机/数组标记） | 11 |

题目改编自 OpenCamp C Camp 的 [learning-nccl/clings](https://cnb.cool/opencamp/learning-nccl/clings)（MIT License），并做了脱敏处理（移除指向课程仓库的链接与参考答案文件）。

## 目录结构

```text
recruit-bank/
├── clings.toml            # unit 定义
├── setup.sh               # 候选人一键安装环境
├── bin/
│   ├── grade.sh           # Classroom autograding 逐题判分入口
│   └── self-test.sh       # 发布前全流程自测
├── .github/workflows/     # Classroom + 成绩单工作流（从 demo-bank 复制）
├── exercises/             # 20 道题（README + exercises.toml + 脚手架源码）
├── tests/                 # 公开测试（输入驱动题的用例外置于此）
├── hidden-tests/          # 隐藏测试（不提交，判分时注入）
└── solutions/             # 参考答案（不提交，教师自验用）
```

## 设计说明

- **20 题构成**：unit0 全部 9 题 + unit1 精选 11 道简单~中等题（乘法表/素数/数位统计/结构体/字符串/棋盘/位运算/strcpy/单词计数/随机数）
- **公开测试可见**：固定输出题用例内联在 `exercises.toml`；7 道输入驱动题（04/11/13a/13b/15a/16/17）用例外置在 `tests/`，学生可用 `clings tests <name>` 查看
- **隐藏测试**：上述 7 题各配边界用例（负数/0/大数/空串/重复空白等），判分时通过 `CLINGS_HIDDEN_TEST_DIR` 注入，防面向公开用例硬编码
- **脚手架**：每题含 `#error TODO` 标记（未完成源码无法编译，`clings score` 据此区分 NOT_COMPLETED / FAILED）
- **参考答案**：`solutions/` 目录结构与 `exercises/` 一一对应，发布前用 `CLINGS_SOLUTIONS_DIR=... clings check --solutions` 自验

## 发布前自验

```bash
bash bin/self-test.sh    # 在 Linux / WSL (~ 目录) 下运行
```

## 判分流程

- **即时反馈**：GitHub Classroom autograding 逐题跑 `bash bin/grade.sh <name>`（公开测试）
- **权威判分**：截止后集中克隆提交，注入隐藏测试跑 `clings score --json --hidden`
- 详见工作室内部考核指南（隐藏测试与参考答案绝不随模板分发）
