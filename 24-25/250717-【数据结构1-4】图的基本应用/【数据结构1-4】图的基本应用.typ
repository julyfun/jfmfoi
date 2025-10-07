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
    title: [集合],
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
  #set text(font: ("Cascadia Mono", "Sarasa Term SC Nerd", "Zed Mono Extended"))
  #it
]

// [my.text]
#set text(20pt)
#set text(font: "Microsoft YaHei")
#show strong: set text(weight: 900) // Songti SC 700 不够粗

#set list(indent: 0.8em)
#show link: underline

// [my.util]
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

== Outline <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 1em))

== 复习: vector

=== vector

```
vector<int> a;
```

=== 一系列的 vector ?

== 图的基本概念

#slide[
每个建筑物称为顶点，建筑物之间直接连通的道路称为边。在图18-2中，顶点集合是{1,2,3,4}，而边的集合是{(1,2),(1,3),(1,4),(2,4)}。
无向图中，一个结点连边的条数称作这个结点的度数。
随着校园的开发，食堂和图书馆之间修了一条新路。同时，经过测量，可以得到经过每段道路需要消耗的时间。更新后第二幅地图如图18-3所示。
][
#im(0)
]

