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
    title: [数据结构 I],
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

== 复习: 上节课学习: 二分法

=== 猜数游戏

=== 代码写法

- `l, r, mid` 写法
- `lower_bound(a + 1, a + n, x) - a` 找第一个大于等于 x 的下标
- `upper_bound(a + 1, a + n, x) - a` 找第一个大于 x 的下标

= 动态数组 vector

== 【深基15.例1】询问学号

#im(0)

- `vector<int> a;` 建立一个初始长度为 0 的动态数组.
  - 类似于 `int a[N];` 但是长度不固定.
- `a.push_back(x);` 在数组末尾添加一个元素 x.
- `a.size();` 返回数组的长度.
- `a.resize(n);` 将数组长度改为 n.
- `a[i];` 访问第 i 个元素. 和数组一样.

- #hint[对比展示数组和 vector 写法]

== P3613 【深基15.例2】寄包柜

#im(1)

=== 对比
  - `vector<int> a[N];`
  - `vector<vector<int> > a;`

= 栈 stack

==

#im(2)

#im(3)

== 手写栈

```cpp
int top = 0;
char st[N];

int main() {
    st[++top] = 'a';
    st[++top] = 'b';
    st[++top] = 'c'; // 现在是一个高度为 3 的栈，从底到顶是 a b c

    cout << top << endl; // 输出栈的高度 3

    cout << st[top] << endl; // 输出栈顶元素 c
    top--;
    cout << st[top] << endl; // 输出 b
    top--;
    cout << st[top] << endl; // 输出 a
    return 0;
}

```

#im(4)

=== 同时实现这两个版本的栈

== 前置知识点：手动解析数字

逐字符处理数字：`123`

逐字符处理点分隔的数字 `123.8.10.100`

== 括号匹配

#im(5)

=== 逐步完成

== 后缀表达式: 把运算符放在数字的后面

#im(6)

#hint[转换表达式测试]

#im(7)

#slide[
```cpp
#include <bits/stdc++.h>
using namespace std;
int main() {
    int cur = 0;
    int st[110], top = 0;
    while (true) {
        char c;
        scanf("%c", &c);
        if (c == '@') {
            break;
        }
        if ('0' <= c && c <= '9') {
            cur = cur * 10 + c - '0';
        }
        if (c == '.') {
            st[++top] = cur;
            cur = 0;
        } else if (c == '+') {
            st[top - 1] = st[top] + st[top - 1];
            top--;
```
][
```cpp
        } else if (c == '-') {
            st[top - 1] = st[top - 1] - st[top];
            top--;
        } else if (c == '*') {
            st[top - 1] = st[top - 1] * st[top];
            top--;
        } else if (c == '/') {
            st[top - 1] = st[top - 1] / st[top];
            top--;
        }
    }
    printf("%d\n", st[1]);
    return 0;
}
```
]

= 队列 queue

==

#im(8)
#im(9)

=== 编写程序模拟这个过程

=== 对比 STL 和手写

== 约瑟夫问题

#im(10)
