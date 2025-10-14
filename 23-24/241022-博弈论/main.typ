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
  title: [速通博弈论：只记结论],
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
#set list(indent: 0.8em)

#show: slides

// --- 以下为正文

==

- 发 pdf
- 登录会议
- freopen + cin 加速会用了吗
- debug 教学
- fc: `fc apple.out apple2.ans`

== P2953 [USACO09OPEN] Cow Digit Game S

#pause

- $f_i$ 表示第剩余石子数量为 $i$ 时，是否为必胜态
- $f_i$ 为 true 当且仅当 $f_i$ 可以取到一个必败态
- $f_i$ 为 false 当且仅当 $f_i$ 只能取到必胜态
- done

#pause

=== SG 函数做法

- $"SG"_i$ 表示剩余 i 颗石子的状态, $0$ 表示必败，$> 0$ 表示必胜
- $"SG"_0 = 0$; 当 $i > 0$ 时，$"SG"_i = "mex"_(k in i "的后继状态")("SG"_k)$
- 这里 $"mex"$ 表示首个未在集合中出现的自然数
- done

=== 多组游戏同时进行

- 总的 SG 值为各个独立游戏 SG 值的异或和。证明在稍后 Nim 游戏中会证。

== 打表法 Good Luck in CET-4

https://vjudge.net/problem/HDU-1847

== P2197 【模板】Nim 游戏

- SG 函数为？

== 证明

- 先考虑 1 堆

#pause

- 再考虑 2 堆
  - 如果两堆相等，后手拿与先手同样的数量 => 后手必胜
  - 如果不相等，先手可以拿到相等 => 先手必胜

#pause

- 大于 2 堆
- 结论：$x_1 \^ x_2 \^ ... \^ x_n = 0$ 时，后手必胜
  - 首先考虑如果异或和等于 $k$
    - 设 $k$ 二进制最高位为 $p$，则必然存在 $x_i$ 的最高位为 $p$
    - 将 $x_i$ 变为 $x_i \^ k$（此数第 $p$ 位被异或掉了，必然小于 $x_i$），异或和变为 0
    - 所以当异或和不为 0 时，先手总是可以让异或和变为 0（且石子数减少，最后一定会变成 0）
  - 若异或和为 0，则先手取任意数量石子都会让异或和变为非 0，后手必胜

== P5658 [CSP-S2019] 括号树

#pause

考虑以点 $i$ 结束的合法括号序列有几个。设为 $"ans"_i$

- 如果 $i$ 上是右括号，会生成新的合法括号。
  - 找到树上与 $i$ 匹配的左括号 $j$（用栈维护），则新生成的序列个数为 `1 + ans[fa[j]]`。匹配成功时，将 $j$ 出栈。
- 如果 $i$ 上是左括号，直接将 $i$ 入栈。
- 回溯过程中（即从 $i$ 回到父亲），需要恢复 $i$ 的影响，若是左括号则弹出，若是右括号则将匹配掉的括号重新加回来。

最后求树上前缀和即可。
