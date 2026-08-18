# 🐣 Clings 招新考核

<p align="center">
  <i>“C is quirky, flawed, and an enormous success.”</i><br/>
  <b>—— Dennis Ritchie</b>
</p>

欢迎来到 **Lingrui Studio 招新考核**！

你只需要三样东西：**一台电脑、一点耐心、和一个不轻易放弃的自己**。
剩下的，交给我们——以及那位话很难听但永远正确的编译器老师。

---

## 这是什么？

**Clings** 是一个 Rustlings 风格的 C 语言练习工具：

- 每题一个目录：**讲义（`README.md`）** + **脚手架源码（`.c`）** + **配置文件（`exercises.toml`）**
- 你负责把源码中标着 `#error TODO` 的地方补完
- **保存文件即自动编译、运行、反馈**

一共 **20 道题**，难度循序渐进：

> 打印 hello world → 循环 → 判断 → 累加 → 九九乘法表 → 素数 → 数位统计
> → 结构体 → 字符串 → 位运算 → 指针 → 状态机 → 猜数字

每道题都配有中文讲义、知识点、课堂讨论和课后练习。

> 以下是克隆到本地后的使用视频，若无法播放，请看 `attachment` 目录下的 `begin.mp4`

<video src="./attachment/begin.mp4"></video>

---

## 全程就五步

### 第 0 步：创建你的作业仓库（2 分钟）

你正在读的这份 README 来自模板仓库。点击页面右上角的绿色 **"Use this template"** 按钮：

1. **Owner** 选你自己的账号（不是工作室）
2. 仓库名随意，例如 `clings-recruit`
3. 记得选 **Public**（便于我们查看你的成绩信息）
4. 点 **Create repository**

然后把它搬回本地：

```bash
git clone https://github.com/你的用户名/clings-recruit.git
cd clings-recruit
```

> 💡 不会 git？只需要记住两个命令：`git clone`（把仓库搬下来）和后面第 3 步的 `git add/commit/push`（把作业交上去），够用了。

### 第 1 步：装环境（10 分钟，相当于给胚胎保温）

**环境要求：**

