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
    title: [贪心],
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

== 复习: 上节课学习: 递推与递归

=== 递推

先推出数学公式，再用数组实现。

递推公式一般是 $f_i$ 由 $f_("小于 i 的一些项")$ 推导而来。例如斐波那契数列递推公式 $f_i = f_(i - 1) + f_(i - 2)$

再比如上楼梯那道题，走到第 i 个台阶有几种走法呢？考虑任何走法的上一步要么再前一级，要么在前两级，$f_i = f_(i - 1) + f_(i - 2)$

```cpp
f[1] = 1
f[2] = 2
f[3] = f[2] + f[1]
```

=== 递归：用函数表示答案，与上面求的结果一样

```cpp
int f(int i) {
  if (i == 1) return 1;
  if (i == 2) return 2;
  return f(i - 1) + f(i - 2);
}
```

=== 记忆化递归: 优化复杂度

```cpp
int c[1010]; // 缓存，初值为 0
int f(int i) {
  if (c[i] != 0) return c[i];
  if (i == 1) return c[i] = 1;
  if (i == 2) return c[i] = 2;
  return c[i] = f(i - 1) + f(i - 2);
}
```

= 贪心

== P2240 【深基12.例1】部分背包问题

#im(0)

#im(1, h: 40%)

#tbl[
  #im(2)
]

#im(3, h: 70%)

== P1223 排队接水

#im(4)

#im(5)

#im(6, h: 25%)

#tbl[
  #pagebreak()
  #im(7)
]

== P1803 凌乱的yyy / 线段覆盖

#im(8)

#im(9, h: 60%)

#tbl[
  #im(10)
]

== P1090 [NOIP 2004 提高组] 合并果子

#im(11)

#im(13, h: 80%)

#tbl[
  #im(14)
]

== 证明（可选）

#im(12)

== 哈夫曼编码（可选）

#im(15, h: 40%)

#im(16)