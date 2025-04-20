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
    title: [排序],
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
// [my.end]

#title-slide()

== Outline <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 1em))

== 复习

=== 指针（地址）

#figure(image("img/image.png"))

=== 数组元素的地址还有一种写法

#figure(image("img/image copy.png", height: 40%))

=== sort 方法

#emp[- sort(开头位置地址，结尾位置的后一个地址);]
- 第一个参数：  要排序的开头地址
- 第二个参数：  要排序的结尾的下一个地址
- 例如，当我们想对数组中a[0]到a[8]这9个元素排序时，可以调用 `sort(a,a+9)`

=== 示例用法

#figure(image("img/image copy 2.png", height: 50%))

== P1271 选举学生会

#figure(image("img/image copy 3.png", height: 100%))

== 使用 sort 完成

#hint[#text(fill: white)[Dev C++ 中演示]]

== 手动实现，不用 sort?

可以使用数组记录每个人获得了几票，再从小到大输出.

#figure(image("img/image copy 4.png", height: 60%))

#figure(image("img/image copy 5.png", height: 90%))

== P1177 【模板】排序

#figure(image("img/image copy 6.png", height: 100%))

#emp[由于 $a_i$ 的范围较大，不能使用计数排序（数组下标开不了 $10^9$）]

== 解法1：选择排序

#figure(image("img/image copy 7.png", height: 100%))

- 动图演示：https://images2017.cnblogs.com/blog/849589/201710/849589-20171015224719590-1433219824.gif

- #hint[#text(fill: white)[复习：如何在数组中找到最小数字？如何交换元素？]]
- #hint[#text(fill: white)[完成插入排序]]

== 解法2：冒泡排序

- 尝试先把最大的一个放在最后！首先比较第 1、第 2 个数，将较大的数放在第 2 个位置；然后比较第 2、第 3 个数，将较大的数放在第 3 个位置..
#figure(image("img/image copy 8.png", height: 80%))

- https://images2017.cnblogs.com/blog/849589/201710/849589-20171015223238449-2146169197.gif

- #hint[#text(fill: white)[先写一次冒泡，再写两次冒泡..]]

== 解法3：插入排序

- #figure(image("img/image copy 9.png", height: 80%))

- https://images2017.cnblogs.com/blog/849589/201710/849589-20171015225645277-1151100000.gif

== 函数写法

- 用函数包装排序算法！

== 复杂度分析

- 选择排序、冒泡排序、插入排序的时间复杂度都是 $O(n^2)$
  - 观察：每遍历一遍数组，时间复杂度是 $O(n)$
  - 但是，每次排序都要遍历 $n$ 次，所以总的时间复杂度是 $O(n^2)$

- 更快的排序？之后会讲解. sort() 函数就是一种更快的排序，但我们不光要会用，未来还要会自己实现.
- #hint[#text(fill: white)[尝试用上方排序通过排序的部分分数]]

== P1059 [NOIP 2006 普及组] 明明的随机数

#figure(image("img/image copy 10.png", height: 100%))

== 自定义排序

- 使用 sort() 函数时，可以自定义排序规则
- 例如从大到小排序
- #hint[#text(fill: white)[使用 bool cmp() 自定义排序规则]]
- #hint[#text(fill: white)[结构体排序规则]]

== P1093 [NOIP 2007 普及组] 奖学金

- https://www.luogu.com.cn/problem/P1093