| 系统 | 需要什么 |
|---|---|
| Linux / macOS / WSL | 系统自带 gcc，直接下一步 |
| Windows 裸机 | 安装 [MSYS2](https://www.msys2.org/)（含 gcc 和 bash），或 MinGW + Git Bash；装完确认 `gcc --version` 有输出 |
| Python | 3.11+（`setup.sh` 会自动安装 uv 和 clings，一般不用手动管） |

作为过来人，我们强烈推荐你使用 Linux 或 macOS 等 unix-like 操作系统作为开发环境，对于 Windows 玩家，最好的选择是 WSL。Windows 的包管理始终是相当难评的一个点，~~FUCK MICROSOFT~~。

**一键安装：**

看到仓库目录下的 `setup.sh` 了吗？它就是给你保温箱的开关。只要在终端里敲：

```bash
bash setup.sh
```

脚本会自动：安装 `uv` → 安装 `clings` → 跑 `clings doctor` 自检。
看到 `compiler smoke test: ok` 就说明保温箱温度正常，可以开始养了。

> 💡 Windows 用户：`setup.sh` 是 bash 脚本，请在 **Git Bash 或 WSL** 里运行，
> 不要在 cmd / PowerShell 里直接敲。

### 第 2 步：做题（主线任务）

```bash
clings
```

进入交互模式后，Clings 会自动定位到你的**下一道未完成题目**。
打开对应的 `.c` 文件，把 `#error TODO` 换成真正的代码，**保存**——它就会自动编译、运行、告诉你过没过。

**常用按键：**

| 按键 | 作用 |
|---|---|
| `n` | 下一题 |
| `h` | 看提示（卡住 30 分钟以上再按，效果更佳） |
| `t` | 看本题的公开测试用例 |
| `l` | 题目列表 |
| `c` | 手动检查当前题 |
| `x` | 重置当前题（恢复到初始脚手架） |
| `q` | 退出 |

**常用命令（不想进交互模式也可以直接敲）：**

```bash
clings list                # 查看进度
clings hint                # 下一道未完成题目的提示
clings tests 02b_format_print   # 查看某题的公开测试用例
clings run 04_odd_or_even  # 运行某题，看实际输出
clings check               # 依次检查全部题目
clings reset 17_word_count # 重置某题
clings reset progress      # 清空本地进度（慎用）
clings score --json        # 生成成绩单 clings_score.json
```

**做题心法（很重要，建议抄下来）：**

- 编译器报错 = 毒舌教练。**只看第一行 `error:`**，它已经告诉了你缺什么；后面的洪水一样的输出可以无视。
- 每题的 `README.md` 是正经讲义，先读它再动手。卡住 30 分钟再按 `h`，卡住 1 小时就去问 AI 或同学。
- 公开测试你随时能看（`clings tests <名字>`），但**最终成绩包含隐藏测试**——负数和 0、大数和边界、空串和重复空白，都会来。面向公开用例硬编码是活不过隐藏测试的，别偷这个懒。~~我会盯着你们的~~

### 第 3 步：提交（30 秒，冲刺）

你通过 "Use this template" 创建的仓库就是你的作业本。做完题，git 三连：

```bash
git add -A
git commit -m "完成招新考核"
git push
```

每次 push，GitHub Actions 会自动跑 **20 条判分测试**（每道题一条），结果实时可见：

- 看结果：仓库 **Actions** 标签页，绿勾 = 全过，红叉 = 有题没过（点进去看是哪题）
- 每次推送还会生成一份 `clings_score.json` 成绩单，可作为你的存档
- 以**截止时间前最后一次 push** 为准，改完可以反复推送，自动重判

### 第 4 步：看判分结果（push 后 1~3 分钟）

push 后稍等片刻（Actions 要排队装环境），然后：

1. 回到你的仓库页面，点顶部 **Actions** 标签
2. 看最新一次 run：**绿色 = 20 题全过**，红色 = 有题没过
3. 红色就点进去，看哪条测试失败，展开日志搜 `FAILED`，改完重新 push 即可自动重判
4. 想留成绩单？run 页面底部 **Artifacts** 里可以下载 `clings-score`（`clings_score.json`）

---

## 题目清单（20 道）

| 题目 | 主题 | 知识点 |
|---|---|---|
| 01a_return_zero | 最简单的 C 程序 | main 函数、return |
| 01b_return_expression | 变量与表达式 | 全局/局部变量、运算符 |
| 02a_hello_printf | printf 入门 | 标准输出、转义字符 |
| 02b_format_print | 格式化输出 | %d、%x、格式化占位符 |
| 03a_while_loop | while 循环 | 循环条件、自增 |
| 03b_for_loop | for 循环 | for 三段式、倒序 |
| 04_odd_or_even | 判断奇偶 | if-else、取余 % |
| 05a_sum_1_to_100 | 循环累加 | 累加器模式 |
| 05b_sum_even | continue | 循环控制、只加偶数 |
| 06_multiplication_table | 九九乘法表 | 嵌套循环、制表符 |
| 07a_max_prime | 最大素数 | 函数、循环、素数判定 |
| 08_count_digit_nine | 数 9 游戏 | 数位分解、函数 |
| 11_point_distance | 两点距离 | 结构体、sqrt |
| 13a_get_last_char | 取末字符 | 字符串、strlen |
| 13b_is_restricted | 限行判断 | switch、三元运算符 |
| 14a_print_board | 棋盘打印 | 二维数组、初始化 |
| 15a_count_bits_loop | 数 bit 1 | 位运算、循环 |
| 16_my_strcpy | 手写 strcpy | 指针、字符复制 |
| 17_word_count | 单词计数 | 状态机思想 |
| 22a_generate | 猜数字生成器 | 随机数、去重 |

---

## 学习资源

### 📕 第一选择：K&R《The C Programming Language》

中文版叫 **《C 程序设计语言》（第 2 版）**，作者 Kernighan & Ritchie（Ritchie 就是 C 语言之父本人）。未来你在学 CSAPP 等课程时，会发现 K&R 是指定的 C 语言参考资料。

- 只有 200 多页，却是无数程序员"顿悟"的起点——**薄，但每一页都值得读三遍**
- 强烈建议：**精读 + 亲手敲完书里每一个例子**，敲完你就赢了一半
- 它不是语法字典，它教的是**品味、本质和思考方式**——这本书读完，后面的路会顺很多
- 小提示：K&R 写于 ANSI C（C89）时代，语法基础与现在的 C11 完全一致，入门毫无障碍；个别过时写法（比如函数声明）遇到时知道一下即可

### 📗 第二选择：《C Primer Plus》（第 6 版）

如果 K&R 对你来说太"仙"、太简练，那就用它——**更厚、更细、更像一本温柔的字典**。
系统学习、查漏补缺都合适，慢慢啃也能到终点。

> 一句话总结：**能读 K&R 就读 K&R（神功秘籍），读不下去就 C Primer Plus（九年义务教育）**，两条路都能到罗马。

### 💻 在线资源

- [cppreference.com](https://en.cppreference.com/) —— 标准库和语法权威字典，遇到不懂的查它
- 本题库的每道题讲义 —— 现学现卖，读完就做
- 编译器报错看不懂？把错误信息丢给 AI，让它解释——但**要确保自己真的懂了再往下写**

---

## 常见问题（FAQ）

**Q：编译报错一大片，看不懂。**
A：只看第一行 `error:`。然后按 `h` 看提示，或者把第一行错误复制给 AI / 同学。

**Q：Windows 上 `setup.sh` 跑不起来。**
A：用 Git Bash 或 WSL 运行；确认 `gcc --version` 能输出；`clings doctor` 会告诉你缺什么。

**Q：保存了文件但没反应。**
A：确认是在题库根目录下运行 `clings`（不是随便哪个文件夹）；看终端有没有报错。

**Q：push 了但 Actions 显示红叉。**
A：点进 Actions 看是哪道题挂了，改完重新 push 即可，会自动重新判分，不扣"次数"。

**Q：全部通过之后呢？**
A：等截止。我们会用隐藏测试做权威判分，并公布结果。绿勾只代表公开测试过了，隐藏测试才是终局。

**Q：可以问 AI / 抄同学吗？**
A：允许讨论、允许用 AI 当教练，但请确保**每一行代码你都能解释**。面试时我们会问的 😄

---

## 规则红线（请认真读）

- 不要修改 `exercises.toml`、`tests/`、`Makefile` 等评测配置
- 不要删除 `.github/` 下的判分工作流
- 独立完成，诚信作答；硬编码公开用例、篡改判分配置视为作弊
- 截止时间前完成 push，逾期不候
- 题库相关问题，欢迎在 Github Issues 里提问

---

## 最后的话

> [!TIP]
> “踏上取经路，比抵达灵山更重要。”
> —— 冯骥

> [!TIP]
> “The only way to learn a new programming language is by writing programs in it.”
> —— Brian Kernighan & Dennis Ritchie，K&R 前言

你不需要一开始就很强，你只需要**开始**。

第一道题可能只是 `return 0;`，看起来毫无成就感——但恭喜你，你已经跑通了"编辑 → 编译 → 运行"这整个循环，而这是所有程序员的起点。

20 道题做完，你就算是步入了 C 语言的大门。我们会在终点等你。

加油，开工吧。🐣✨

EarthCloud, Rovi~
