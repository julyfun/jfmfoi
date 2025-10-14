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
  title: [CSP2020初赛和动态规划],
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

= CSP2020 初赛

解析: https://blog.csdn.net/lan_in/article/details/139150964

== 0

#image("image copy.png")
#image("image copy 2.png")
#image("image copy 3.png")

== 1

#slide[
#image("001.jpeg")
][
#image("002.jpeg")
]

== 2

#slide[
#image("003.jpeg")
][
#image("004.jpeg")
]

== 3

#slide[
#image("005.jpeg")
][
#image("006.jpeg")
]

== 4

#slide[
#image("007.jpeg")
][
#image("008.jpeg")
]

== 5

#slide[
#image("009.jpeg")
][
#image("010.jpeg")
]

== 6

#slide[
#image("011.jpeg")
][
#image("012.jpeg")
]

== 7

#slide[
#image("013.jpeg")
][
#image("014.jpeg")
]

== 8

#slide[
#image("015.jpeg")
]

不错捏

= DP

【动态规划1】动态规划的引入 点击参与作业!

== P1216 [IOI1994]数字三角形 Number Triangles

永远的经典！这题太简单了，不讲。

#slide[
#image("image.png")
][
`f[i][j]` 表示从顶点到 `(i, j)` 的最大路径和。
]

== B3637 最长上升子序列

用 `f[i]` 表示以 `a[i]` 结尾的最长上升子序列的长度。

如何继承？

`f[i] = max(f[j] + 1)`，其中 `j < i` 且 `a[j] < a[i]`。

- 模拟样例：`1 2 4 1 3 4`

== P2196 [NOIP1996 提高组] 挖地雷

观察题目发现连边都是正向的，用 `f[i]` 表示以 `i` 结尾的最大连边和。
