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
    title: [模拟和高精度],
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

- [..] 作业完成情况
- [..] 点击参与作业题单 https://www.luogu.com.cn/team/16908#homework

== 复习: 函数和结构体

=== 定义函数: 类型, 参数, 返回值

- ```cpp
int mmax(int x, int y) {
    if (x > y)
        return x;
    return y;
}
```

=== 函数递归

- ```cpp
  int f(int x) {
      if (x == 1)
          return 1;
      return f(x - 1) * x;
  }
  ```
- 边界条件: 参数为 1 时，$f(1) = 1$
- 否则，$f(x) = f(x - 1) times x$
- 这里的函数调用会形成一条链. [..]

#pagebreak()

#lin

=== 输入 $n$，用递归函数求解斐波那契数列的第 $n$ 项.

- $1, 1, 2, 3, 5, 8, 13...$
- 边界条件：[?]
- 递推关系：斐波那契数列满足什么方程 [?]
- 需要完成如下函数:

  ```cpp
  int f(int n) {
      ...
  }
  ```

== 结构体

- 结构体可以把多个类型组合在一起，形成一个新的类型. 一个学生包含多个类型的信息，所以我们可以创建一个学生结构体.

  ```cpp
  struct student {
      string name;
      int chinese, math, english;
  };
  ```

- 这样我们就可以定义 `student` 类型的变量了! 定义了 `student` 类型的变量 `a` 之后，`a` 就有了 `name`, `chinese`, `math`, `english` 这四个属性，可以用 `a.name` 等来获得这些属性.

  ```cpp
  student ans, read;
  int n;
  cin >> n;
  for (int i = 1; i <= n; i++) {
      cin >> a.name >> a.chinese >> a.math >> a.english;
  }

  cout << ...
  ```

== 歌唱比赛

#figure(image("pic/image.png", height: 40%))

- 提示：写一个函数 `float score(int a[], int m)`，求取 `a` 数组中去掉最大值和最小值以后得平均值.
  - 注意到，将数组作为参数时，写成 `int a[]` 就行，不需要写大小。

#pagebreak()


#figure(image("pic/image copy 4.png"))

= 算法 1-1：模拟与高精度

== P1042 [NOIP2003 普及组] 乒乓球

- 首先要理解题目意思.
- 两人先打了很多局比赛。我们记录下了他们的比赛结果为 `WWWWWWWWWWWWWWWWWWWW
WWLWE (22 个 W，然后是 LWE)`，
- 然后假设按照 11 分制，相当于前 11 局是 W 赢了一场，接下来 11 局又是 W 赢了一场，最后 2 局是 LW 分别赢了一场. 所以输出是 `11:0    11:0    1:1`
- 接下来假设按照 21 分制，那么前 21 局是 W 赢了一场，最后情况是 `2:1`

=== 读入

- 使用 `while (cin >> tmp)` 来读入，先把所有结果存储到一个字符数组里. 方便后续分两种得分制讨论.

  ```cpp
  char a[2500 * 25 + 10];
  int n = 0;
  int main() {
      char tmp;
      while (cin >> tmp) {
          n += 1;
          a[n] = tmp;
      }
      cout << n << " " << a + 1 << endl;
  ```

- [测试]：输出 `a` 数组看看是否读入正确.

=== 11 分制

- 

  ```cpp
      int w = 0, l = 0;
      for (int i = 1; i <= n; i++) {
          if (a[i] == 'W') w++;
          else if (a[i] == 'L') l++;
          else if (a[i] == 'E') break; // 遇到 E 就要退出循环，不要处理 E 后面的对局
          if ((w >= 11 || l >= 11) && abs(w - l) >= 2) {
              cout << w << ":" << l << endl;
              w = l = 0;
          }
      }
      cout << w << ":" << l << endl;
  ```

- [测试]：看看 11 分制能否正确输出.

=== 21 分制

把上面部分复制一遍，把判断 11 分的地方改成 21 分.

=== 简化代码

11 分和 21 分有很多重复的地方. 可以把这部分代码提取出来作为一个函数.

