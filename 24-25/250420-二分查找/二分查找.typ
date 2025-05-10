// [typst 0.13]
#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.4" as fletcher: node, edge
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  // config-common(handout: true),
  config-common(frozen-counters: (theorem-counter,)),  // freeze theorem counter for animation
  config-info(
    title: [二分查找],
    subtitle: [],
    author: [方俊杰.SJTU],
    date: datetime.today(),
    institution: [交附闵分],
    logo: emoji.school,
  ),
)

// [my]
// [my.config]
#let tea = false
#let tbl = it => {
  if tea {
    it
  }
}

// [my.heading]
#show heading.where(level: 1): set heading(numbering: numbly("{1}.", default: "1.1"))

// [my.code]
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
  
// [my.text]
#set text(20pt)
#set text(
  font: ("Microsoft YaHei")
)
#show strong: set text(weight: 900)  // Songti SC 700 不够粗

#set list(indent: 0.8em)
#show link: underline

// [my.util]
#let emp = it => {
  strong(text(fill: red)[#it])
}

#let alert(body, fill: yellow) = {
  // set text(fill: white)
  rect(
    fill: fill,
    inset: 8pt,
    radius: 4pt,
    [*注意:\ #body*],
  )
}

#let hint(body, fill: blue) = {
  rect(
    fill: fill,
    inset: 8pt,
    radius: 4pt,
    [*#body*],
  )
}

#let lin = line(length: 100%)
#let im(p, h: 100%) = {
  if p == 0 {
    figure(image("img/image.png", height: h))
  } else if p == 1 {
    figure(image("img/image copy.png", height: h))
  } else {
    figure(image("img/image copy " + str(p) + ".png", height: h))
  }
}
// [my.end]

#title-slide()

== Outline <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 1em))

== 复习: 上节课学习: 贪心

=== 买菜

你要去菜市场买空心菜，螃蟹，西红柿，如何使总花费最少？就是去每个摊位都问价格，把这四种菜都买最便宜的。这就是贪心法。

=== 线段覆盖

给定一组线段，求最多能选出几个不相交的线段。

做法：按照线段的右端点从小到大排序，选出第一个线段，然后选择不相交的且右端点最靠左的线段。这样一定是最优的。

=== 合并果子

给定几堆果子，第 i 堆重量 $a_i$，每次可以两堆合并成一堆，合并的代价是两堆重量之和。求把所有果子合并成一堆的最小代价。

贪心法：每次都选择两堆最小的合并，就是最优的。举几个例子就会感觉比较正确，如果要充分证明则要用哈夫曼树。

在程序中，每次生成新的一堆以后都要排序。

= 二分查找

== 二分游戏

```cpp
#include <bits/stdc++.h>
using namespace std;
int main() {
    srand(time(0)); // 随机数种子
    const int ans = rand() % 1000 + 1;
    int cnt = 0;
    while (true) {
        int guess;
        cout << "请输入你猜的数字（1-1000）：";
        cin >> guess;
        if (guess < 1 || guess > 1000) {
            cout << "输入错误，请输入1-1000之间的数字。" << endl;
            continue;
        }
        cnt++;
        cout << "第 " << cnt << " 次猜测：";
        if (guess < ans) {
            cout << "猜小了！" << endl;
        } else if (guess > ans) {
            cout << "猜大了！" << endl;
        } else {
            cout << "恭喜你，猜对了！" << endl;
            cout << "答案是：" << ans << endl;
            break;
        }
    }
}
```

== 最好的策略是什么？

一开始可能的范围是 [1, 1000]，每次都猜中间那个数。比如你猜 500，如果大了，就排除 [500, 1000]，如果小了，就排除 [1, 500]。这样每次都能排除一半的范围。

这样下去范围会越来越小，用不了几次就能猜中。

思考：在二分的策略下最多需要几次一定能猜中？

== 查字典问题

有一个特殊的字典，每页内容上只有某个*数字*，且从小到大排序。每次你只能查某一页上是什么数字。

