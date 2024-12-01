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

== 学到高精度以上的同学 [..]

== 高精度加法

#figure(image("pic/image copy 13.png", height: 40%))

- 用 `a[i]` 存储 a 从低到高第 $i$ 位的数, `b[i]` [..]
- 用 `c[i]` 存储答案从低到高第 $i$ 位的数.

```cpp
for (int i = 1; i <= n; i++) {
  c[i] += a[i] + b[i];
  c[i + 1] += c[i] / 10;
  c[i] %= 10;
}
```

== 高精度乘法

#figure(image("pic/image copy 14.png"))

#figure(image("pic/image copy 15.png"))

== 模拟：乒乓球

#figure(image("pic/image copy 12.png"))

== 题单

- 扫雷游戏
- 玩具谜题, NOIP2016 提高组
