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
  title: [区间 DP 和环状 DP],
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

#show raw.where(lang: "cpp"): it => {
  set text(12pt)
  it
}

#set text(20pt)

#show: slides

// --- 以下为正文

= 安排

国庆集训和周末的上课形式一样，不出意外是 10.5, 10.6, 10.7 下午 13:30 - 16:30，线上没有效率，故线下

#figure(image("image.png"))

== P1435 [IOI2000] 回文字串

- 10min 读题 + 思考

#pause

提示: 用 $f_(i, j)$ 表示把区间 $[i, j]$ 变成回文串的最小插入数

==

- 我们考虑要把某一个区间变成回文串
  - 如果这个区间两端是同字符，那么只需要把中间变成回文串
  - 如果这个区间两端不是同一个字符，例如左 A 右 B，那么欲把整个区间变成回文串，要么左边插 B，要么右边插 A
    - 左边插 B: 先把 B 以外的区间变成回文串，再在左边插 B
    - 右边插 A: 先把 A 以外的区间变成回文串，再在右边插 A

- 设 $f_(i, j)$ 表示把区间 $[i, j]$ 变成回文串的最小插入数
  - 初始化 $f_(i, i) = 0$
  - 如果 $s_i = s_j$，那么 $f_(i, j) = f_(i + 1, j - 1)$
  - 否则 $f_(i, j) = min(f_(i + 1, j), f_(i, j - 1)) + 1$
- 输出 $f_(1, n)$, 复杂度 $O(n^2)$

- 展示写代码

== P1775 石子合并（弱化版）

- 10min 读题 + 思考

#pause

- 用 $f_(i, j)$ 表示 $[i, j]$ 区间合并的最小代价
- 初始化 $f_(i, i) = 0$
- 如果想把 $[i, j]$ 区间合并成一堆，肯定是先合并出左边一堆，再合并出右边一堆
- 枚举分界点 $k in [i, j - 1]$，有 $f_(i, j) = min(f_(i, k) + f_(k + 1, j) + sum_(k=i)^j w_k)$
- $O(n ^ 3)$

== Zuma: CF607B

- 注意 CF 评测只能到 codeforces.com
- 10min 读题 + 思考
- 用 $f_(i, j)$ 表示 $[i, j]$ 区间消除的最小步数
- 考虑消除一个区间，只有两种情况
  - 要么左端和右端在同一次消除中被消除（要求 $a_i = a_j$）
  - 要么不同次
- 如果 $a_i = a_j$，则可以先考虑消除 $[i + 1, j - 1]$ 所需的步数。在该区间最后一次消除时，连带消除 $a_i$ 和 $a_j$，所以该方案的代价为 $f_(i + 1, j - 1)$
- 与此同时另一种方法是，分成两半分别消除，枚举 $k in [i, j - 1]$，有 $f_(i, j) = min(f_(i, k) + f_(k + 1, j))$

== P1880 [NOI1995] 石子合并

- 10min 读题 + 思考，与上一道石子合并有何不同？

#pause

- 这里需要把 $n$ 和 $1$ 视为相邻，怎么办？
- 把数组复制一遍，变成 $2n$ 个石子，然后求解每个区间 $[i, j]$ 合并的最小 / 最大代价，方法和弱化版一样
- 最后输出所有长度为 $n$ 的区间中，最小 / 最大代价
- 这就是区间 DP 转环状 DP

== P1070 [NOIP2009 普及组] 道路游戏

- 15min 读题 + 思考

#pause 

- 首先按时间平移 $a$ 数组，使得放置一个机器人走若干步后得到的收益是水平连续的一段
  - 画个二维数组理解下
- 考虑 $f_(t, i)$ 表示在时间 $t$ 时，机器人在第 $i$ 个位置*结束行走*的最大收益
- 欲求 $f_(t, i)$, 枚举上一个结束的时间点 $k in [t - p, t - 1]$，
  - 设收益二维数组为 $a
  $，前缀和 $s$（对每一行求前缀和），第 $i$ 个机器人工厂购买的成本为 $c_i$
  - $f_(t, i) = max_(k in [t - p, t - 1]) (g_k + s_(i, t) - s_(i, k) - c[(k + i - 1) % n + 1] )$，其中 $g_k$ 表示在时间 $k$ 时的最大收益
  - 这是 $O(n^3)$ 的
- 提出转移方程中与 $k$ 相关的部分，即 $g_k - s_(i, k) - c[(k + i - 1) % n + 1]$
- 用单调队列维护，复杂度 $O(n^2)$
