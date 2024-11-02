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
  title: [STL, 树状数组和条件概率],
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

== 

- 读注意事项: 考试环境，考场规则，需要带的物品...
- 准考证打印了吗
- 会暴零的情况
  - 文件夹 / 文件名规范
  - freopen 没打
  - cin 和 printf 混用. 注意 cout 用 "\n" 替代 endl 更快
  - MLE

== 近年题目涉及考点

刷对应模板题

https://docs.qq.com/sheet/DWG9zUlVCTFJacnpD?tab=BB08J2

== 订正

== 树状数组

#figure(image("image.png"))

```cpp
int bit(int x) { // 求最后一个 1
    return x & -x; // 最后一段连续的 0，取反全 1，加 1 得到倒数第一位 1
}
void add(int p, int x) { // 在 p 位置加 x，维护树状数组
    while (p <= n) {
        c[p] += x;
        p += bit(p);
    }
}
int pre(int p) { // 求 1 ~ p 前缀和
    int res = 0;
    while (p) {
        res += c[p];
        p -= bit(p);
    }
    return res;
}
```

== P3368 【模板】树状数组 2

区间加，单点值。假设加的区间是 `[x, y]`，则在 `x` 加 `k`，在 `y + 1` 减 `k`，求前缀和就是单点值。

== debug

- 常见错误信息
- left 全局变量？
- Exe 没关
- 重启 Dev 解决一些问题

== STL

- P1168 中位数 小根堆 + 大根堆
- P5250 【深基17.例5】木材仓库: `set<int>`
  - `s.count(x)` 返回 x 的个数
  - `s.insert(x)` 插入 x
  - `s.empty()` 判断是否为空
  - `s.erase(x)` 删除 x
  - `s.lower_bound(x)` 返回第一个大于等于 x 的迭代器
    - 例如 ： `it = s.lower_bound(x);` 随后 `*it` 就是第一个大于等于 x 的值
    - 可以使用 `--it, ++it` 来移动迭代器(获取前一个或者后一个)
  - `set` 重复插入会被忽略，`multiset` 可以插入重复元素
  - 遍历: `for (auto it = s.begin(); it != s.end(); ++it)`
- P1102 A-B 数对: `map<ll, ll>`
  - `m[x] = 0`：像数组一样使用
  - 遍历: `for (auto it = m.begin(); it != m.end(); ++it) { cout << it->first << ' ' it->second << '\n'; }`

== 条件概率 Probability|Given

- 求出 $r$ 个人买东西的所有可能性，再求其中第 $i$ 个人买了东西的情况在其中占比多少。
