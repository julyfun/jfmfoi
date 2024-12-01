#import "@preview/touying:0.5.3": *
#import themes.university: *
#import "@preview/cetz:0.2.2"
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#import "@preview/ctheorems:1.1.2": *
#import "@preview/numbly:0.1.0": numbly

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

// Theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

#show: university-theme.with(
  aspect-ratio: "16-9",
  // config-common(handout: true),
  config-info(
    title: [J1 - 新手入门],
    subtitle: [],
    author: [方俊杰.SJTU],
    date: datetime.today(),
    institution: [交附闵分],
    logo: emoji.school,
  ),
)

// #set heading(numbering: numbly("{1}.", default: "1.1"))

// [my]

// [code]
#show raw.where(lang: "cpp"): it => {
  set text(12pt)
  it
}
#show raw.where(block: false): it => box(
  fill: rgb(248, 248, 248),
  outset: 4pt,
  radius: 3pt,
  stroke: 0.5pt + gray,
  it
)

// [text]
#set text(20pt)
#set text(
  font: ("New Computer Modern", "Songti SC")
)
#show strong: set text(weight: 900)  // Songti SC 700 不够粗

#set list(indent: 0.8em)
#show link: underline

#let lin = line(length: 100%)
// [my.end]

#title-slide()

== <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 1.5em))

== 算法竞赛的目的

有基础同学为 S 组. 其他同学为 J 组.

=== 什么是算法？

- 比如，快速排序一组凌乱的数字
  - `a = [3, 1, 4, 1, 5]`
  - `sorted(a)`
- 比如给出一些道路信息，你要寻找两个城市之间的最短路. 这些算法在软件、游戏、机器人、网络、硬件等地方无处不在.

=== 算法竞赛: NOI全国青少年信息学奥林匹克竞赛（系列）

- 把各种算法综合起来，解决一些复杂的问题，基本都是 C++ 写
- 通过竞赛选拔，进入国家集训队可保送清北计算机系
- 高分可参加清北冬令营，得到各大学强基计划 / 综测免试或面试加分
- 近年，不仅计算机，大学几乎所有理工专业都要求越来越高的程序能力. 例如 RM.

== 时间表

- 25年9月底: CSP-S 笔试. 必须通过才能参加复赛，此后比赛都是上机写代码
- 25年10月底：CSP-S 复赛. 奖项含金量较高. 必须拿到一定分数才能参加 NOIP
- 25年11月底：NOIP，难度略高于 CSP-S，含金量高. 较高分可报名清北冬令营 / APIO / CTSC.
- PKUWC / THUWC: 寒假
- 26年3月：上海市队选拔，难度高于 NOIP
- 26年7月：NOI，国家集训队选拔

=== 集训时间

- 学期中 & 下学期：周日集训，平时需完成部分作业
- 寒暑假：会组织线上或线下连续集训

== 准备工作

+ 加微信群
+ 注册洛谷账号，加洛谷团队 https://www.luogu.com.cn/team/16908
+ 你能打开 Dev-C++ 吗？
+ J 组：前 1h 讲解入门知识，后 2h 做题 + 答疑
+ S 组: 你觉得本 PPT 太简单，可以直接从题单 A+B Problem（高精）	开始做
+ NOIP 组：在隔壁机房练 Tarjan

- 随时欢迎邀请新同学加入我们训练.

#lin

- 深入浅出程序竞赛\_入门篇.pdf
  - 这本书比较啰嗦，值得用来自学但不要抠字眼
- 学会百度 (CSDN 和博客园的算法解析) / 看洛谷题解学习
- oi-wiki.org
  - 算法全面，但讲解方法较正式

== J: 第一个程序

```cpp
#include <iostream>
using namespace std;
int main() {
    cout << "I love jfmf!";
    return 0;
}
```

#figure(image("pic/image copy 6.png", height: 50%))

- 输出了什么？双引号的作用是?
- 每个部分的作用 

#pagebreak() 

=== 编译和编译错误

- C++ 程序都是先编译成 exe 才能运行.
- 将分号去掉再编译运行，会发生什么事情？[..]

#figure(image("pic/image copy 5.png", height: 60%))

- 错误解读 [..]

=== 例题

#figure(image("pic/image.png"))

#pagebreak()

#[
#show figure: set align(left)
#figure(image("pic/image copy.png", height: 50%))
]

- 整除 [..]
- endl [..]
- 取余 [..]
- 注释 [..]

