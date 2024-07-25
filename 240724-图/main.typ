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

// [my]

#set text(
  font: ("New Computer Modern", "Songti SC")
)
#show strong: set text(weight: 900)  // Songti SC 700 不够粗

// Global information configuration
#let s = (s.methods.info)(
  self: s,
  title: [图],
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
#show: slides

= 术语

== 术语

- 图由*顶点*和*边*组成。下面是一个例子：

#let nodes = ("1", "2", "4", "3")
#let edges = (
  (2, 1, 1),
  (3, 2, 3),
  (2, 3, 6),
  (3, 1, 4),
  (1, 4, 2),
  (4, 3, 5),
)

#let typ_g(nodes, edges, scale, elpos, di) = {
diagram({
	for (i, n) in nodes.enumerate() {
		let θ = 90deg - i*360deg/nodes.len()
		node((θ, scale), n, stroke: 0.5pt, name: str(i))
	}
  let real_e(from, to) = {
    return (from - 1, to - 1)
  }
  let inv_in(e, es) = {
    for (from, to, val) in es {
      if (e.at(0), e.at(1)) == (to, from) {
        return true
      }
    }
    return false
  }
	for (from, to, val) in edges {
		let bend = if inv_in((from, to, val), edges) { 10deg } else { 0deg }
		// refer to nodes by label, e.g., <1>
		edge(label(str(from - 1)), label(str(to - 1)), if di {"-|>"} else {"-"}, label: val, bend: bend, label-pos: elpos)
	}
})
}

#typ_g(nodes, edges, 34mm, 0.7, true)

#pause

这张图中的每一个边都是有方向的，这种图叫做*有向图*。边上的数字叫做*边权*，通常是指边的长度。

== 术语

- 例：有 $4$ 个城市，标号分别是 $1, 2, 3, 4$，它们之间有若干条*单向*道路，我们可以用下图表示道路方向和长度。

#typ_g(nodes, edges, 34mm, 0.7, true)


== 如果是双向道路呢

- 例：有 $4$ 个城市，标号分别是 $1, 2, 3, 4$，它们之间有若干条*双向*道路，我们可以用下图表示道路方向和长度。这里边没有特定指向，是双向连通的。这种图是*无向图*。


#let edges = (
  (2, 1, 1),
  (3, 2, 3),
  (3, 1, 4),
  (1, 4, 2),
  (4, 3, 5),
)


#typ_g(nodes, edges, 34mm, 0.6, false)

= 用 C++ 存储一个图

== 现在希望将该图存进计算机

#import "@preview/tablem:0.1.0": tablem

// #tablem[
//   | *Name* | *Location* | *Height* | *Score* |
//   | ------ | ---------- | -------- | ------- |
//   | John   | Second St. | 180 cm   |  5      |
//   | Wally  | Third Av.  | 160 cm   |  10     |
// ]

#slide[
  #typ_g(nodes, edges, 24mm, 0.2, true) \
  - 可以使用*邻接矩阵*，用一个二维数组 `v[i][j]` 表示从 `i` 到 `j` 的边长度。`-1` 表示不连通。
][
  #pause
  #tablem(align: center + horizon, gutter: 0.2em, fill: (x, y) =>
    if x == 0 or y == 0 { gray }, inset: (x: 0.5em))[
    | *v* | j = 1 | 2 | 3 | 4 |
    | ---- | ---- | ---- | ---- | ---- |
    | i = 1 | -1 | -1 | 2 | 1 |
    | 2 | 1 | -1 | -1 | -1 |
    | 3 | -1 | -1 | -1 | 5 |
    | 4 | 3 | 4 | -1 | -1 |
  ]
]


== T1

#slide[
读入 $n, m$ 表示有 $n$ 个城市，$m$ 条道路。

接下来 $m$ 行，每行 $u, v, w$ 表示从 $u$ 到 $v$ 有一条长度为 $w$ 的道路。

你需要输出邻接矩阵，其中第 $i$ 行第 $j$ 列的数表示从 $i$ 到 $j$ 的道路长度。如果没有道路，输出 $-1$。][

样例输入:

```
4 5
2 1 1
4 2 4
4 1 3
3 4 5
1 3 2
```

#pause

- 改成双向道路（无向图）呢？
]

== T1 code

这是有向图版本:

```cpp
int e[110][110];
int main() { 
    cin >> n >> m;
    memset(e, -1, sizeof(e));
    while (m--) {
        int u, v, w;
        cin >> u >> v >> w;
        e[u][v] = w;
    }
    // ...
```

[write code]. 题解参见 `t1.cpp`

== T1 code 无向图版本

```cpp
int e[110][110];
int main() { 
    cin >> n >> m;
    memset(e, -1, sizeof(e));
    while (m--) {
        int u, v, w;
        cin >> u >> v >> w;
        e[u][v] = w;
        e[v][u] = w; // 唯一区别在此
    }
    // ...
```

题解参见 `t1-无向图.cpp`

== 更加优雅的存储方式

#tablem(align: center + horizon, gutter: 0.2em, fill: (x, y) =>
  if x == 0 or y == 0 { gray }, inset: (x: 0.5em))[
  | *v* | j = 1 | 2 | 3 | 4 |
  | ---- | ---- | ---- | ---- | ---- |
  | i = 1 | -1 | -1 | 2 | 1 |
  | 2 | 1 | -1 | -1 | -1 |
  | 3 | -1 | -1 | -1 | 5 |
  | 4 | 3 | 4 | -1 | -1 |
]

这种矩阵中，有用的数据太少了！

假如我们有 $n = 10^5$ 个点，$m = 2 times 10^5$ 条边。有用的边只有二十万条，然而我们却要开 $10^5 times 10^5$ 的数组。有没有更好的方式来存储边呢？

