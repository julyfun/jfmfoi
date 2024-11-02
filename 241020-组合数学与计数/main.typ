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
  title: [组合数学与计数],
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

= 注意

- 周一到周五晚上集训，周一模拟赛周二讲题周三模拟赛周四讲题，周五打模板题

== P3197 [HNOI2008] 越狱 题解

- ans = $m^n - m (m - 1)^(n - 1)$

== P5664 [CSP-S2019] Emiya 家今天的饭

题意耗时...

==

=== 64 分做法

- 用 $f_(i, j, k, l)$ 表示考虑前 $i$ 行，后面三维表示三个食材做了多少菜

==

=== 84 分做法：

- 先求出不带食材 $floor(k / 2) ("注意此处 k 和下面下标 k 不同")$ 限制的答案
  - $f_(i, j)$ 表示前 $i$ 行一共做了 $j$ 道菜的方案
  - $f_(i, j) = f_(i - 1, j) + f_(i - 1, j - 1) times s_i$ 其中 $s_i$ 为第 i 行的和
- 再求出所有至少有一种食材大于 $floor(k / 2)$ 限制的方案数，上述答案减之
  - 考虑枚举第 $p$ 种食材作为超限食材
  - $f_(i, j, k)$ 表示考虑前 $i$ 行，超限食材做了 $j$ 道，其他食材做了 $k$ 道的方案数
  - $f_(i, j, k) = f_(i - 1, j, k) + f_(i - 1, j - 1, k) times s_i + f_(i - 1, j, k - 1) times (s_i - a_(i, p))$ 其中 $a_(i, p)$ 表示第 $i$ 行第 $p$ 种食材可以做的菜数
  - 复杂度 $O(m n^3)$

==

=== 100 分

- 上面保留 $j, k$ 维度是为了最后能求出大于一半的总方案数
- 可以状态只保留超限食材和其他食材的差
- $f_(i, j)$ 为考虑前 $i$ 行，超限食材和其他食材的差为 $j$ 的方案数
- $f_(i, j) = f_(i - 1, j) + f_(i - 1, j - 1) times a_(i, p) + f_(i - 1, j + 1) times (s_i - a_(i, p)) $
- 复杂度 $O(m n^2)$

== P1287 盒子与球

=== ...

#pause

=== 逐个考虑盒子

- $f_(i, j)$ 表示前 $i$ 个盒子一共放了 $j$ 个球的方案数
- 枚举第 $i$ 个盒子放了几个球

=== 逐个考虑球（斯特林数）

- $S_(i, j)$ 表示 i 个不同的球放 j 个非空集合的方案数
- $S_(i, j) = S_(i - 1, j - 1) + S_(i - 1, j) times j$
  - 要么前 i - 1 个球放了 j - 1 个非空集合，第 i 个球自己单独一个集合
  - 要么前 i - 1 个球放了 j 个非空集合，第 i 个球放到 j 个集合中的某一个
- 最后乘以 $r!$ 即可
  - 注意 $S_(0, 0) = 1, S_(n, 0) = S_(0, n) = 0$

== P5520 [yLOI2019] 青原樱

...

#pause

- 考虑任意一个合法方案，将其间距去掉一个以后，得到一个无间距限制，在 $(n - m + 1)$ 个盆中种 $m$ 个幼苗的方案。
- 任何一个 $(n - m + 1)$ 选 $m$ 的方案唯一对应一个合法方案
- 单射且满射

== P4071 [SDOI2016] 排列计数

#pause

- 首先选 $m$ 个原位数，方案数为 $vec(n, m)$。此处需要逆元
- 剩下是一个 $n - m$ 位数的错排
- 错排推导:
  - 考虑构造 n 位数错排。设 n 为错排方案数为 $f_n$
  - 先构造前 n - 1 位的排列，再选一个数与第 n 个数交换
  - 前 n - 1 位最多 1 个在原位
  - 若 1 个在原位，则必须与该位交换
    - 有 n - 1 种原位可能性，每个可能性中除了该位和 n 以外，为 n - 2 的错排
  - 若 0 个在原位，则是 n - 1 的错排，可选择 n - 1 中的一个数与 n 交换
  - 递推: $f_n = (n - 1) (f_(n - 1) + f_(n - 2))$
  - 证明交换法构造是双射: 构造出的排列两两不同；任何 n 位错排可被该构造法构造

== P1313 [NOIP2011 提高组] 计算系数

#pause

=== 二项式定理

$
(b y + a x) \
(b y + a x) \
(b y + a x) \
(b y + a x) \
dots.v
$

考虑 $x^n times y^m$ 的系数。这意味着从 k 个括号中选了 n 个 $a x$，选法有 $vec(k, n)$ 种，每一种选法的系数为 $a^n times b^m$，总系数为 $vec(k, n) times a^n times b^m$

== P1044 [NOIP2003 普及组] 栈

#pause

任意时刻下，push 的次数 $>=$ pop 的次数（栈大小 >= 0）

#figure(image("image.png", height: 60%))

- $f_(i, j)$ 表示前 $i$ 个数，栈中有 $j$ 个数的方案数
- $f_(i, j) = f_(i - 1, j - 1) + f_(i - 1, j + 1)$，对 $j < 0$ 有 $f_(i, j) = 0$
- 另一个递推：设 $h_i$ 为 $i$ 个数出栈顺序的方案数。若最后一个出栈的是 $x$ 则其之前必是：所有 $<= x - 1$ 的数入栈出栈；加入 $x$；所有 $> x$ 的数入栈出栈
- $h_n = sum_(i = 1)^(n) h_(i - 1) times h_(n - i)$，其中 $h_0 = 1$
- 第 n 个卡特兰数就是 $h_n$，或者说上述走路过程中始终不能走到 $y = 0$ 那条线以下的方案数

==

欢迎切紫题
