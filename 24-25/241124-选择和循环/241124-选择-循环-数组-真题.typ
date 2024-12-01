#import "@preview/touying:0.5.3": *
#import themes.university: *
#import "@preview/cetz:0.2.2"
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#import "@preview/ctheorems:1.1.2": *
#import "@preview/numbly:0.1.0": numbly

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

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

#show: university-theme.with(
  aspect-ratio: "16-9",
  // config-common(handout: true),
  config-info(
    title: [选择，循环和数组],
    subtitle: [],
    author: [方俊杰.SJTU],
    date: datetime.today(),
    institution: [交附闵分],
    logo: emoji.school,
  ),
)

#show heading.where(level: 1): set heading(numbering: numbly("{1}.", default: "1.1"))

// [my]

// [code]
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
  
// [text]
#set text(20pt)
#set text(
  font: ("New Computer Modern", "Songti SC")
)
#show strong: set text(weight: 900)  // Songti SC 700 不够粗

#set list(indent: 0.8em)
#show link: underline

#let lin = line(length: 100%)
// [my.end]

#title-slide()

== <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 1.5em))

== 安排

- *零基础同学从前往后做题，听我讲解*
- *非零基础同从后往前做*，做难度较低的 CSP/NOIP 真题。这些题目零基础也可以做.
- 1.5h \~ 2h 后会讲真题

#lin

- 打开文件管理器，地址栏输入 `ftp://192.168.2.61:223`.
  - 这里可以获取资源，包括教材.
- 现在打开 Dev-C++，不急着打开题单.
- [todo] 作业完成情况

= 入门

== if 语句

- 根据条件执行语句. 注意，条件两边要加括号.
  ```cpp
  if (a > b)
    cout << "yes" << endl;
  ```

- 在语句后加 else 执行另一条语句.
  ```cpp
  if (a > b)
      cout << "yes" << endl;
  else
      cout << "no" << endl;
  ```

- 如果某个条件执行多条语句，需要加大括号:
  ```cpp
  if (b > a) {
      a = b;
      cout << "update A" << endl;
  } else
      cout << "no update" << endl;
  ```

- [动手] 输入两个 `double` 类型数据，输出较大的数.

#pagebreak()

- 可以使用 `else if` 构成多重分支.
  ```cpp
  if (score < 60)
      cout << "不及格" << endl;
  else if (score < 80)
      cout << "及格" << endl;
  else if (score < 90)
      cout << "良好" << endl;
  else
      cout << "优秀" << endl;
  ```

- [动手] 题单第一题. P5714 【深基3.例7】肥胖问题 [p48]

=== 复习 bool 变量

- 比较结果可以存入 `bool` 类型变量. 值要么是 `true`，要么是 `false`.
  ```cpp
  bool is_greater = a > b;
  ```
- 布尔变量可以使用 `cout` 输出，输出结果是 `1` 或 `0`.
  ```cpp
  cout << is_greater << endl;
  ```

#pagebreak()

- [动手] 不使用 if 语句，通过 P5711 【深基3.例3】闰年判断 [p43]
- #pause
  ```cpp
  #include <iostream>
  using namespace std;
  int main() {
      int x; bool p;
      cin >> x;
      p = (x % 400 == 0) || (x % 4 == 0 && x % 100 != 0);
      cout << p << endl;
      return 0;
  }
  ```
- [动手] P1909 [NOIP2016 普及组] 买铅笔
- 更多练习可查看洛谷教材.

== 循环语句

- C++ 如何输出 1 到 100?
  ```cpp
  for (int i = 1; i <= 100; i++)
      cout << i << endl;
  ```
- *for 循环语法结构*
  ```cpp
  for (初始化; 继续条件; 更新语句)
      语句;
  ```
- 同样的，如果要执行多条语句，需要加大括号.
- [动手] P5718 【深基4.例2】找最小值
- [动手] P1009 [NOIP1998 普及组] 阶乘之和
  - 题目数据范围大，暂时无法拿满分，需要开 `long long` 获取更多分数。满分通过此题需要高精度知识，过 2 节课会学到.

#pagebreak()

- *while 循环*: 输出十万以内的 2 的正整数次幂.
  ```cpp
  int t = 2;
  while (t <= 100000) {
      cout << t << endl;
      t *= 2;
  }
  ```
- while 循环语法结构:
  ```cpp
  while (条件)
      语句;
  ```
- [动手] 输入一个数，输出它十进制下从低到高的每一位数字. 例如输入 `12344`，输出 `4 4 3 2 1`，以空格分隔.
- [动手] P1980 [NOIP2013 普及组] 计数问题
  - 提示：for 循环嵌套 while 循环.

== 数组

- 如果要存储三个数，可以定义变量 `int a1, a2, a3;`. 如果要存储 100 个数，就需要定义 100 个变量，这样不方便.
- 此时可以用数组来存储数据. 
  ```cpp
  int a[110]; // 定义一个整数数组 a，长度为 110
  ```
  - 这个数组的编号为 `a[0]` 到 `a[109]`，每个 `a[i]` 都可以当做一个变量来用.
  - 例:  `cin >> a[0]; cout << a[99] << endl;`