#let t1(l: 0, r: 0, mid: 0, r2: range(1, 16).map(_ => [?])) = align(center,
table(
  columns: 16,
  [页码], ..range(1, 16).map(i => if i == mid { [#i #hint[mid]] } else if i == l { [#i #hint[l]] } else if i == r { [#i #hint[r]] } else { [#i] }),
  [内容（从小到大）], ..r2.map(i => [#i]))
)

#t1()

现在问你，`160` 这个数字是否在这个字典中？

=== 方法一：暴力查找

从第一页开始，逐页查找，直到找到 160 这个数字为止。最坏情况下需要查 16 页。

=== 方法二：二分查找

从中间开始查找，先查第 8 页，如果上面的数字是 160，就找到了；
- 如果小于 160，就在第 8 页的右边继续查找，因为它只有可能在右边。
- 如果大于 160，就在第 8 页的左边继续查找。
这个方法比暴力查找要快，最多只要查 4 次。

#pagebreak()

用程序模拟这个过程. 字典用 `a` 数组表示，`a[i]` 表示第 i 页的内容. 要找 160 所在页码.

首先可能答案的区间是 [1, 15]，我们让 `int l = 1, r = 15;` 表示这个区间的左右端点。


```cpp
int l = 1, r = 15, ans = -1;
while (l <= r) {
    int mid = (l + r) / 2;
    if (a[mid] == 160) {
        ans = mid;
        break;
    } else if (mid < 160)
        l = mid + 1;
    else
        r = mid - 1;
}
```

#t1(l: 1, r: 15)

循环中我们每次都取中间的页码 `int mid = (l + r) / 2;`，
- 如果这个页码的内容是 160，就找到了；
- 如果小于 160，就在右边继续查找； `l = mid + 1;`，把区间缩小到右半边.
- 如果大于 160，就在左边继续查找。 `r = mid - 1;`

*发现 `a[mid]` 小于 160:*

#t1(l: 1, r: 15, mid: 8, r2: ("?", "?", "?", "?", "?", "?", "?", "122", "?", "?", "?", "?", "?", "?", "?"))

``

#pagebreak()

*执行 `l = mid + 1`:*

#t1(l: 9, r: 15, mid: 8, r2: ("?", "?", "?", "?", "?", "?", "?", "122", "?", "?", "?", "?", "?", "?", "?"))

*进入下一个循环，求取新的 mid = (l + r) / 2:*

#t1(l: 9, r: 15, mid: 12, r2: ("?", "?", "?", "?", "?", "?", "?", "122", "?", "?", "?", "?", "?", "?", "?"))

#pagebreak()

*发现 `a[mid]` 大于 160:*

#t1(l: 9, r: 15, mid: 12, r2: ("?", "?", "?", "?", "?", "?", "?", "122", "?", "?", "?", 185, "?", "?", "?"))

*执行 `r = mid - 1`:*

#t1(l: 9, r: 11, mid: 12, r2: ("?", "?", "?", "?", "?", "?", "?", "122", "?", "?", "?", 185, "?", "?", "?"))

#pagebreak()

*进入下一个循环，求取新的 mid = (l + r) / 2:*

#t1(l: 9, r: 11, mid: 10, r2: ("?", "?", "?", "?", "?", "?", "?", "122", "?", "?", "?", 185, "?", "?", "?"))

*发现 `a[mid]` 等于 160:*

#t1(l: 9, r: 11, mid: 10, r2: ("?", "?", "?", "?", "?", "?", "?", "122", "?", 160, "?", 185, "?", "?", "?"))

*执行 `ans = mid` 并退出循环*，此时 `ans` 记录了正确答案的下标.

== 代码演示

一定要保证数组有序，才能用二分查找。

=== 要找第一次出现的位置，怎么办？ [..]

=== 复杂度分析 [..]

==

```cpp
#include <bits/stdc++.h>
using namespace std;
int a[1000010];
int main() {
    ios::sync_with_stdio(0);
    int n, m;
    cin >> n >> m;
    for (int i = 1; i <= n; i++) cin >> a[i];
    while (m--) {
        int x; cin >> x;
        int l = 1, r = n, ans = -1; // -1 表示没有找到
        while (l <= r) {
            int mid = (l + r) / 2;
            if (a[mid] == x && (mid == 1 || a[mid - 1] < x)) {
                ans = mid;
                break;
            }
            if (a[mid] < x) l = mid + 1;
            else r = mid - 1;
        }
        cout << ans << " ";
    }
    return 0;
}
```

== P1102 A-B 数对

#im(0)

已知 C，要在数组中找到 $A, B$ 满足 $A - B = C$ 用上一道题的方法找到.

思路：对于数组其中一个数，把它作为 $B$，那么数组中有几个数可以作为 $A$ 呢？就是在数组中找 $B + C$ 有几个.

可以对数组排序，用二分法快速找到 $B + C$ 最小的下标和最大的下标，两个下标之间的数都是 $B + C$.

#hint[代码演示]

=== 方法二

`lower_bound` 和 `upper_bound` 都是 STL 中的函数，分别表示第一个大于等于和第一个大于的下标.

用法:

`int first_equal = lower_bound(a + 1, a + n + 1, x) - a;` 表示第一个大于等于 $x$ 的下标.（实际上 lower_bound 本身返回 x 所在地址，减去 a 就是下标）
`int first_greater = upper_bound(a + 1, a + n + 1, x) - a;` 表示第一个大于 $x$ 的下标.

#hint[代码演示]

== P1873 [COCI 2011/2012 #5] EKO / 砍树

#im(1)

#im(2)

#im(3)

== P1824 进击的奶牛

#im(4)

#im(5)

#im(6)

#align(center,
```cpp
            R = mid - 1;                            
    cout << ans << endl;
}
```
)