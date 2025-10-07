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

// [my.topic]
#let topic = [Hello world!]

#show: university-theme.with(
  aspect-ratio: "16-9",
  // config-common(handout: true),
  config-info(
    title: topic,
    subtitle: [],
    author: [方俊杰.SJTU],
    date: datetime.today(),
    institution: [通辽五中],
    logo: image("pic/noi.png"),
  ),
)

#show heading.where(level: 1): set heading(numbering: numbly("{1}.", default: "1.1"))

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
#show raw.where(block: true): it => box(
  fill: rgb(248, 248, 248),
  outset: 8pt,
  radius: 3pt,
  stroke: 0.5pt + gray,
  it
)
#show raw: it => box()[
  #set text(font: ("Consolas",  "FZCuYuan-M03S"))
  #it
]
  
// [text]
#set text(20pt)
#set text(
  font: ("FZCuYuan-M03S", "Heiti SC")
)
#show strong: set text(weight: 900)  // Songti SC 700 不够粗

#set list(indent: 0.8em)
#show link: underline

#let lin = line(length: 100%)

// [my.end]

#title-slide()

== <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 1.5em))

= 课程介绍

== 为什么学习编程？

#slide[
#figure(image("pic/image copy 16.png", height: 39%), caption: "数据分析", supplement: none)
#figure(image("pic/image copy 17.png", height: 39%), caption: "AI 机器人", supplement: none)
][
#figure(image("pic/sudoku_index.jpg", height: 39%), caption: "编写自己的游戏", supplement: none)
#figure(image("pic/image copy 18.png", height: 39%), caption: "计算机网络", supplement: none)
]

== 这些都离不开算法

#slide[
#figure(image("pic/image copy 16.png", height: 39%), caption: "数据分析: 快速傅里叶变换", supplement: none)
#figure(image("pic/image copy 17.png", height: 39%), caption: "AI 机器人: 神经网络", supplement: none)
][
#figure(image("pic/sudoku_index.jpg", height: 39%), caption: "编写自己的游戏: 舞蹈链算法", supplement: none)
#figure(image("pic/image copy 18.png", height: 39%), caption: "计算机网络: Dijkstra 最短路", supplement: none)
]

== NOI 系列算法竞赛

- 世界上有各种各样的编程语言，如 C, C++, Java, Python, Javascript
- 把各种算法综合起来，解决一些复杂的问题，基本都是 C++ 写
- 通过竞赛选拔，进入国家集训队可保送清北计算机系
- 高分可参加清北冬令营，得到各大学强基计划 / 综测免试或面试加分
- 近年，不仅计算机，大学几乎所有理工专业都要求越来越高的程序能力.

// [TODO]
#figure(image("pic/image copy 18.png", height: 39%), caption: "C++ 比 python 快 100 倍左右", supplement: none)

== 时间表

- 25年9月底: CSP-S 笔试. 必须通过笔试才能参加复赛，此后比赛都是上机写代码
- 25年10月底：CSP-S 复赛. 奖项含金量较高. 必须拿到一定分数才能参加 NOIP
- 25年11月底：NOIP，难度略高于 CSP-S，含金量高. 较高分可报名清北冬令营 / APIO / CTSC.
- 26年寒假：清北冬令营. 【可获得强基计划优惠政策】
- 26年3月：省队选拔. 难度高于 NOIP
- 26年7月：NOI. 国家集训队选拔 【高分可保送清北】

=== 集训时间

- 寒暑假：寒假 18 天集训，暑假多于寒假
- 平时：学校教练会安排周末集训


#[
#set page(columns: 2)

== 我是谁?

- 方老师，上海交通大学.
- CSP-S & NOIP 双省一，超过浙江省 NOIP 一等分数线 140 多分.
- 上海交通大学 ACM 校队，第 45 届 CCPC 金牌.
- RoboMaster 机器人大赛全国冠军，参与上交机器人研究所和机器人公司科研项目.
- 上海交大附中信奥教练 （2 年），带领零基础同学获得了上海 CSP-S 和 NOIP 数个一等、二等和三等奖.

#figure(image("pic/CCPC获奖证书.jpg", height: 39%), caption: "中国大学生程序设计竞赛 CCPC 金奖", supplement: none)
#figure(image("pic/image copy 21.png", height: 39%), caption: "RoboMaster 机器人大赛全国冠军", supplement: none)
]

== 准备工作

+ 加微信群
+ 注册洛谷账号，加洛谷团队 https://www.luogu.com.cn/team/16908
+ 安装和使用 Dev-C++

=== 学习资料

- 深入浅出程序竞赛入门篇 / 进阶篇
  - 这本书比较啰嗦，值得用来自学但不要抠字眼
- oi-wiki.org
  - 算法全面，但讲解方法较正式

== 如何使用 Dev-C++

[演示]

== 如何使用洛谷

[演示将上面代码交到洛谷上]

== 班级分配

#slide[
#figure(image("pic/image copy 19.png", height: 80%), caption: "提高班", supplement: none)
][
#figure(image("pic/image copy 20.png", height: 80%), caption: "入门班", supplement: none)
]


= #topic 讲题跟练

== 你好，世界！

```cpp
#include <iostream>
using namespace std;
int main() {
    cout << "hello world!";
    return 0;
}
```

#pagebreak()

```cpp
#include <iostream> // 头文件。引入 cout 输出的功能.
using namespace std; // 声明命名空间. 暂时不用理解干什么用.
int main() {
    cout << "hello world!";
    return 0;
}
```

#figure(image("pic/image copy 6.png", height: 50%))

- [逐行解释]

#pagebreak() 

=== 编译和编译错误

- C++ 程序都是先编译成 exe 才能运行.
- 将分号去掉再编译运行，会发生什么事情？[..]

#pause

#figure(image("pic/image copy 5.png", height: 60%))

- [解读错误]

== 苹果

#figure(image("pic/image copy 22.png"))

== 分苹果

#figure(image("pic/image.png"))

[..]

#pagebreak()

#[
#show figure: set align(left)
#figure(image("pic/image copy.png", height: 50%))
]

- [讲解]
  - 整除
  - endl
  - 取余
  - 注释

== 例 1-4 实数类型

#figure(image("pic/image copy 2.png"))

- 会输出什么？
- 500.0 是一个浮点数（实数）类型，可以存储非整数值.
- [讲解 3 的转换]
- 如果 500.0 改成 500，输出会是什么 [动手]

== 例 1-5 观察输出

#figure(image("pic/image copy 23.png"))

== 例 1-6 火车问题

#figure(image("pic/image copy 24.png"))

== 例 1-7 勾股定理

#figure(image("pic/image copy 25.png"))

- 这里要用到一个新的头文件 - `<cmath>` [..]

#pagebreak()

#figure(image("pic/image copy 26.png"))

= #topic 练习

== 

- 进入题单，点击左上角的“参与作业”
- https://www.luogu.com.cn/training/693715#problems
#figure(image("pic/image copy 27.png", height: 80%))

