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

= 安排

今明两天国庆集训 13:00 - 17:00

今天包含区间 DP 和杂题选讲两部分，明天是模拟赛，带大家熟悉考试真实环境.

== P1775 石子合并（弱化版）

- 10min 读题 + 思考

#pause

- 用 $f_(i, j)$ 表示 $[i, j]$ 区间合并的最小代价
- 初始化 $f_(i, i) = 0$
- 如果想把 $[i, j]$ 区间合并成一堆，肯定是先合并出左边一堆，再合并出右边一堆
- 枚举分界点 $k in [i, j - 1]$，有 $f_(i, j) = min(f_(i, k) + f_(k + 1, j) + sum_(k=i)^j w_k)$
- $O(n ^ 3)$

== Zuma: CF607B

- 注意 CF 评测只能到 codeforces.com
- 10min 读题 + 思考
- 用 $f_(i, j)$ 表示 $[i, j]$ 区间消除的最小步数
- 考虑消除一个区间，只有两种情况
  - 要么左端和右端在同一次消除中被消除（要求 $a_i = a_j$）
  - 要么不同次
- 如果 $a_i = a_j$，则可以先考虑消除 $[i + 1, j - 1]$ 所需的步数。在该区间最后一次消除时，连带消除 $a_i$ 和 $a_j$，所以该方案的代价为 $f_(i + 1, j - 1)$
- 与此同时另一种方法是，分成两半分别消除，枚举 $k in [i, j - 1]$，有 $f_(i, j) = min(f_(i, k) + f_(k + 1, j))$

== P1880 [NOI1995] 石子合并

- 10min 读题 + 思考，与上一道石子合并有何不同？

#pause

- 这里需要把 $n$ 和 $1$ 视为相邻，怎么办？
- 把数组复制一遍，变成 $2n$ 个石子，然后求解每个区间 $[i, j]$ 合并的最小 / 最大代价，方法和弱化版一样
- 最后输出所有长度为 $n$ 的区间中，最小 / 最大代价
- 这就是区间 DP 转环状 DP


== P1435 [IOI2000] 回文字串

- 10min 读题 + 思考

#pause

提示: 用 $f_(i, j)$ 表示把区间 $[i, j]$ 变成回文串的最小插入数

==

- 我们考虑要把某一个区间变成回文串
  - 如果这个区间两端是同字符，那么只需要把中间变成回文串
  - 如果这个区间两端不是同一个字符，例如左 A 右 B，那么欲把整个区间变成回文串，要么左边插 B，要么右边插 A
    - 左边插 B: 先把 B 以外的区间变成回文串，再在左边插 B
    - 右边插 A: 先把 A 以外的区间变成回文串，再在右边插 A

- 设 $f_(i, j)$ 表示把区间 $[i, j]$ 变成回文串的最小插入数
  - 初始化 $f_(i, i) = 0$
  - 如果 $s_i = s_j$，那么 $f_(i, j) = f_(i + 1, j - 1)$
  - 否则 $f_(i, j) = min(f_(i + 1, j), f_(i, j - 1)) + 1$
- 输出 $f_(1, n)$, 复杂度 $O(n^2)$

- 展示写代码

== P1070 [NOIP2009 普及组] 道路游戏

- 15min 读题 + 思考

#pause 

- 首先按时间平移 $a$ 数组，使得放置一个机器人走若干步后得到的收益是水平连续的一段
  - 画个二维数组理解下
- 考虑 $f_(t, i)$ 表示在时间 $t$ 时，机器人在第 $i$ 个位置*结束行走*的最大收益
- 欲求 $f_(t, i)$, 枚举上一个结束的时间点 $k in [t - p, t - 1]$，
  - 设收益二维数组为 $a
  $，前缀和 $s$（对每一行求前缀和），第 $i$ 个机器人工厂购买的成本为 $c_i$
  - $f_(t, i) = max_(k in [t - p, t - 1]) (g_k + s_(i, t) - s_(i, k) - c[(k + i - 1) % n + 1] )$，其中 $g_k$ 表示在时间 $k$ 时的最大收益
  - 这是 $O(n^3)$ 的
- 提出转移方程中与 $k$ 相关的部分，即 $g_k - s_(i, k) - c[(k + i - 1) % n + 1]$
- 用单调队列维护，复杂度 $O(n^2)$

== P1220 关路灯

#pause

那么我们把f[i][j]记为当从i到j的灯都熄灭后剩下的灯的总功率。

再进一步：f[i][j][0]表示关掉i到j的灯后，老张站在i端点，f[i][j][1]表示关掉[i][j]的灯后,老张站在右端点

== P1803 凌乱的yyy / 线段覆盖

选出不重叠的最多的线段.

#pause

=== 贪心！

从左到右考虑所有的线段.

两个线段如果都能选，如果一个线段右端点更靠左，哪个更优？

你结束得越早，对后面就越有利，所以右端点更靠左的线段更优.

我们按照右端点排序，依次尝试选线段，如果上一个线段的结束位置小于等于当前线段的左端点，则选当前线段.
