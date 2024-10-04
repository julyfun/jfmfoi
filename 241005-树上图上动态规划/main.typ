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
  title: [区间 DP 和环状 DP],
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

#show: slides

// --- 以下为正文

= 安排

- 发送本文件
- 点击参与作业
- 完成一题后发样例代码

#let lin = line(length: 100%)

#lin

- 今日题单:
  - 没有上司的舞会
  - 二叉苹果树
    - 提前做完的同学做 [CTSC1997] 选课	
  - 跑路
  - 绿豆蛙的归宿
  - 采蘑菇

== P1352 没有上司的舞会

- 题意 10min

#pause

- 一个结点，要么邀请他，并且他的直接下属不能邀请，要么不邀请他，它的下属可以邀请
- 用 f[i] 表示邀请第 i 个结点情况下，它子树的最大权值和
- 用 g[i] 表示不邀请第 i 个结点情况下，它子树的最大权值和
- $f[i] = sum_j (g[j]) + w[i]，g[i] = sum_j (max(f[j], g[j]))$

== 二叉苹果树

- 题意 10min

#pause

- 树上的背包：由于方案很多，我们要对每个点保存其保留树枝各种数量的方案
- 用 $f_(i, j)$ 表示第 i 个子树保留 j 个枝条情况下，最大的苹果数量
- 对于叶子结点 i 有 $f_(i, 0) = a_i$
- 知道叶子结点的所有方案，如何推出父亲结点保留 $j$ 个枝条方案 $f_(u, j)$？
- 注意到每个非叶子结点一定有两个孩子，所以枚举左边儿子保留的枝条数量，右边儿子保留的枝条数量就确定了

```cpp
    for (int tot = 1; tot <= sz[u]; ++tot) { // 我们认为父亲需要保留一个枝条
        for (int left = max(0, tot - 1 - sz[son[1]]); left <= min(sz[son[0]], tot - 1); left++) { 
            f[u][tot] = max(f[u][tot], apple + f[son[0]][left] + f[son[1]][tot - 1 - left]);
        }
    }
```

- 答疑

== 跑路

- 题意 10min
#pause

- 我们首先考虑这样一个问题：对于点 $i$ 点 $j$，是否存在长度为 $2^k$ 的走法？
- 注意到所有边权为 $1$，所以上述条件成立*当且仅当* 存在一个中间点 $k$ 满足 $d(i, k) = d(k, j) = 2^{k-1}$
- Any body get the idea?

#pause

- 用 $f_(i, j, k)$ 表示 $i$ 到 $j$ 的路径中，是否存在 $2^k$ 的路径
- 初始条件：对于所有直接相连的点，$f_(i, j, 0) = 1$
- 转移条件：$f_(i, j, k) = f_(i, k, k-1) \& f_(k, j, k-1)$
- 若 $i, j$ 之间存在 $2^k$ 的路径，将两者距离 $"dis"_(i, j)$ 标记为 $1$
- 最后用 floyd 在 $"dis"$ 数组上跑一遍

== 绿豆蛙的归宿

- 题意 10min

#pause

- 设 $w_(i, j)$ 为边权
- 数学上若 $f_i$ 为 $i$ 到达终点的期望花费，则有 $f_i = sum_(v in "i 的儿子") w_(i, v) + f_v$
- 这是一个有向无环图，可以从终点反推前面所有点的期望花费
- 建一个反向拓扑图，从入度为 $0$ 的终点开始反向 DP

#lin

小数输出: `printf("%.3lf\n", ans);`

= 比赛必备技能

- 注意:
  - 文件输入输出
  
```cpp
freopen("apple.in", "r", stdin);
freopen("apple.out", "w", stdout);
```

  - cin 加速。注意 cin 与 scanf 混用会出现问题!
  
```cpp
ios::sync_with_stdio(false); cin.tie(0); cout.tie(0);
```
  
  - 开启 -std=c++17: Dev C++ 编译选项 - Linker
  - 学会 Debug
