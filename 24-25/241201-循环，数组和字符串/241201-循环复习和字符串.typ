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
    title: [循环复习和字符串],
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
- 2h 左右会讲真题

#lin

- [todo] 作业完成情况
- [todo] 点击参与作业题单! https://www.luogu.com.cn/team/16908#homework

= 入门: 复习循环

== P2669 [NOIP2015 普及组] 金币

- 提示：for 循环枚举发放模式，再用一个外部变量记录当前天数.

```cpp
#include <iostream>
using namespace std;

int main() {
    //coins保存金币，days累加天数
    int k, coins = 0, days = 0;
    cin >> k;
    for (int i = 1; i <= k; i++) {
        for (int j = 1; j <= i; j++) {
            // i 代表行数，同时也是当天可得的金币数
            coins += i;
            days++;
            if (days == k) {
                //天数达到了指定的天数
                break;
            }
        }
        //结束外层循环
        if (days == k) {
            //天数达到了指定的天数
            break;
        }
    }
    cout << coins;
    return 0;
}
```

== P1075 [NOIP2012 普及组] 质因数分解

- 读题 #pause 
- 并不需要判断质数。较小的数在 $sqrt(n)$ 之内，可以枚举这个较小的数。

== P5723 【深基4.例13】质数口袋

- 读题

#pagebreak()

=== 枚举因数判断质数

- ```cpp
bool flag = true; // 是否为质数
for (int j = 2; j * j <= i; j++)
    if (i % j == 0) {
        flag = false;
        break;
    }
```

#pagebreak()

=== 筛法判断质数

- 先筛除 2 的倍数，然后筛除 3 的倍数，4 的倍数...
  - n 范围内所有质数的因数不超过 $sqrt(n)$
- ```cpp
bool isprime[3000005];
isprime[1] = false;
// 删除 i 的倍数
for (int i = 2; i <= n; i++) {
    for (int j = 2 * i; j <= n; j += i)
        isprime[j] = false;
}
```
- 如何节省时间？注意到所有合数不用筛倍数，因为已经被它的质因数筛过了.
- ```cpp
for (int i = 2; i <= n; i++) {
    if (isprime[i])
        for (int j = 2 * i; j <= n; j += i)
            isprime[j] = false;
}
```

== B4025 最大公约数

=== 辗转相除法

- 怎么求 60 和 24 的最大公约数?
  + 设 $a = 60, b = 24$
  + 每次让 $a = b$ 并让 $b = "a % b"$
    - 第一步: $a = 60, b = 24$
    - 第二步: $a = 24, b = 12$
    - 第三步: $a = 12, b = 0$
  + 直到 $b = 0$ 为止，此时 $a$ 即为最大公约数.
- ```cpp
#include <iostream>
using namespace std;
int main() {
    int a, b; cin >> a >> b;
    while (b != 0) {
        int tmp = a;
        a = b;
        b = tmp % b;
    }
    cout << a << endl;
    return 0;
}
```

#pagebreak()

为什么这样可以求出最大公约数？

- 设 $a, b$ 最大公约数为 $g$，则 $a, b$ 都是 $g$ 的倍数.
- 让 $a = b, b = "a % b"$
  - $a % b$ 相当于从 $a$ 中减去若干个 $b$，所以仍然是 $g$ 的倍数
  - $a, b$ 会越来越小，直到其中一个为 0

== P5732 【深基5.习7】杨辉三角

- 令 $a_(i, j)$ 为杨辉三角第 $i$ 行第 $j$ 个数
  - 相加关系: $a_(i, j) = "? + ?"$
  - 初始条件: 每一行的第一个数为 $1$
- 杨辉三角表示组合数 $C_i^j$ . Why?

= 入门: 字符串

== char 数组基本操作

=== 读入输出

- `char s[110]; cin >> s;`
- `cout << s;`

=== 遍历每一位

- `for (int i = 0; i < strlen(s); i++)`
  - 这里 `strlen(s)` 是字符串长度
  - 需要 `<cstring>` 头文件
- 这里是从下标 0 \~ `len - 1`

=== 如何让下标从 1 开始？

- `char s[110]; cin >> s + 1;`
  - 这样 `s[1]` 就是第一个字符
  - 字符串长度为 `strlen(s + 1)`，输出为 `cout << s + 1;`

#lin

- [动手] 测试以上代码读入多个单词的效果（空格分隔）
- [动手] 输入一个字符串（无空格），将其中小写字母改为大写字母.

== P1914 小书童——凯撒密码

#figure(image("pic/image.png"))

== P1125 [NOIP2008 提高组] 笨小猴

- 用数组 `a[i]` 记录字母出现次数，`a[0]` 到 `a[25]` 分别对应 `a` 到 `z`.
- 求最大出现次数和最小出现次数.
- 套用前面判断质数的代码.

== string 字符串用法

- C++ 中的 `string` 类型也可以用来存储字符串，有时候比数组方便.

=== 读入输出

- `string s; cin >> s;` 同样是读入到空格为止
- `cout << s;`
- `getline(cin, s);` 读入一行

=== 遍历每一位

- `for (int i = 0; i < s.length(); i++)`
  - 这里 `s.length()` 是字符串长度

=== 拼接字符串

- `string s1 = "hello", s2 = "world";`
- `string s3 = s1 + " " + s2;` 得到 `hello world`
- [动手] P5015 [NOIP2018 普及组] 标题统计
  - 提示: `cin >> s` 失败时会返回 false，可以用 `while (cin >> s)`

== P1308 [NOIP2011 普及组] 统计单词数

- 细节：全部转为小写。用 `string` 存储当前单词.
- 匹配失败就寻找下一个空格，再寻找下一个非空字符，重新统计单词.

= 进阶: 难题和真题

==

- P1029	[NOIP2001 普及组] 最大公约数和最小公倍数问题
  - $"let" c = y_0 / x_0$，将 $c$ 拆为两个数且互质. 两个互质的数的最小公倍数为其乘积，所以只需要考虑 $c$ 的因数即可.
  - 另一种方法：$"lcm" * "gcd" =$ 两数乘积，枚举其中较小的数字即可.
- P1205	[USACO1.2] 方块转换 Transformations
- P5730	【深基5.例10】显示屏
