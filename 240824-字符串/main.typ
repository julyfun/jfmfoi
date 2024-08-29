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
  title: [【算法2-4】字符串],
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

=  KMP

- 理解“部分匹配值” 阮一峰: https://www.ruanyifeng.com/blog/2013/05/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm.html

```cpp
    int ok = 0;
    for (int i = 1; i <= slen; i++) {
        while (ok && t[ok + 1] != s[i])
            ok = nxt[ok];
        if (t[ok + 1] == s[i])
            ok++;
        if (ok == tlen) {
            printf("%d\n", i - tlen + 1);
            ok = nxt[ok];
        }
    }
```

== 

- 如何求出 nxt 数组？nxt[i] 表示前 i 位字符串最长相同前缀后缀长度

```cpp
    nxt[1] = 0; // nxt[i]: 前 i 位的最长相同前后缀长度（不含整串）
    int prefix = 0;
    for (int i = 2; i <= tlen; i++) {
        while (prefix && t[prefix + 1] != t[i])
            prefix = nxt[prefix];
        if (t[prefix + 1] == t[i])
            prefix++;
        nxt[i] = prefix;
    }
```

== P4391 [BOI2009] Radio Transmission 无线传输

`n - nxt[n]`

= 字典树 Trie

== P1481 魔族密码

#slide[

```cpp
struct Node {
    int ch[26] = { 0 };
} node[N * 80];
```

题解：在每个单词最后字母所在节点打标签，然后 dfs （无重复单词）
][
#image("image.png")
]

== P2580 于是他错误的点名开始了

建好树，每条查询路径走一次就行。

= 01 Trie

== P4551 最长异或路径

看题解 1 就行。注意是

- 随便选一个根
- 算出每一个点到根的异或和
- 对每一个点异或和 build Trie
- 对每一个点异或和，在 01 Trie 上找异或路径即可