```cpp
void print(int k) {
    int w = 0, l = 0;
    for (int i = 1; i <= n; i++) {
        if (a[i] == 'W') w++;
        else if (a[i] == 'L') l++;
        else if (a[i] == 'E') break;
        if ((w >= k || l >= k) && abs(w - l) >= 2) {
            cout << w << ":" << l << endl;
            w = l = 0;
        }
    }
    cout << w << ":" << l << endl;
}
```

- 这样做的好处是如果你某个地方写错了，不需要 11 分和 21 分都改，只需要在函数里改一次.

== P2670 [NOIP2015 普及组] 扫雷游戏

#slide[
#figure(image("pic/image copy 2.png", height: 50%), caption: "直角坐标系方向")
][
- 思路：把地图用读入到 `char` 数组里面。随后用 for 循环枚举每个 $(i, j)$ 坐标，对这个坐标统计周围 8 个格子的地雷数。

#figure(image("pic/image copy 3.png"))

- `(i + dx[0], j + dy[0])` 表示 $(i, j)$ 左下角的格子。
- `(i + dx[1], j + dy[1])` 表示 $(i, j)$ 下方的格子。
- ...
- 用 for 循环枚举 8 个方向，统计周围 8 个格子的地雷数。
]

#pagebreak()


== P1563 [NOIP2016 提高组] 玩具谜题

- 每个小人朝向圈内或者圈外。从第一个小人开始，我们会得到一个指令：向左数或者向右数 $y$ 个人。
- 如果朝向圈内且向左数，则标号减小。如果往右数，则标号增大。

#figure(image("pic/image copy 6.png", height: 50%))

#pagebreak()

#slide[
#figure(image("pic/image copy 7.png"))
][
- 用 `now` 表示到达的玩具小人，根据它的朝向和指令分 4 中情况讨论，更新 `now` 的值.
- 小人编号从 0 开始记，这样大于等于 $n$ 的时候直接模 $n$ 就行了.
]

== P1601 A+B Problem（高精）

- 由于数字很大，不能用 long long 直接存储，我们用数组存储每一位，然后模拟竖式加法的过程。

#figure(image("pic/image copy 8.png"))

- 假设 `a[]` 数组存储了 `{3, 7, 6, 8, 4}`， `b[]` 数组存储了 `{6, 4, 1, 3, 9}`（即数字的最低位存储在数组最低位）
- `c[0] = a[0] + b[0]`
- `c[1] = a[1] + b[1]`，此时 `c[1] >= 10`，我们让 `c[2] += 1`，`c[1] -= 10`
- ... 依次类推。一共要处理到第几位？就是 `a[]` 和 `b[]` 长度中较大的那一个.

#pagebreak()

=== 过程模拟

- `len = max(s.length(), t.length())` 所以 `len = 5`

#figure(image("pic/image copy 9.png"))

\

\

- 最后倒序输出 `c[]` 数组的前 `len` 位即可. 但在此之前，如果 `c[len] > 0`，说明最高位有进位，所以 `len++`.

```cpp
#include <iostream>
using namespace std;
string s, t;
int a[510], b[510], c[510];
int main() {
    cin >> s;
    cin >> t;
    // 第一步: 由于读入的字符串 s[0] 存储了最高位，我们要把它反转一下，用 a[0] 存储最低位, a[1] 存储第二低位..
    for (int i = 0; i < s.length(); i++)
        a[i] = s[s.length() - 1 - i] - '0';
    for (int i = 0; i < t.length(); i++)
        b[i] = t[t.length() - 1 - i] - '0';
    int len = max(s.length(), t.length());
    for (int i = 0; i < len; i++) {
        c[i] += a[i] + b[i];
        c[i + 1] += c[i] / 10;
        c[i] %= 10;
    }
    if (c[len] > 0)
        len++;
    for (int i = len - 1; i >= 0; i--)
        cout << c[i];
    return 0;
}
```

== P1303 A*B Problem

#figure(image("pic/image copy 10.png", height: 50%))

- 同样和竖式乘法的过程有点像。`a[0]` 存储了最低位，`a[1]` 存储了第二低位...
- 对于 `a[]` 和 `b[]` 的每一位，我们都要把它们相乘，然后把结果加到 `c[]` 的对应位置上。实际过程和我们手算竖式乘法稍有不同。

#pagebreak()

#figure(image("pic/image copy 12.png", height: 50%))

