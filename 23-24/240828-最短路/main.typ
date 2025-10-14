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
  title: [CSP2021初赛和最短路专题],
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

= 初赛

#slide[
#image("image copy 5.png")
][
#image("image copy 6.png")
]

== T2

#slide[
#image("image copy 7.png")
][
#image("image copy 8.png")
]

== con'd

#image("image copy 9.png")

== T3

#slide[
#image("image copy 10.png")
][
#image("image copy 11.png")
]

== con'd

#image("image copy 12.png")

== T4

#image("image copy 14.png")

== con'd

#slide[
#image("image copy 13.png")
][
#image("image copy 15.png")
]

== P3371 【模板】单源最短路径（弱化版）

#slide[
=== 问题是什么？
#image("image copy.png", height: 50%)
][
=== 数据长啥样？
```
4 6 1
1 2 2
2 3 2
2 4 1
1 3 5
3 4 3
1 4 4
```
]

== con'd

#slide[
=== 思路
#image("image copy 2.png")
这个算法叫做 dijkstra
][
#image("image copy.png", height: 50%)
]

== con'd

#slide[
=== 伪代码
```cpp
初始化 dis 数组为极大值
起点的 dis 设置为 0
执行 n 次：
    遍历每一个点，求出未被拓展过的距离最近的点 u
    将 u 标记为拓展过了
    遍历 u 的所有邻接点 v：
        若从 u 走到 v 可以缩短 v 的距离，则更新 dis[v]
```
][
=== 代码
#image("image copy 4.png")
复杂度: $O(n^2)$
]

== 多源最短路: P2910 [USACO08OPEN] Clear And Present Danger S

#slide[
给出带权有向图和序列 $A_n$，求 $A_1$ 到 $A_2$ 最短路，$A_2$ 到 $A_3$ 最短路，...，$A_{n-1}$ 到 $A_n$ 最短路的和。

要是能直接先求出任意两点之间的最短路，就很方便了。
][
=== 样例

```
3 4 
1 
2 
1 
3 
0 5 1 
5 0 2 
1 2 0 
```

输出 7
]

== con'd

直接以每个点为起点做 Dijsktra 也可以，复杂度 $O(n^3)$

这里要讲一个新做法，Floyd

用 $f[x][y]$ 表示从 $x$ 到 $y$ 的最短路。一开始把直接连边的 $f[x][y]$ 初始化为边权，不连边的 $f[x][y]$ 初始化为无穷大。

随后考虑以每个点 $k$ 作为中继点，更新 $i$ 到 $j$ 的最短路。若 $i$ 到 $k$ 有一条路，$k$ 到 $j$ 有一条路，那么试图用 $f[i][k] + f[k][j]$ 来更新 $f[i][j]$。

做完了！

== con'd

#slide[
```cpp
for (k = 1; k <= n; k++)
  for (x = 1; x <= n; x++)
    for (y = 1; y <= n; y++)
      f[x][y] = min(f[x][y], f[x][k] + f[k][y]);
```
时间复杂度: $O(n^3)$ 空间复杂度: $O(n^2)$

正确性：当考虑了前 $k$ 个点时，所有以前 $k$ 个点作为中继点的最短路都一定已经被找到了。考虑任意两点 $x$ $y$ 的最短路如何被依次求解的...
]

== P1629 邮递员送信

求 1 到所有点和所有点到 1 的最短路.

floyd 复杂度爆炸。

如何求后者？从 $x$ 到 $1$ 的路径，可以看作从 $1$ 到 $x$ 沿着反向边的走的路径。

对全图建反向边，再跑一次 dijkstra 即可。