== 浮点数类型

#figure(image("pic/image copy 2.png"))

- 输出 [?]
- 500.0 是一个浮点数类型，可以存储非整数值
- 3 的转换 [..]
- 如果 500.0 改成 500，输出会是什么 [?]

== 变量

- 小汪手里有 100 元.
- 随后他打工赚了 20 元.
- 然后他的钱翻倍了.
- 最后钱清空了.

用整数变量 `money` 存户小汪的钱，每一次操作后输出这个变量. 提示: 

```cpp
int money = 100;
cout << money << endl;
money = money + 20; // 或 money += 20;
cout << ...
```

- [?] int 存储的范围是 $-2^31 ~ 2^31 - 1$，超过这个范围会出现问题.
- [..] 实验

== 实数类型变量

#figure(image("pic/image copy 3.png"))

提示: 浮点数这样写: `double r = 5;`

- double 类型也有一定范围，但比 int 大得多

== 变量的输入

- 下面我们的程序变得更强大，能用键盘输入数据，并输出对应答案.
- 问题：输入两个整数 $a, b$，输出他们的和. 输入满足 $|a|, |b| <= 10^9$.
- 读入变量的方式：先定义变量，再用 `cin` 读入.
- ```cpp
int a, b;
cin >> a >> b;
cout << a + b << endl;
```

#lin

- 运行程序，输入两个数加回车，看看输出是什么

== 评测: 你的程序对不对？

- 测试 https://www.luogu.com.cn/problem/P1001
- [..] 题目描述，输入格式，输出格式，样例
- 样例中，提供了一组输入和对应的答案。你的程序能否输出一样的答案？
- [..] 在网站上提交程序，洛谷会自动向你的程序输入几组数据，如果你的输出和洛谷的答案一样，就能得分.

#pagebreak()

#figure(image("pic/image copy 4.png"))

- 正式比赛时，评测机也会向你的程序输入数据，然后把你的输出和标准答案进行比较.

== char 类型

- char 类型可以存储一个字符.
- 例如，`char c = 'A';` 这里单引号用来表示单个字符.
- `char` 可以做减法。例如 `cout << 'D' - 'A';` 输出什么? [..]
- 为什么可以做减法？因为字符在计算机内部也是由数字表示的.
  - 例如，`'A'` 在计算机内部是 65. 这种对应关系由 ASCII 表规定.
  - `'a'` 和 `'A'` 的 ASCII 码相差多少 [?]
  - `'0' ~ '9'` 的 ASCII 码是 [?]
  - 空格 [?]

#figure(image("pic/image copy 7.png"))

#pagebreak()

=== 类型转换

- 动手：已知整数 $i$，如何求出 ASCII 码为 $i$ 的字符？
- 尝试：可以通过 `char(i)` 将 int 类型量强制转换为 char 类型:

```cpp
int i = 48;
cout << i << endl; // 输出 48
cout << char(i) << endl; // 输出 0
```

- 其他基本类型之间也可以相互转换. 
- [?] 提问: `500 / 3` 和 `double(500) / 3` 分别是多少？
- 注意：如果你写 `char ch = 97;` 则 97 会被隐式转换为字符 `a`.
- [动手]：输入一个整数 $i$，输出第 $i$ 个小写字母.
- [动手]：`int i = 5.5;` 会发生什么事？输出看看.

#pagebreak()

#figure(image("pic/image copy 8.png"))

== 内置函数

- 例题：输入整数 $a, b$，求直角边为 $a, b$ 的直角三角形斜边长.
- 提示:
  - `sqrt(x)` 函数可以求 $x$ 的平方根
  - 需要在程序前面加入 `#include <cmath>` 头文件，引入数学函数.

== 输出保留几位小数

#figure(image("pic/image copy 10.png", height: 80%))

- `printf` 和 `scanf` 的格式都是先一个字符串表示输入输出规则，后面是变量.
- `scanf` 变量前面要跟 `&`，`printf` 不用.

#figure(image("pic/image copy 11.png"))

== 作业

- 点此链接，点击左上角参与作业：https://www.luogu.com.cn/training/651696#information
- OI 比赛刷题是必须的，我们要求每周完成一半以上作业题单的题目（例如有 5 题就完成 3 题. 如果超过 4 题只做 4 题就够了)，基本可以确保掌握知识点.

#figure(image("pic/image copy 9.png"))
