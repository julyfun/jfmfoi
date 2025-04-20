// [typst 0.13]
#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.4" as fletcher: node, edge
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  // config-common(handout: true),
  config-common(frozen-counters: (theorem-counter,)),  // freeze theorem counter for animation
  config-info(
    title: [暴力枚举],
    subtitle: [],
    author: [方俊杰.SJTU],
    date: datetime.today(),
    institution: [交附闵分],
    logo: emoji.school,
  ),
)

// [my]
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
  it
)
#show raw.where(block: true): it => box(
  fill: rgb(248, 248, 248),
  outset: 8pt,
  radius: 3pt,
  stroke: 0.5pt + gray,
  it
)
#show raw: it => box()[
  #set text(font: ("Cascadia Mono", "Sarasa Term SC Nerd"))
  #it
]
  
// [my.text]
#set text(20pt)
#set text(
  font: ("Microsoft YaHei")
)
#show strong: set text(weight: 900)  // Songti SC 700 不够粗

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
#let im(p, h: 100%) = {
  figure(image("img/" + p + ".png", height: h))
}
// [my.end]

#title-slide()

== Outline <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 1em))

== 复习

===

- sort() 基础排序
- 选择排序
- 冒泡排序
- 插入排序
- sort() 结构体排序

== 循环枚举

- 简单来说就是枚举所有可能的组合

== P2241 统计方形（数据加强版）

#im("image")

== 三种方法

+ 枚举左上角和右下角
+ 枚举边长 a x b
+ 所有矩形数量确定，再确定所有方形

== P2089 烤鸡

#im("image copy")

#im("image copy 2")

== 复习

- 统计二进制中的 1 的个数
- 如何用 n 位二进制数表示选择 n 个元素中的若干个？
  - 实践：输出选中的那几个数
- 判断质数的函数

== P1036 [NOIP 2002 普及组] 选数

#im("image copy 4")

== 复习

- 用数组 `used` 记录每个数是否被选过
- 用 `/10` 和 `%10` 来拆分数字

== 新知识点

- 使用 `memset` 快速初始化数组

== P1618 三连击（升级版）

#im("image copy 3")

- 直接暴力枚举 1000 \* 1000 \* 1000 个可能情况？
- 优化: 只需要枚举第一个！

== 新知识点

=== 排列
- 1 \~ n 的全排列有几个？最后一个是什么？

=== 函数 `next_permutation`

```cpp
next_permutation(a + 1, a + n + 1);
```

- 实践：这个函数会返回一个布尔值，表示是否存在下一个排列

== 使用 `next_permutation` 枚举所有排列，完成三连击

...