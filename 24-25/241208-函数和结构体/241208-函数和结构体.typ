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
    title: [函数和结构体 | 真题],
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

== 复习

=== 枚举因数判断质数

- ```cpp
bool flag = true; // 是否为质数
for (int j = 2; j * j <= i; j++)
    if (i % j == 0) {
        flag = false;
        break;
    }
```

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

== P5732 【深基5.习7】杨辉三角

- 令 $a_(i, j)$ 为杨辉三角第 $i$ 行第 $j$ 个数
  - 相加关系: $a_(i, j) = "? + ?"$
  - 初始条件: 每一行的第一个数为 $1$
- 杨辉三角表示组合数 $C_i^j$ . Why?

=== string 字符串用法

- C++ 中的 `string` 类型也可以用来存储字符串，有时候比数组方便.

=== 读入输出

- `string s; cin >> s;` 同样是读入到空格为止
- `cout << s;`
- `getline(cin, s);` 读入一行，存入 `s`

=== 遍历每一位

- `for (int i = 0; i < s.length(); i++)`
  - 这里 `s.length()` 是字符串长度

== P1765 手机

#slide[
#figure(image("pic/image.png"))
][
- 提示: 用数组记录所有字母需要的按键次数.
]

#pagebreak()

```cpp
int ans;
string a;
int num[26] = {
    1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 4, 1, 2, 3, 1, 2, 3, 4
}; // 26个字母打表需要按几次
int main() {
    getline(cin, a);
    for (int i = 0; i < a.length(); i++) {
        if (a[i] >= 'a' && a[i] <= 'z')
            ans += num[a[i] - 'a'];
        if (a[i] == ' ')
            ans++;
        // 这种写法是很稳妥的，就算有换行符也不会出错
    }
    cout << ans << endl;
    return 0;
}
```

= 函数

==

#figure(image("pic/image copy.png"))

- 我们之前学过 `sqrt` 函数和 `max` 函数，现在可以自定义一些函数.

#figure(image("pic/image copy 2.png"))

=== 函数定义格式

  ```
  返回类型 函数名 (类型一 参数一, 类型二 参数二...) {
      ...各种代码
      return 返回结果;
  }
  ```

- [..] 讲解函数在代码中的执行顺序.
- 函数可以让代码逻辑更清晰，尤其是一个部分要多次使用的时候.

#figure(image("pic/image copy 3.png"))

- 一个函数里定义的变量，只能在自己内部使用，在其他函数里是不能使用的。比如 `dist()` 和 `main()` 内部定义的变量不能被对方访问.
- 一次函数运行结束以后，定义的变量都会消失.

== 素数筛（函数形式）

#figure(image("pic/image copy 4.png"))

#figure(image("pic/image copy 5.png"))

- 函数内部的变量为局部变量，外部无法访问.

=== void 类型函数
 
- 就是什么都不返回的函数.

#figure(image("pic/image copy 6.png"))

这一部分可以拆成 `input()` 函数和 `output()` 函数. （但没必要）

== 交换变量?

#figure(image("pic/image copy 7.png"))

- [动手] 这样真的交换了 a 和 b 吗？
- No! 实际上 `swap(a, b)` 会把 `a` 和 `b` 的值传给函数内部的 `x` 和 `y`，这里 `x` 和 `y` 是新的变量了，不论怎么操作都不会影响外部.
  - 这一过程中实际上有四个变量，因为调用 `swap()` 的时候创建了两个新的变量 `x` 和 `y`.

=== 传入引用

```cpp
void swap(int& x, int& y) {
    int t = x;
    x = y;
    y = t;
}
```

- 这样做就可以真正交换 `a` 和 `b` 的值了. Why? 在类型后面加一个 `&`，就变成引用类型。这样调用 `swap()` 的时候就不会创建两个新变量，而是直接传入 `a` 和 `b` 本身.
  - 相当于只是给外面的 `a` `b` 取了一个新名字. 这一过程中只有 2 个变量出现.

== string 的函数

#figure(image("pic/image copy 8.png"))

- 动手实现

#pause

#figure(image("pic/image copy 9.png"))

- 理解这一过程：调用函数时会创建一个新的变量，修改后再返回。此时原变量 `s1` 没有改变，新变量被传给了 `s2`

== 自己调用自己（递归）

#figure(image("pic/image copy 10.png"))

- 注意不让用循环.

#figure(image("pic/image copy 11.png"))

- 函数可以调用自己. [..] 画出调用图.
  - 这个先深入几层调用再逐个返回的过程叫做*递归*.

== 递归版 gcd (B4025	最大公约数)

```cpp
int gcd(int a, int b) {
    if (b == 0)
        return a;
    return gcd(b, a % b);
}
```

- [..] 画出函数调用图.

= 结构体

==

#figure(image("pic/image copy 12.png"))

- 结构体可以把多个类型组合在一起，形成一个新的类型. 一个学生包含多个类型的信息，所以我们可以创建一个学生结构体.

```cpp
struct student {
    string name;
    int chinese, math, english;
};
```

这样我们就可以定义 `student` 类型的变量了! 定义了 `student` 类型的变量 `a` 之后，`a` 就有了 `name`, `chinese`, `math`, `english` 这四个属性，可以用 `a.name` 等来获得这些属性.

```cpp
student ans, read;
int n;
cin >> n;
for (int i = 1; i <= n; i++) {
    cin >> a.name >> a.chinese >> a.math >> a.english;
    if (a.chinese + a.math + a.english > ans.chinese + ans.math + ans.english)
        ans = a;
}

cout << ...
```

