#import "@preview/touying:0.4.2": *
#import "@preview/cetz:0.2.2"
#import "@preview/ctheorems:1.1.2": *
#import "@preview/fletcher:0.5.0" as fletcher: diagram, node, edge, shapes

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

// Register university theme
// You can replace it with other themes and it can still work normally
#let s = themes.university.register(aspect-ratio: "16-9")

// Set the numbering of section and subsection
#let s = (s.methods.numbering)(self: s, section: "1.", "1.1")

// Set the speaker notes configuration
// #let s = (s.methods.show-notes-on-second-screen)(self: s, right)

// [my]

#set text(
  font: ("New Computer Modern", "Songti SC")
)
#show strong: set text(weight: 900)  // Songti SC 700 不够粗

// Global information configuration
#let s = (s.methods.info)(
  self: s,
  title: [CSP2022初赛和你的最小生成树],
  subtitle: [],
  author: [方俊杰.SJTU],
  date: datetime.today(),
  institution: [交附闵分 OI],
)

// Pdfpc configuration
// typst query --root . ./example.typ --field value --one "<pdfpc-file>" > ./example.pdfpc
#let s = (s.methods.append-preamble)(self: s, pdfpc.config(
  duration-minutes: 30,
  start-time: datetime(hour: 14, minute: 10, second: 0),
  end-time: datetime(hour: 14, minute: 40, second: 0),
  last-minutes: 5,
  note-font-size: 12,
  disable-markdown: false,
  default-transition: (
    type: "push",
    duration-seconds: 2,
    angle: ltr,
    alignment: "vertical",
    direction: "inward",
  ),
))

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

// Extract methods
#let (init, slides, touying-outline, alert, speaker-note) = utils.methods(s)
#show: init

#show strong: alert

// Extract slide functions
#let (slide, empty-slide) = utils.slides(s)

// --- 以下为正文

#show raw.where(lang: "cpp"): it => {
  set text(12pt)
  it
}

#set text(20pt)

#show: slides

= csp2022: 一等分数线

上海那年我记得没参加，预计 175 左右一等

ref: https://www.sohu.com/a/607059613_121124015

https://www.noi.cn/xw/2022-11-17/777448.shtml

== T1

#image("image copy 3.png")

== P8818 [CSP-S 2022] 策略游戏

#image("image copy 4.png")

== P8819 [CSP-S 2022] 星战

#image("image copy 7.png")
#image("image copy 8.png")

== P8820 [CSP-S 2022] 数据传输

#image("image copy 5.png")
#image("image copy 6.png")


每个点随机生成一个权值，统计所有边的出点的权值和 $"S"$。

当 $S = "所有点权值和"$ 时，极大概率是每个点作为出点恰好一次。

需要维护的变量: $"cur"_i$ 表示指向 $i$ 的出点权值和。$g_i$ 表示原始指向 $i$ 的出点权值和。

- op = 1: ...

= 最小生成树

== P3366 【模板】最小生成树

5min 读题目。就是构造一颗树连接所有点，而且边权和最小！

#image("image.png")

```cpp
4 5
1 2 2
1 3 2
1 4 3
2 3 4
3 4 3 # ans is 7
```

== con'd

Kruskal 算法: 对边按权值排序，从小到大遍历所有边，如果不形成环就加入。

例子：

\ \ \ 

怎么判断是否形成环？用并查集！

== 代码

#slide[
=== 伪代码
```cpp
用 struct edge { int x, y, w }; 存储边
按权值从小到大排序所有边
初始化每个点的并查集父亲为自己
枚举所有边:
    若边的两个端点 x, y 不在同一个集合:
        将两个集合合并 (fa[x 的祖先] = y 的祖先)
        将这条边加入答案
```
][
=== 代码
#image("image copy.png", height: 90%)
]

== P1194 买礼物

买了第 i 个礼物，再用优惠价买第 j 个礼物，等于把第 i 个点和第 j 个点连通。

创建一个零号点，向所有点连一条长度为 $A$ 的边表示你可以直接买第 i 个礼物。

买所有东西之后，你肯定会把所有点都和 0 号点连通。

而买的过程中你每次都只会买一个新物品，不会重复买。

所以最后是一颗树把所有点连通了，所以直接做最小生成树。

- 你也可以直接在原图上对小于 $A$ 的边做最小生成树，最后有几个集合就表示有几个你要单独买，答案就需要加上几个 A。

== Prim 算法

+ 输入：一个加权连通图，其中顶点集合为V，边集合为E；

+ 初始化：$V_"new"$ = {x}，其中x为集合V中的任一节点（起始点）

+ 重复下列操作，直到$V_"new"$ = V：

  + 在集合E中选取权值最小的边(u, v)，其中u为集合$V_"new"$中的元素，而v不在$V_"new"$集合当中，并且v∈V（如果存在有多条满足前述条件即具有相同权值的边，则可任意选取其中之一）；

  + 将v加入集合$V_"new"$中，统计边的权值