== 使用 `vector` 

```cpp
struct E { int v;  int w; }; // v 是目的地, w 是边权
vector<E> e[110];
// 每个 e[i] 都是一个 E 类型的动态数组，存储 i 点所有连出去的边的信息，
// 例如 e[2][0] = { 1, 15 }, e[2][1] = { 4, 23 }
int main() { 
    cin >> n >> m;
    while (m--) {
        int u, v, w;
        cin >> u >> v >> w;
        e[u].push_back({v, w}); // 这种方式直接产生一个 E 结构体
    }
```

== 例题 P3916 图的遍历

== 使用 `std::vector`

#slide[
读入 $n, m$ 表示有 $n$ 个城市，$m$ 条道路。

接下来 $m$ 行，每行 $u, v$ 表示有一条从 $u$ 到 $v$ 道路。

你需要用 `std::vector` 来存储这些道路。对于每个点，用一行输出它所连向的点。][

样例输入:

```
4 5
2 1
4 2
4 1
3 4
1 3
```

#pause

改成双向道路（无向图）呢？
]

== vector code

```cpp
int n, m;
vector<int> e[110];
// 每个 e[i] 存储 i 点所有连出去的边（这题没有边权），
// 每个 e[i] 都是一个 int 类型的动态数组，
// 例如 e[1] = { 3, 4, 5 }，e[1] 就是一个 vector<int> 动态数组！
// 这表示 1 号点连向 3, 4, 5
int main() { 
    cin >> n >> m;
    while (m--) {
        int u, v;
        cin >> u >> v;
        e[u].push_back(v); // 双向道路就加 e[v].push_back(u)
    } // ...
```

== 1

#pause

Just like this.

#meanwhile

Meanwhile, #pause we can also use `#meanwhile` to #pause display other content synchronously.

#speaker-note[
  + This is a speaker note.
  + You won't see it unless you use `#let s = (s.math.show-notes-on-second-screen)(self: s, right)`
]


== Complex Animation - Mark-Style

At subslide #utils.touying-wrapper((self: none) => str(self.subslide)), we can

use #uncover("2-")[`#uncover` function] for reserving space,

use #only("2-")[`#only` function] for not reserving space,

#alternatives[call `#only` multiple times \u{2717}][use `#alternatives` function #sym.checkmark] for choosing one of the alternatives.


== Complex Animation - Callback-Style

#slide(repeat: 3, self => [
  #let (uncover, only, alternatives) = utils.methods(self)

  At subslide #self.subslide, we can

  use #uncover("2-")[`#uncover` function] for reserving space,

  use #only("2-")[`#only` function] for not reserving space,

  #alternatives[call `#only` multiple times \u{2717}][use `#alternatives` function #sym.checkmark] for choosing one of the alternatives.
])


== Math Equation Animation

Touying equation with `pause`:

#touying-equation(`
  f(x) &= pause x^2 + 2x + 1  \
        &= pause (x + 1)^2  \
`)

#meanwhile

Here, #pause we have the expression of $f(x)$.

#pause

By factorizing, we can obtain this result.


== CeTZ Animation

CeTZ Animation in Touying:

#cetz-canvas({
  import cetz.draw: *
  
  rect((0,0), (5,5))

  (pause,)

  rect((0,0), (1,1))
  rect((1,1), (2,2))
  rect((2,2), (3,3))

  (pause,)

  line((0,0), (2.5, 2.5), name: "line")
})


// == Fletcher Animation

// Fletcher Animation in Touying:

// #fletcher-diagram(
//   node-stroke: .1em,
//   node-fill: gradient.radial(blue.lighten(80%), blue, center: (30%, 20%), radius: 80%),
//   spacing: 4em,
//   edge((-1,0), "r", "-|>", `open(path)`, label-pos: 0, label-side: center),
//   node((0,0), `reading`, radius: 2em),
//   edge((0,0), (0,0), `read()`, "--|>", bend: 130deg),
//   pause,
//   edge(`read()`, "-|>"),
//   node((1,0), `eof`, radius: 2em),
//   pause,
//   edge(`close()`, "-|>"),
//   node((2,0), `closed`, radius: 2em, extrude: (-2.5, 0)),
//   edge((0,0), (2,0), `close()`, "-|>", bend: -40deg),
// )


= Theorems

== Prime numbers

#definition[
  A natural number is called a #highlight[_prime number_] if it is greater
  than 1 and cannot be written as the product of two smaller natural numbers.
]
#example[
  The numbers $2$, $3$, and $17$ are prime.
  @cor_largest_prime shows that this list is not exhaustive!
]

#theorem("Euclid")[
  There are infinitely many primes.
]
#proof[
  Suppose to the contrary that $p_1, p_2, dots, p_n$ is a finite enumeration
  of all primes. Set $P = p_1 p_2 dots p_n$. Since $P + 1$ is not in our list,
  it cannot be prime. Thus, some prime factor $p_j$ divides $P + 1$.  Since
  $p_j$ also divides $P$, it must divide the difference $(P + 1) - P = 1$, a
  contradiction.
]

#corollary[
  There is no largest prime number.
] <cor_largest_prime>
#corollary[
  There are infinitely many composite numbers.
]

#theorem[
  There are arbitrarily long stretches of composite numbers.
]

#proof[
  For any $n > 2$, consider $
    n! + 2, quad n! + 3, quad ..., quad n! + n #qedhere
  $
]


= Others

== Side-by-side

#slide(composer: (1fr, 1fr))[
  First column.
][
  Second column.
]


== Multiple Pages

#lorem(200)


// appendix by freezing last-slide-number
#let s = (s.methods.appendix)(self: s)
#let (slide, empty-slide) = utils.slides(s)

== Appendix

#slide[
  Please pay attention to the current slide number.
]