== 成员函数

- 目前知道有这个东西就行.
- 结构体除了可以有多个变量，还可以有自己的函数.

```cpp
struct student {
    string name;
    int chinese, math, english;
    int sum() { // 根据自己的信息计算总分
        return chinese + math + english;
    }
};
```

```cpp
student a;
a.chinese = 100;
a.math = 90;
a.english = 80;
cout << a.sum() << endl; // 也是用 . 来调用
```

- 这就是 `string s; s.length()` 的原理.

== 旗鼓相当的对手加强版 P5741

- 提示：定义一个 `student` 结构体，然后定义 `student a[1050]` 存储一个结构体数组. 比如第 `i` 的学生的信息可以使用 `a[i].name, a[i].chinese...` 来访问.

= 真题

== P1003 [NOIP2011 提高组] 铺地毯

结构体存储矩形左上角和右下角，判断点是否在矩形内部即可.

== P1002 [NOIP2002 普及组] 过河卒

用 $f_(i, j)$ 表示到达 $(i, j)$ 的方案数，每个点的方案数包含从上方走过来和从左边走过来的两种的和.

```cpp
const int fx[] = { 0, -2, -1, 1, 2, 2, 1, -1, -2 };
const int fy[] = { 0, 1, 2, 2, 1, -1, -2, -2, -1 };
int bx, by, mx, my;
ll f[40][40];
bool s[40][40]; //判断这个点有没有马拦住
int main() {
    scanf("%d%d%d%d", &bx, &by, &mx, &my);
    bx += 2;
    by += 2;
    mx += 2;
    my += 2;
    //坐标+2以防越界
    f[2][1] = 1; //初始化
    s[mx][my] = 1; //标记马的位置
    for (int i = 1; i <= 8; i++)
        s[mx + fx[i]][my + fy[i]] = 1;
    for (int i = 2; i <= bx; i++) {
        for (int j = 2; j <= by; j++) {
            if (s[i][j])
                continue; // 如果被马拦住就直接跳过
            f[i][j] = f[i - 1][j] + f[i][j - 1];
        }
    }
    printf("%lld\n", f[bx][by]);
    return 0;
}
```

== P1008 [NOIP1998 普及组] 三连击

先枚举第一个数，自然求出另外两个数，再判断九个数是否都出现了.

```cpp
for (int i = 1; i < 333; i++) { //因为三个数为n,n*2,n*3,n*3<=1000,所以n<333
    j = i * 2;
    k = i * 3;
    n = 0;
    memset(w, 0, sizeof(w)); // 清空 w
    w[i / 100] = 1;
    w[i / 10 % 10] = 1;
    w[i % 10] = 1; //判断是否有重复数字
    w[j / 100] = 1;
    w[j / 10 % 10] = 1;
    w[j % 10] = 1;
    w[k / 100] = 1;
    w[k / 10 % 10] = 1;
    w[k % 10] = 1;
    for (int t = 1; t < 10; t++)
        n = w[t] + n;
    if (n == 9) //如果九个数都有，输出
        cout << i << " " << j << " " << k << endl;
}
```

== P1011 [NOIP1998 提高组] 车站

手推发现车站剩余人数关于 a 和 k（第一次上车人数）的系数是斐波那契数列.

```cpp
#include <iostream>
using namespace std;
int a, n, m, x, ans;
int f[20], sum[20];
int main() {
    cin >> a >> n >> m >> x;
    ans = a;
    if (x >= 3)
        ans += a; //特判
    if (x >= 4) {
        f[1] = f[2] = 1;
        for (int i = 3; i <= n - 4; i++)
            f[i] = f[i - 1] + f[i - 2]; //求斐波那契数列
        for (int i = 1; i <= n - 4; i++)
            sum[i] = sum[i - 1] + f[i]; //求前缀和
        int y = (m - sum[n - 5] * a - ans) / sum[n - 4]; //用推出的公式求y
        ans += sum[x - 4] * a + sum[x - 3] * y; //将答案加回
    }
    cout << ans << endl;
    return 0;
}
```

== P1010 [NOIP1998 普及组] 幂次方

```cpp
// 对于每个子问题必然都要先求到最大幂，如第一个子问题最大幂是7，幂不是0、1、2就要把幂当成一个子问题，对幂递归求解。
#include <stdio.h>
int a[30];
void dfs(int n) {
    //幂为0、1、2则直接输出，>=3则递归求解。
    int i = 0;
    if (n != 0) {
        while (n >= a[i])
            i++;
        i--; //找到最大的幂
        n -= a[i]; //下面12~20行是处理减去的这部分。
        printf("2");
        if (i != 1)
            printf("("); //注意1次幂是2而不是2(1)
        if (i == 0 || i == 2)
            printf("%d)", i); //幂为0、1、2时可输出幂(幂1时无输出)
        //如果幂>=3，对幂递归，不输出幂。
        if (i >= 3) {
            dfs(i);
            printf(")");
        } //递归求解，再添加右括号。
        if (n != 0) {
            printf("+");
            dfs(n);
        } //子问题与子问题之间用+连接;处理剩余的n(子问题)。
    }
```
#pagebreak()
```cpp
    return;
}
int main(void) {
    int i, n;
    a[0] = 1;
    for (i = 1; i < 50; i++)
        a[i] = a[i - 1] * 2; //a：1 2 4 8 16 32……
    scanf("%d", &n);
    dfs(n);
    return 0;
}
```
