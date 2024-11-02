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
  title: [数论],
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

= 逆元

== 【模板】模意义下的乘法逆元

- 定义：在模 p 意义下，a 的逆元是 b 当且仅当 $a b eq.triple 1 space (mod p)$。记为 $a^(-1) eq.triple b$
- 性质：若 $p$ 是质数，则每个 $a in [1, p - 1]$ 数都有在 $[1, p - 1]$ 中的唯一逆元.
- 例：
  - 在模任意数意义下，$1$ 的逆元是 $1$
  - 在模 $7$ 意义下，$3$ 的逆元是 $5$，因为 $3 * 5 mod 7 = 1$
- 逆元在代码中的作用：在模意义下，乘法有交换律，但除法没有. 引入逆元可以解决该问题
  - 乘法可以将 mod 运算提前: `a * b * c % p = a * b % p * c % p`，这样就避免中间结果爆 long long. 而且也可以交换因数.
  - 除法不能将 mod 提前: `3 * 6 / 2 % 5 = 4`，但 `3 * 6 % 5 / 2 % 5` 无法运算（出现小数）. 而且也不能将 `/ 2` 交换到前面
  - 逆元可以将模意义下除法等价转换为乘法。上式中，可以先求 2 在模 5 意义下的逆元为 $3 ("因为" 2 times 3 eq.triple 1 space (mod 5))$. 并将所有 `/ 2` 转换为 `* 3`，结果不变
  - `3 * 6 % 5 * 3 % 5 = 4`. 为什么？因为若 $a^(-1) eq.triple b$，则 $k a b eq.triple k (a b) eq.triple k$，即乘以 b 可以将因数 a 抵消，等价于除以 a
    
== 如何求逆元？

- 带有除法的求余无法提前 mod。逆元可以将除法转换为乘法，从而可以提前 mod，防止爆 long long
- 如何求 $a$ 的逆元?
  - 费马小定理: 若 p 为质数，则 $a^(p - 1) eq.triple 1 space (mod p)$. 不证
    - 例: $3^6 eq.triple 1 space (mod 7)$
  - 两边同时乘以 a 逆元，得到 $a^(p - 2) eq.triple a^(-1) space (mod p)$
  - 用快速幂求 $a^(p - 2)$ 即可求得逆元
- See code 1.
- 如何求 $[1, n]$ 中所有数的逆元？  
  - 1 的逆元是 1
  - 要求 i 的逆元，考虑 $k i + r = p$ 两边同时乘以 $i^(-1) r^(-1)$
  - ...
- 可以做 【模板】模意义下的乘法逆元 题目了

== 例：求 $C_n^m mod 19260817$ 其中 $n, m <= 2 dot 10^6$

== P2613 【模板】有理数取余

- 若 $b$ 的逆元为 $b^(-1)$，则有 ...
- 读入的时候用快读，不断取模即可

== P4549 【模板】裴蜀定理

- 裴蜀定理：对于任意整数 a, b, 存在 x, y 使得 $a x + b y = c$ 的充要条件是 $gcd(a, b) | c$
- 证明：$=>$ 易证，$arrow.l.double$ : OI 不需要证明 / 待会会证
- 推广：对于 $a_1, a_2 ... a_n$，存在 x, y 使得 $a_1 x_1 + a_2 x_2 + ... + a_n x_n = c$ 的充要条件是 $gcd(a_1, a_2, ... a_n) | c$
  - 证明：前两个数的组合等价于 $k gcd(a_1, a_2)$，故前三个数的组合为 $k gcd(a_1, a_2) + a_3c_c$...

#let lin = line(length: 100%)

#lin

- 题目：运用裴蜀定理，知 $gcd | c$ ，故最小正整数的 $c$ 为 $gcd$

== 扩展欧几里得算法: [NOIP2012 提高组] 同余方程	

若 $b$ 为质数，直接费马小定理即可，但此题不保证 $b$ 为质数

- 扩欧可以求关于 $x, y$ 的方程 $a x + b y = gcd(a, b)$ 的解
- 看我题解 https://www.luogu.com.cn/problem/solution/P1082

== 关于

- 求逆元一般用费马小定理就行.

== 中国剩余定理

- 我估计没空讲了

== P4942 小凯的数字

- 放松题

#pause

- $((l + r) (r - l + 1)) / 2$

== CF757B Bash's Big Day 

- 评测地址：https://codeforces.com/contest/757/submit

== Sherlock and his girlfriend

#pause

- 有点过于简单了
- 还记得质数筛吗

== GCD Table

- 最大的数如果有 $k$ 个，则在表格中一定出现 $k * k$ 次
- 第二大的数如果不整除最大数，则在表格中出现平方次，并且会贡献若干个 gcd 出现次数
- 否则解二次方程
- 其他数类似

== Remainders Game

- 定义：周期
- 最大公因数视角：将每个 $c_i$ 拆解为质因数的组合。每个质因数个数在 $c_i$ 中取 min
- lcm 视角：每个质因数个数取 max
- 观察 $c = \{2, 3\}$，可以区分 $k = 5$ 吗？
  - 不行！$c_i$ 的周期为 $6$，所以任意数加 $6$ 以后模 $c_i$ 得到的元组不变，但模 $5$ 结果会变
  - 观察到 $c_i$ 的周期必须是 $k$ 的倍数
- 大胆猜测：模 $c_i$ 得到元组的循环周期是 $c_i$ 的 lcm
  - 加 lcm 肯定不变
  - lcm 内一定不同？考虑保留每个质因数最大出现次数..
- 原题等价于 $k | "lcm"(c_i)$
- 逐质因数判断即可
