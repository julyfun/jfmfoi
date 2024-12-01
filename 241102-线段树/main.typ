#import "@preview/touying:0.4.2": *
#import "@preview/cetz:0.2.2"
#import "@preview/ctheorems:1.1.2": *
#import "@preview/fletcher:0.5.0" as fletcher: diagram, node, edge, shapes

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

// Register university theme
// You can replace it with other themes and it can still work normally
#let s = themes.university.register(aspect-ratio: "16-9")

// Set the numbering of section and subsection
#let s = (s.methods.numbering)(self: s, section: "1.", "1.1")

// Set the speaker notes configuration
// #let s = (s.methods.show-notes-on-second-screen)(self: s, right)

//sum[my]

#set text(
  font: ("New Computer Modern", "Songti SC")
)
#show strong: set text(weight: 900)  // Songti SC 700 不够粗

// Global information configuration
#let s = (s.methods.info)(
  self: s,
  title: [线段树],
  subtitle: [],
  author: [方俊杰.SJTU],
  date: datetime.today(),
  institution: [交附闵分 OI],
)

// Pdfpc configuration
// typst query --root . ./example.typ --field value --one "<pdfpc-file>" > ./example.pdfpc
#let s = (s.methods.append-preamble)(self: s, pdfpc.config(
  duration-minutes: 30,
  start-time: datetime(hour: 14, minute: 10, second: 0),
  end-time: datetime(hour: 14, minute: 40, second: 0),
  last-minutes: 5,
  note-font-size: 12,
  disable-markdown: false,
  default-transition: (
    type: "push",
    duration-seconds: 2,
    angle: ltr,
    alignment: "vertical",
    direction: "inward",
  ),
))

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

// Extract methods
#let (init, slides, touying-outline, alert, speaker-note) = utils.methods(s)
#show: init

#show strong: alert

// Extract slide functions
#let (slide, empty-slide) = utils.slides(s)

#show raw.where(lang: "cpp"): it => {
  set text(12pt)
  it
}

#set text(20pt)
#set list(indent: 0.8em)

#show: slides

// --- 以下为正文

- NOIP 报名了吗
- CSPS 出成绩: 大约 11.5 下午
- 省三进 NOIP

== 线段树

- 区间加 & 区间查询！
- 看题目
#pause
- 暴力做法：查询和修改都是 $O(n)$ 的
- 线段树用一颗树来维护各个区间的权值和，例如长度为 8 的区间会被转换为以下线段树：

#figure(image("image.png", height: 50%))

== 线段树

考虑大小为 $8$ 的数组 $a = {1, 5, 2, 6, 3, 7, 4, 8}$，将其转换为线段树.

根结点编号 1，存储 $[1, 8]$ 区间，每个结点最多两个儿子，左儿子编号为 $2i$，右儿子编号为 $2i+1$. 分别存储左右两半区间（若区间长度为 1 则没有儿子）

#figure(image("image copy 2.png", height: 60%))

== 怎么用代码实现呢？

用数组 $"sum"$ 来表示我们的线段树，$"sum"_i$ 表示编号为结点 $i$ 所代表区间的权值和。

从 $"sum"_1$ 开始，从上往下建立:

```cpp
void build(int k, int l, int r) {
    // 对 [l, r] 区间建立线段树，当前结点编号为 k
    if (l == r) { // 长度为 1 没有儿子
        sum[k] = a[l]; // 区间和就是原数组 a 对应位置的值
        return;
    }
    int mid = (l + r) / 2;
    // 先建立左右两半
    build(k * 2, l, mid);
    build(k * 2 + 1, mid + 1, r);
    sum[k] = sum[k * 2] + sum[k * 2 + 1]; // 我的和等于左右两半的和
}
```

== 区间加

#figure(image("image copy 3.png", height: 50%))

比如*操作* $[2, 6]$ 区间，*每个元素*加 $2$，我们可以从根结点开始，递归地向下更新。
- 根节点*对应区间*为 $[1, 8]$，没有被*操作区间* $[2, 6]$ 完全覆盖，所以我们需要向下递归
  - 每个区间如果没有完全被覆盖，那么先更新左右儿子，再把自己的和更新为左右儿子的和
  - 每个区间如果被完全覆盖（每个元素都要加），那么很容易更新自己的和 $"sum"[k] "+=" (r - l + 1) times x$

== 区间加

```cpp
void modify(int k, int l, int r, int x, int y, ll t) {
    // 在 k 号结点上（对应区间 l ~ r），要加的区间是 x ~ y，每个元素加 t
    // 那么要如何处理 k 号结点呢？
    if (r < x || y < l) { // k 号结点跟操作区间完全没关系
        return;
    }
    if (x <= l && r <= y) { // 完全覆盖
        sum[k] += (r - l + 1) * t;
        return; // 真的不需要再往下递归了？
    }
    // 以下是部分覆盖
    int mid = (l + r) / 2;
    modify(k * 2, l, mid, x, y, t); // 操作区间 x ~ y 传下去，儿子代表区间是 l ~ mid
    modify(k * 2 + 1, mid + 1, r, x, y, t);
    sum[k] = sum[k * 2] + sum[k * 2 + 1];
}
```

