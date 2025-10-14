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
  title: [初赛备考],
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

= 新人提示

- 加微信群了吗
- 准考证下载打印了吗
- 今天模拟赛做的不好的同学，来拿纸质真题这两天空下来继续做
- 9月20日周五放学后我在机房答疑

emm

- 初赛成绩过一个星期左右出，过的同学继续参加复赛训练，每周末 13:30 - 16:30
- 争取给大家减免作业冲刺集训

==

#figure(image("image.png"))

= 模拟赛

- 马上发卷子，2h 后交换批改，剩下几十分钟大家提问我讲解
- 不开电脑，不查资料，到时候 https://www.luogu.com/article/43dzfwr8 可查看这份解析
- 难度略低于 CSP-S 真题，做到 60+ 才算合格
- 做题顺序：选择 => 阅读程序前两题 => 完善程序第一题 => 其他
- 大题先看选项中能否获得提示
- 不会做就凭直觉猜，获得 $1 / 4$ 分数

= 开始

#slide[
#figure(image("image copy.png"))
][
#figure(image("image copy 2.png"))
]

==

#slide[
#figure(image("image copy 3.png"))
][
#figure(image("image copy 4.png"))
]

==

#slide[
#figure(image("image copy 5.png"))
][
]

==

#slide[
#figure(image("image copy 6.png"))
][
#figure(image("image copy 7.png"))
]

==

#slide[
#figure(image("image copy 8.png"))
][
]

==

#slide[
#figure(image("image copy 12.png"))
][
#figure(image("image copy 9.png"))
#figure(image("image copy 13.png", height: 50%))
]

==

#slide[
#figure(image("image copy 14.png"))
][
#figure(image("image copy 15.png"))
#figure(image("image copy 16.png", height: 50%))
]

= 答案

== omg

No!!

==

- ACBCB
- DADCB
- CAABD
- TFFFBD
- TFTFDC
- TTTFB (No answer, fill A)
- BDBAD
- DCBBA
