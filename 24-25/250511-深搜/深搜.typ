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
  config-common(frozen-counters: (theorem-counter,)), // freeze theorem counter for animation
  config-info(
    title: [深搜],
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
  #set text(font: ("Cascadia Mono", "Sarasa Term SC Nerd"))
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

== 复习: 数据结构

- `vector<int>`
- `queue<int>`
- `stack<int>`

== P2404 自然数的拆分问题

#im(0)

首先来手动模拟一下怎么拆分（拆分的数需要不断增大）

第一个数可以拆 1, 2, 3, 4 ...

- 如果拆下来的是 1
  - 那么下一个数可以拆 1, 2, 3, 4 ...
- 如果拆下来的是 2
  - 那么下一个数可以拆 2, 3, 4 ...
- 如果拆下来的是 3
  - 那么下一个数可以拆 3, 4 ...

```cpp
void dfs(int n, int pos) {
    if (n == 0) {
        // 这里是一个合法的拆分，输出
        return;
    }
    for (int i = max(1, a[pos - 1]); i <= n; i++) {
        a[pos] = i;
        dfs(n - i, pos + 1);
    }
}
```

== P1036 [NOIP 2002 普及组] 选数

#im(1)

每个数就两种情况：要么选，要么不选。这两种情况都会产生分支.

```cpp
void dfs(int p, int num, int sum) {
    if (num == k) {
        if (prime(sum)) {
            ans++;
        }
        return;
    }
    if (p == n + 1) {
        return;
    }
    dfs(p + 1, num + 1, sum + a[p]);
    dfs(p + 1, num, sum);
}
```

== P1706 全排列问题

#im(2)

首先手动模拟一下全排列的过程.

在搜索的过程中，可用一个数组来标记每个数字是否被使用过.

我们要在没有使用过的数字中枚举所有可能的情况.

==

- `a[1]` 填 `1`
  - #pause `used: 1`
  - #pause `a[2]` 填 `2`
    - #pause `used: 1, 2`
    - `a[3]` 填 `3`
  - #meanwhile `a[2]` 填 `3`
    - `used: 1, 3`
    - `a[3]` 填 `2`
#meanwhile
#meanwhile
- `a[1]` 填 `2`
- `a[1]` 填 `3`

== P1605 迷宫

#im(5)

用二维数组标记每一个点是否被访问过.

== P1219 [USACO1.5] 八皇后 Checker Challenge

#im(3)

#im(4)

逐行填写。每次填下一个新的棋子，都检查之前是否有棋子和它冲突.
