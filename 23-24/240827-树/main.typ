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
  title: [CSP2023 & 图论：树],
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

= CSP2023

很多算法还没学到 / 大家熟练度低，csp-s 后面三题快速讲。

== P9752 [CSP-S 2023] 密码锁

#image("image copy 2.png")

枚举所有可能的密码 $00000 ~ 99999$，一共 $10^5$ 种。看看密码与给出每个状态是否满足:

- 相差的数只有 1 个
- 或者相差的数为相邻的两个，且差额一致 
  - 数位 $a$ 和数位 $b$ 的差可用 `(a - b + 10) % 10` 来统一到 $[0, 9]$ 的范围

满足以上条件则答案加 1

== 伪代码

```cpp
读入 n 和 n 个状态
for 密码 i = 00000 to 99999:
  bool all_ok = true
  for 每个状态 d = 1 to n:
    for 数位 j = 1 to 5:
      求取每个数位的差，存储到数组里
    统计数位不同的有几位
    如果 1 位不同就 ok
    如果 2 位不同 && 不同的两位相邻 && 两位差值一样也 ok
  如果 all_ok 答案加 1
```

== P9753 [CSP-S 2023] 消消乐

#image("image copy 3.png")

=== 25 分

$n <= 10$，枚举所有子串，直接查找可消除的相邻字符，消除后继续查找，直到没有可消除的字符。复杂度枚举 $O(n^2)$，消除为 $O(n^2)$

== 50 分

$n <= 8000$

#image("image.png", height: 90%)

== 100 分

用哈希表维护栈中历史上的元素即可。

最高赞题解给出了另一个做法，但是比较难大家还没有学动态规划。

== P9754 [CSP-S 2023] 结构体

大模拟，首先保证题面每句话都读懂了，把*提示*看完，且手推样例确定理解无误。预计这道题代码量非常大，考场上可以直接跳过此题，如果有多余时间再回来写模拟题。

=== 部分分

前 5 分有 A D 性质，用数组模拟即可。

- 用 `string names[110]` 存储每个 `long` 变量的名字，第 $i$ 个变量占据 $8(i - 1) ~ 8(i - 1) + 7$ 的内存。
- op = 3，则遍历 `names[i]` 找到名字对应的变量
- op = 4 则取 `names[addr / 8]`

特殊性质 A 也很可做。拿了 15 分赶紧润

== P9755 [CSP-S 2023] 种树

首先数学上，对于每一个点确定其种下树的当天，就可以用二元一次方程算出其长成的时间。

=== $1 ~ 4$ 点

$n <= 20$ 可以试图暴力枚举.

=== 性质 a

一条链，只有一种种树方法。

=== 正解

二分答案，知道结束天数后快速算出每一点的最晚种植当天。

从叶子开始，每个点的最晚第几天种植是可算的。接下来考虑倒序构造种植顺序。最后一个种植的点一定是叶子结点，倒数第二个种植的点一定是拿走上一个点以后的叶子结点。可以种植这个点当且仅当当前天数 <= 该点要求最晚天数。直接队列模拟即可。正确性：当某一天无法填入点时，总要找一个点填入这一天，但所有剩余点都不可填入。

= 【图论2-1】树

== P5908 猫猫和企鹅

题单第一题。

复习树的基础写法。代码如下，期待各位提问。会写的直接看下一题。P1099 [NOIP2007 提高组] 树网的核

== 

#image("image copy 5.png")

== P1099 [NOIP2007 提高组] 树网的核

题单第二题。

== P1395 会议

题单第三题。

== P3379 【模板】最近公共祖先（LCA）

倍增 f[i][k] 求 $i$ 结点的 $2^k$ 级祖先。

#slide[
#image("image copy 6.png")][
#image("image copy 7.png")]

== P3128 [USACO15DEC] Max Flow P
 
倍增求 LCA，给 $s_i$ 和 $t_i$ 打标记 $1$，给 lca 和 lca 的父亲打标记 $-1$，最后求前缀和。

== B4016 树的直径

从一个点 $u$ 出发，找到最远的点 $v$，再从 $v$ 出发找到最远的点 $w$，那么 $v$ 到 $w$ 的距离就是树的直径。

== P1364 医院设置

#image("image copy 8.png")