- [动手] 输入一个整数 $n$ ($n <= 100$)，随后输入 $n$ 个*实数*，你需要输出每两个数之间的差，共输出 $n - 1$ 个数，以空格分隔.
  ```cpp
  int n; double a[110];
  cin >> n;
  for (int i = 1; i <= n; i++)
      cin >> a[i];
  for (int i = 2; i <= n; i++)
      cout << a[i] - a[i - 1] << " "; 
  ```
- [提问] 数组大小至少要开多少？

#pagebreak()

- [动手] P1047 [NOIP2005 普及组] 校门外的树
  - 提示：创建一个布尔数组 `bool used[10010]`，其中 `used[i]` 表示第 $i$ 个树是否被移走.
  - [..] 数组可以定义在哪些地方？内部初始值是多少？

#pagebreak()

- *多维数组*
- 我们可以创建多维的数组存储更复杂的数据.
  ```cpp
  int a[10][20]; // 定义一个 55 行 55 列的整数数组 a
  ```
  - 这样就定义了一个二维数组，编号为 `a[0][0]` 到 `a[9][19]`.
  - 可以认为有 10 行，每行有 20 个元素. 
  - 也可以认为每个 `a[i]` 都是一个长度为 20 的数组.
- [动手] P3397 地毯
  - 提示: 创建 $n times m$ 的二维数组 `int a[55][55];`，`a[i][j]` 表示 $i$ 行 $j$ 列的格子被覆盖了几次.
  - [选做] 这种做法只能通过 $n, m <= 50$ 的情况，处理更大情况太慢了. 你能优化吗？
- [动手] P2615 [NOIP2015 提高组] 神奇的幻方

= 进阶

== P8813 [CSP-J 2022] 乘方

- 如果 $a = 1$，答案必为 $1$，否则乘得很快就会超过 $10^9$，不用担心超时.
  - 提示：一秒内计算次数要控制在两亿以内，不然容易超时.

== P7071 [CSP-J2020] 优秀的拆分

- 将 $n$ 视为二进制查看，就是将其拆分为 2 的整数次幂的和.
- 如果最后一位是 $1$，那么拆分必然含有 $2^0$，否则必然不含有.
- 如果从大到小输出每一位？
  - 令 $t = 2^30$，远超 $n$ 的最大可能值。$t$ 不断缩小一半，若 $n >= t$ 则拆分出来.
    ```cpp
    #include <bits/stdc++.h>
    using namespace std;
    int main() {
        int n; cin >> n;
        if (n & 1) {
            cout << -1 << endl;
            return 0;
        }
        int t = 1 << 30;
        while (n) {
            if (n >= t) {
                cout << t << ' ';
                n -= t;
            }
            t >>= 1;
        }
        return 0;
    }
    ```

== P5753 [NOI2000] 瓷片项链

- 如果确定了瓷片数目，那么我们应该猜测均分泥土是最优的.
  - 你也可以用导数证明.
  - $ &(sqrt(x) + sqrt(V - x))^' = 1 / (2 sqrt(x)) - 1 / (2 sqrt(V - x)) = 0 \ &=> x = V - x \ &=> x = V / 2 $
- 若分为 $k$ 份，则总长度 $k dot 0.3 dot sqrt(V / k - V_0)$. 平方得 $0.09 k^2(V / k - V_0) = 0.09 (k V - k^2 V_0)$
- 取 $k = V / (2 V_0)$ 时得最大值. 题目要求 $k$ 为整数，则比较 `int(k)` 和 `int(k) + 1` 谁更优.
  - 比较是否相等时，最好使用 `abs(x - y) < EPS`.

== P11227 [CSP-J 2024] 扑克牌

- 将牌型转换为数字.
  - 组别数组 `char f[128]; f['D'] = 0, f['C'] = 1, f['H'] = 2, f['S'] = 3;`.
  - 牌号数组 `char g[128]; g['A'] = 1, g['2'] = 2, ..., g['9'] = 9, g['T'] = 10, g['J'] = 11, g['Q'] = 12, g['K'] = 13;`.
  - 读入 `char s[10]; cin >> s; int x = f[s[0]] * 13 + g[s[1]];`. 获取牌型编号.
- 用 `bool used[100]` 标记牌型编号是否出现过.

== P11231 [CSP-S 2024] 决斗

- 提示：使用 `sort(a + 1, a + n + 1)` 可以对 `a[1] ~ a[n]` 进行排序.
- 最小的数字不能打别人，所以考虑先打最小数字.
  - 怎么打它是最优的？找到最小的大于它的数字就行了！

```cpp
#include <bits/stdc++.h>
using namespace std;
int n; const int N = 1e5 + 10;
int a[N];
int main() {
    ios::sync_with_stdio(0); cin.tie(0); cout.tie(0);
    cin >> n;
    for (int i = 1; i <= n; i++)
        cin >> a[i];
    sort(a + 1, a + n + 1);
    int i = 1, j = 2; // i 表示被打的怪兽，j 表示打它的怪兽
    int ans = n;
    while (j <= n) {
        if (a[i] < a[j]) ans--, i++, j++;
        else j++;
    }
    cout << ans << "\n";
    return 0;
}
```
