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
  title: [线性状态动态规划],
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

注册洛谷账号，加 hoale85125 微信好友和微信全体成员群。

==

#image("image.png")

- 检查缴费！
- 分数线是 48.5 - 50 左右，大家保证 52+ 都能过
- 【腾讯文档】闵分信奥赛前训练
https://docs.qq.com/sheet/DWHFhb0JDYmJCb093?tab=BB08J2 如下:

#image("image copy 2.png")

= 遗留问题

- 能否使用 cin 加速，不能的话只能早点适应 scanf
- 万能头文件？

= 初赛快速训练 CSPS 2019

= DP 训练


== P2285 [HNOI2004] 打鼹鼠

- 题意 5min
- 考虑每个点可以选择哪个点作为上一个点
- f[i] 表示以第 i 个点结尾最多能打几个老鼠
- 若 i 的上一个点是 j，则 j 需要满足什么条件？

== P1103 书本整理

- 题意 5min

#pause 

- 简化问题：先按高度排好序，之后选择其中 n - k 本书，目标是使不整齐度最小
- 取第一本不用花费（花费即增加不整齐度）
- 取第二本书时，有两个选择：要么成为开头，要么接上第一本
  - 用 f[2][1] 表示选择第 2 本书，构成长度为 1 的最小不整齐度 = ?
  - f[2][2] 表示 2 本书构成长度为 2 的最小不整齐度 = ?
  
==

- 取第三本书时，有三个选择：要么成为开头，要么构成长度为 2，要么构成长度为 3
  - f[3][1] = ? 即成为开头
  - f[3][2] = ? 构成长度为 2，可从 f[2][1] 和 f[1][1] 转移
  - f[3][3] = ? 构成长度为 3，可从 f[2][2] 转移
- 第四本书
  - f[4][1] = ? 即成为开头
  - ...

== 大师 P4933

- 题意 5min

#pause

- 用 f[i][v] 表示结尾为 i，公差为 v 的等差数列个数（不包括长度为 1 的）
- 如果 i 的上个点是 j，则构成的等差数列的公差为 h[i] - h[j]
- 继承: 要么 j, i 构成一个数列，要么 j 之前公差为 h[i] - h[j] 的数列连上 i
- 转移: f[i][v] = f[j][v] + 1 其中 v = h[i] - h[j]

\

- f 第二维负数处理？
- ans?
