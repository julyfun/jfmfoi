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
  title: [【算法2-5】进阶搜索],
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

// --- 以下为正文

#show raw.where(lang: "cpp"): it => {
  set text(12pt)
  it
}

#set text(20pt)

#show: slides

= 初赛 - CSP-S 2022

#image("image.png", height: 80%)

涉及字节在电脑里的存储方式。答案: B

= 搜索剪枝


== P1825 [USACO11OPEN] Corn Maze S

广搜复习题. 网格搜最近，用广搜，可以保证第一次到达该点时，一定是最近的走法。

这道题的坑点在于首次到达传送门一端时（强制传送到另一端），只能确定到达另一端的方式这样是最短的，之后可能需要走回来。

== P1135 奇怪的电梯

```cpp
long long n, m, k, a[210], ans = 1e18, minn[210];
int used[210];
void dfs(long long u, long long v, long long cs) {
    if (used[u])
        return;
    used[u] = 1; //标记这个点已经搜过了
    if (u == v) //如果搜到了
    {
        ans = cs; //记录答案
        used[u] = 0;
        return;
    }
    dfs(u + a[u], v, cs + 1);
    dfs(u - a[u], v, cs + 1);
    used[u] = 0;
}
```

#pause

剪枝：减去部分不可能的情况。1. 超出范围 2. 记录历史上到达每个点的最优方案，如果走到这个点不是最优方案就退出。 3. 如果当前步数已经超过了最优解，就退出。 4. 如果一路上走过一个点两次，就退出，重复走一个点没有意义。

= 暴力部分分

== P4799 [CEOI2015 Day2] 世界冰球锦标赛

学会分段得分

$n <= 20$ 暴力 dfs

$m <= 10^6$ 背包。$f[i]$ 表示花费为 $i$ 的方案数

#pause

正解：双向 dfs。首先 dfs 出前一半的所有组合，并 dfs 出后一半的所有组合。对于前一半组合的前 $i$ 项，用指针 $p$ 表示后一半中前几个与其可以进行组合，求和即可。

== P2324 [SCOI2005] 骑士精神

- 定义距离为目标棋盘和当前棋盘不同的格子数。
- 走 n 步最多减少 n + 1 的距离，所以距离超过 16 就不搜索。
- 如果距离超过当前最优解也不搜索。

- 走的时候用空格走，比走马🐴方便。