问题来了，所有儿子都要处理吗？
- 如果儿子都要处理，那复杂度就变成了 $O(n)$!
- 所以引入懒惰标记：如果一个结点的对应区间全部都要加（即被操作区间 $[x, y]$ 完全覆盖），就先不处理左右儿子，未来再处理。用 `lazy[k]` 表示 $k$ 号结点的孩子的每个元素都要加 `lazy[k]`，但是孩子还没有处理:

```cpp
void modify(int k, int l, int r, int x, int y, ll t) {
    if (r < x || y < l) {
        return;
    }
    if (x <= l && r <= y) { // 完全覆盖
        sum[k] += (r - l + 1) * t;
```
#highlight(```cpp
        lazy[k] += t; // <----- ++++++ 懒惰标记
```)
```cpp
        return;
    }
    // 以下是部分覆盖
    int mid = (l + r) / 2;
    modify(k * 2, l, mid, x, y, t); // 操作区间 x ~ y 传下去，儿子代表区间是 l ~ mid
    modify(k * 2 + 1, mid + 1, r, x, y, t);
    sum[k] = sum[k * 2] + sum[k * 2 + 1];
}
```

== 区间加

- 什么时候才需要让孩子处理懒惰标记呢？
  - 如果一个线段树区间每次都被操作区间完全覆盖，懒惰标记永远都不需要下传
  - 如果只覆盖了一部分，则不能再用懒惰标记表示左右区间未处理操作（因为懒惰标记表示区间内每个元素都要加 `lazy[k]`），所以这时候让孩子处理懒惰标记.

#figure(image("image copy 3.png", height: 50%))

== 区间加

#slide[

```cpp
void modify(int k, int l, int r, int x, int y, ll t) {
    // 在 k 号节点上，对 x 到 y 区间加 t
    if (r < x || y < l) {
        return;
    }
    if (x <= l && r <= y) {
        sum[k] += (r - l + 1) * x;
        lazy[k] += x;
        return;
    }
```
#highlight(```cpp
    pushdown(k, l, r);
```)
```cpp
    int mid = (l + r) / 2;
    modify(k * 2, l, mid, x, y, t);
    modify(k * 2 + 1, mid + 1, r, x, y, t);
    sum[k] = sum[k * 2] + sum[k * 2 + 1];
}
```][
```cpp
void pushdown(int k, int l, int r) {
    // k 号结点的懒惰标记往下加
    int mid = (l + r) / 2;
    sum[k * 2] += (mid - l + 1) * lazy[k];
    sum[k * 2 + 1] += (r - mid) * lazy[k];
    lazy[k * 2] += lazy[k];
    lazy[k * 2 + 1] += lazy[k];
    lazy[k] = 0;
}
```

=== pushdown 懒惰标记写法

- 更新左右儿子和
- 左儿子还没有更新自己的孩子！所以左儿子上懒惰标记
- 右儿子同理
- 把自己的懒惰标记清零
- 懒惰标记为 0 时，下传不会出错
]

== 模拟一下区间加

- 首先 [1, 4] 加 5， 然后 [2, 6] 加 2

#figure(image("image copy 4.png", height: 80%))

== 区间查询

```cpp
ll query(int k, int l, int r, int x, int y) {
    // 要查询的区间是 x ~ y
    // 这个函数会返回 k 号结点内部的贡献
    if (r < x || y < l) {
        return 0;
    }
    if (x <= l && r <= y) {
        return sum[k];
    }
    // 如果不是整段查询，就要先下传懒惰标记（确保左右儿子正确），再求左右儿子的和:
    pushdown(k, l, r);
    int mid = (l + r) / 2;
    return query(k * 2, l, mid, x, y) + query(k * 2 + 1, mid + 1, r, x, y);
}
```

== 模拟一下查询函数

...

== P3373 【模板】线段树 2

- 区间加 / 乘
- 查询区间和

==

- 大致框架一样，用 `sum[i]` 存储第 $i$ 个结点的权值和
- 乘法也需要懒惰标记
  - `mul[i], add[i]` 表示 $i$ 的所有儿子还需要先乘 `mul[i]` 再加 `add[i]`

```cpp
void pushdown(int k, int l, int r)
{
	int mid = (l + r) >> 1;
	
	//to left son
	T[k << 1].sum = (T[k << 1].sum * T[k].mul + T[k].add * (mid - l + 1)) % p;
	T[k << 1].mul = (T[k << 1].mul * T[k].mul) % p;
	T[k << 1].add = (T[k << 1].add * T[k].mul + T[k].add) % p;
	
	//to right son
	T[(k << 1) + 1].sum = (T[(k << 1) + 1].sum * T[k].mul + T[k].add * (r - mid)) % p;
	T[(k << 1) + 1].mul = (T[(k << 1) + 1].mul * T[k].mul) % p;
	T[(k << 1) + 1].add = (T[(k << 1) + 1].add * T[k].mul + T[k].add) % p;
	
	T[k].mul = 1;
	T[k].add = 0;
}
```

== 恭喜你会树链剖分了！

== 应用题 P3870 [TJOI2009] 开关

- `d[k]` 存储第 $k$ 个结点的有几盏灯亮的
- 每次操作一个区间就 `d[k] = r - l + 1 - d[k]`
- 懒惰标记 `rev[k]` 表示其儿子是否需要反转

== P6492 [COCI2010-2011#6] STEP

- 考虑维护差分
- 单点翻转等价于当前位置和下一个位置的差分反转 
- 求最长的连续差分 $1$，答案 + 1
- query 时，每次返回是否全是 1、左边最长连续 1、右边最长连续 1
