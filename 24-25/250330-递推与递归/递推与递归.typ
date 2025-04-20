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
    title: [递推与递归],
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

== 复习: 上节课学的是枚举

- 其实就是用 for 循环列举所有可能的情况
- `memset` 函数快速清空数组
  - `memset` 的真实机制
- 用 n 位二进制数表示选择，用二进制与运算提取

== P1255 递推：用数组存储一系列答案

#im(0)

#im(1, h: 80%)
- 注意：本题最大的答案超过 long long 范围，需要用高精度加法才能拿满分.
- 程序填空

== P1002 过河卒

- https://www.luogu.com.cn/problem/P1002
- #im(2, h: 80%)

#pagebreak()

=== 用 $f_(i, j)$ 表示到达 第 $i$ 行第 $j$ 列的路径数量

- $f_(0, 0)$ = ?
- $f_(1, 0)$ = ?
- $f_(1, 1)$ = ?
- 被马控制的点的路径数是多少？

=== 如何表示被马控制的位置？

- 实验

== P1044 栈（难度 up）

- https://www.luogu.com.cn/problem/P1044
- 首先要理解什么是栈.
- 用 $f_i$ 表示 i 个元素入栈并出栈的不同方案数

#pagebreak()

- 我们假设第 k 个元素是最后一个出栈的，那么说明 k 在栈底。
  - 那么在加入 k 之前，k 以前的元素必须全部出栈。否则 [...]
  - 然后加入 k。
  - 然后 k 之后的元素必须全部出栈才能让 k 出栈。
- 也就是说 k 之前的元素完成了 "k - 1 个元素的入栈 + 出栈"，方案数为 $f_(k - 1)$
- 而且 k 之后的元素完成了 "n - k 个元素的入栈 + 出栈"，方案数为 $f_(n - k)$
- 所以这种情况下的方案数就是 $f_(k - 1) times f_(n - k)$

#lin

- 对于不同的 k 元素，他们都有可能是最后一个出栈的元素
- 所以总方案数为 $f_(0) times f_(n - 1) + f_(1) times f_(n - 2) + ... + f_(n - 1) times f_0$

== P1255 递归：用函数表示答案

- 回到 P1255 数楼梯.
- 我们刚才已经知道 $f_n = f_(n - 1) + f_(n - 2)$，刚才用数组表示答案
- 现在我们换一种方式，用函数 `int f(int n)` 来求答案。
- 在 `f()` 函数中我们可以再次调用 `f()` 函数来求解更小的子问题.

```cpp
int f(int n) {
    if (n == 1) return 1;
    if (n == 2) return 2;
    return f(n - 1) + f(n - 2);
}
```

- 思考：函数 f 会调用几次？

== P1028: 递归

- https://www.luogu.com.cn/problem/P1028

#pagebreak()

#im(3)

#im(4)

- 什么是递归？自己调用自己就是递归.

== P1928 外星密码

- 前置知识点：`while (n--)`
- 复习：`string` 最简单的用法
- https://www.luogu.com.cn/problem/P1928
- 思考: AAAABCDCDCDCD 可以被压缩哪几种形式？

```cpp
#include <bits/stdc++.h>
using namespace std;
string solve() {
    string ans;
    char c;
    while (cin >> c) {
        if (c == '[') {
            int num; cin >> num; // 这个会读入有效的数字
            string x = solve(); // 进入下一层递归
            while (num--) ans += x; // 复制 num 次
        } else if (c == ']') {
            return ans; // 返回上一层递归
        } else {
            ans += c;
        }
    }
    return ans;
}
int main() {
    cout << solve();
    return 0;
}
```