- [..]

#pagebreak()

#slide[
```cpp
#include <iostream>
using namespace std;
string s, t;
int a[5010], b[5010], c[5010];
int main() {
    cin >> s;
    cin >> t;
    int lena = s.length(), lenb = t.length();
    for (int i = 0; i < lena; i++)
        a[i] = s[lena - 1 - i] - '0';
    for (int i = 0; i < lenb; i++)
        b[i] = t[lenb - 1 - i] - '0';
    for (int i = 0; i < lena; i++)
        for (int j = 0; j < lenb; j++)
            c[i + j] += a[i] * b[j]; // 注意一定要写成 +=
    // 处理进位。c 最多有 lena + lenb 位。
    int lenc = lena + lenb;
    for (int i = 0; i < lenc; i++) {
        c[i + 1] += c[i] / 10;
        c[i] %= 10;
    }
```
][
```cpp
    // 可能有多余的 0，比如有一个乘数为 0..
    // 但是至少需要保留一位。
    while (lenc > 1 && c[lenc - 1] == 0)
        lenc--;
    for (int i = lenc - 1; i >= 0; i--)
        cout << c[i];
    return 0;
}
```
]

= 进阶：NOIP 真题

== P1328 [NOIP2014 提高组] 生活大爆炸版石头剪刀布

#slide[
- 先用一个二维数组存储该组合的胜利情况。模拟时，第 $i$ 个回合两人出圈方式可用 `a[i % Na], b[i % Nb]` 表示.
  ```cpp
  #include<bits/stdc++.h>
  using namespace std;

  int N, Na, Nb, resa, resb;
  int a[201], b[201];

  const int points[5][5] = 
  {
    {0, 0, 1, 1, 0},
    {1, 0, 0, 1, 0},
    {0, 1, 0, 0, 1},
    {0, 0, 1, 0, 1},
    {1, 1, 0, 0, 0}
  };

  ```
][

\

```cpp
int main()
{
	cin >> N >> Na >> Nb;
	for(int i = 0; i < Na; i++)
		scanf("%d", &a[i]);
	for(int i = 0; i < Nb; i++)
		scanf("%d", &b[i]);
		
	for(int i = 0; i < N; i++)
	{
		resa += points[ a[i%Na] ][ b[i%Nb] ];
		resb += points[ b[i%Nb] ][ a[i%Na] ];
	}
	printf("%d %d\n", resa, resb);
	return 0;
}
```
]

== P1067 [NOIP2009 普及组] 多项式输出

#slide[
```cpp
// 根据它是第几项以及系数，分类讨论
#include<bits/stdc++.h>
using namespace std;
int n;
int main(){
	scanf("%d", &n);
	int p = n;
	for(int i = n; i >= 0; i--){
		int x;
		scanf("%d", &x);
		if(x == 0) continue;
		if(i == n){
			if(x == 1)
				printf("x^%d", i);
			else if (x == -1)
				printf("-x^%d", i);
			else if(x > 0)
				printf("%dx^%d", x, i);
			else
				printf("-%dx^%d", abs(x), i);
			continue;
		}
}
		if(i == 1){
			if(x == 1)
```
][
```cpp
				printf("+x");
			else if(x == -1)
				printf("-x");
			else if(x > 0)
				printf("%+dx", x);
			else 
				printf("-%dx", abs(x));
			continue;
		}
		if(i == 0){
			if(x > 0)
				printf("+%d", x);
			else
				printf("%d", x);
			continue;
		}
		if(x == 1)
			printf("+x^%d", i);
		else if (x == -1)
			printf("-x^%d", i);
		else if(x > 0)
			printf("+%dx^%d", x, i);
		else 
			printf("-%dx^%d", abs(x), i);
	}
	return 0;
```
]

== P1045 [NOIP2003 普及组] 麦森数

- 寻找 $n$ 满足 $10^n <= 2^p - 1 <= 10^(n + 1)$
- $n <= log_10 (2^p - 1) <= n + 1$
- $2^p - 1$ 和 $2^p$ 一定位数一样！
- $n <= p dot log_(10) 2$
- 位数为 n + 1

#lin

求最后 500 位，需要对最后 500 为做快速幂 + 高精度加法。
