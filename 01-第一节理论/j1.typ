// [typst 0.13]
#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.4" as fletcher: node, edge
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion

#import "@preview/grayness:0.2.0": *

// #let data = read("img/ignoreme-19.jpg", encoding: none)

// #set page(background: transparent-image(data, alpha: 50%, width: 100%, height: 100%))

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  // config-common(handout: true),
  config-common(frozen-counters: (theorem-counter,)), // freeze theorem counter for animation
  config-info(
    title: [NOIP 初赛入门],
    subtitle: [],
    author: [方俊杰.SJTU],
    date: datetime.today(),
    institution: [交附闵分],
    logo: emoji.school,
  ),
)

// [my]
// [my.config]
#let tea = false
#let tbl = it => {
  if tea {
    it
  }
}

// [my.heading]
#show heading.where(level: 1): set heading(numbering: numbly("{1}.", default: "1.1"))

// [my.code]
#show raw.where(lang: "cpp"): it => {
  set text(12pt)
  it
}
#show raw.where(block: false): it => box(
  fill: rgb(248, 248, 248),
  outset: 4pt,
  radius: 3pt,
  stroke: 0.5pt + gray,
  it,
)
#show raw.where(block: true): it => box(
  fill: rgb(248, 248, 248),
  outset: 8pt,
  radius: 3pt,
  stroke: 0.5pt + gray,
  it,
)
#show raw: it => box()[
  #set text(font: ("0xProto Nerd Font Mono"))
  #it
]

// [my.text]
#set text(20pt)
#set text(font: "Microsoft YaHei")
#show strong: set text(weight: 900) // Songti SC 700 不够粗

#set list(indent: 0.8em)
#show link: underline

// [my.util]
#let box-img(img, width, radius) = {
  box(
    image(img, width: width),
    radius: radius,
    clip: true,
  )
}

#let grids(imgs, col: auto) =  {
    figure(
      grid(
        columns: col,
        rows: auto,
        gutter: 3pt,
        ..imgs,
      ),
  )
}

#let emp = it => {
  strong(text(fill: red)[#it])
}

#let alert(body, fill: yellow) = {
  // set text(fill: white)
  rect(
    fill: fill,
    inset: 8pt,
    radius: 4pt,
    [*注意:\ #body*],
  )
}

#let hint(body, fill: blue) = {
  rect(
    fill: fill,
    inset: 8pt,
    radius: 4pt,
    [*#body*],
  )
}

#let lin = line(length: 100%)
#let im(p, h: auto) = {
  if p == 0 {
    figure(image("img/image.png", height: h))
  } else if p == 1 {
    figure(image("img/image copy.png", height: h))
  } else {
    figure(image("img/image copy " + str(p) + ".png", height: h))
  }
}
// [my.end]

#title-slide()

== 目录 <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 1em))

== 算法竞赛的目的

=== 什么是算法？


#grids(
  (im(1, h: 50%), im(7, h: 50%)),
  col: 2
)
#grids(
  (im(8, h: 50%), im(9, h: 50%)),
  col: 2
)

=== 算法竞赛: NOI全国青少年信息学奥林匹克竞赛（系列）

- 综合算法，解决一些短小但困难的问题，基本都是 C++ 写

=== You WILL GET:

- OI 国家集训队可保送清北计算机系
- 高分可参加清北冬令营，清北强基计划 / 复交综测*免试*或面试*满分*
- 大学几乎所有理工专业都要求很高程序能力

=== #strike[获得成功人生]

== 考试时间表

- 26年9月底: 笔试.
- 26年10月底：CSP-S 复赛. 奖项含金量较高.
- 26年11月底：NOIP，含金量高. 较高分可报名清北冬令营 / APIO / CTSC.
- 寒假: 冬令营
- 27年3月：上海市队选拔
- 27年7月：NOI

=== 集训时间

- 学期中：周二周日集训
- 寒暑假：模拟赛

== 自学教材

加微信群了吗！

=== 夯
- 学会百度算法解析 / 看洛谷题解学习
- oi-wiki.org
- 问老师

=== NPC
- 深入浅出程序竞赛入门篇/进阶篇
- C++ 信奥一本通
- 算法竞赛入门经典

=== 拉
- C++ 从入门到精通

== 二进制

#grids((im(10, h: 40%), im(11, h: 40%)), col: 2)
#lin
#grids((im(12, h: 40%), im(13, h: 40%)), col: 2)

#im(14)

#im(15)

#grids((im(16, h: 40%), im(17, h: 40%)), col: 2)

#lin

#im(18, h: 40%)

#im(19, h: 40%)

#im(20)

#pagebreak()

#im(21)

#im(22)

== 二进制转十进制

计算 $1011$ 对应的十进制数.

计算 $101001$ 对应的十进制数.

== 十进制转二进制

=== 短除法

#im(23)

== 比特和字节

#im(24, h: 40%)

#im(25, h: 40%)

能够表示的最大数字?

== 计算机存储的数字

