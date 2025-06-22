// [typst 0.13]
#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.4" as fletcher: node, edge
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion

#import "@preview/grayness:0.2.0": *

// #let data = read("img/ignoreme-19.jpg", encoding: none)

// #set page(background: transparent-image(data, alpha: 50%, width: 100%, height: 100%))

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  // config-common(handout: true),
  config-common(frozen-counters: (theorem-counter,)), // freeze theorem counter for animation
  config-info(
    title: [集合],
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
  it,
)
#show raw.where(block: true): it => box(
  fill: rgb(248, 248, 248),
  outset: 8pt,
  radius: 3pt,
  stroke: 0.5pt + gray,
  it,
)
#show raw: it => box()[
  #set text(font: ("Cascadia Mono", "Sarasa Term SC Nerd", "Zed Mono Extended"))
  #it
]

// [my.text]
#set text(20pt)
#set text(font: "Microsoft YaHei")
#show strong: set text(weight: 900) // Songti SC 700 不够粗

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
#let im(p, h: auto) = {
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

== 复习：二叉树

== 满二叉树，完全二叉树

一个二叉树，如果每一个层的结点数都达到最大值，则这个二叉树就是满二叉树。

或者说除了最后一层，所有结点都有两个儿子！

#im(10)

如果二叉树除了最后一层有缺失外，其它是满的，且最后一层缺失的叶子结点只出现在右侧，则这样的二叉树叫完全二叉树。定义是：若二叉树的深度为n，除第n层外，其余各层的结点都达到了最大，且第n层的结点都连续集中在最左边。简而言之，就是从左到右结点是连续不断的二叉树就叫完全二叉树。满二叉树是特殊的完全二叉树。

#im(11)

== 遍历二叉树

二叉树遍历的意思是将一棵二叉树从根结点开始，按照指定顺序，不重复、不遗漏地访问每一个结点。在完成一些任务中，必须要访问所有结点的信息，那么就需要按照某种方式不重复、不遗漏地访问所有结点。

例1: 二叉树层次遍历。

分析：遍历是指沿着某条搜索路线，依次对树中的每个结点均做一次且仅做一次访问。直接对二叉树进行广度优先搜索，将根结点放入初始队列中，取出每次出队的结点，即可得到层次遍历。取出时别忘了把这个结点的子结点放到队伍的末尾。二叉树的层次遍历如图16-7所示。

从图16-7可以看出，这棵二叉树的层次遍历就是1273645。

#im(5)

==

=== 先序遍历

先序遍历的顺序是：根结点 -> 左子树 -> 右子树。

#im(12, h: 60%)

#im(13, h: 60%)

=== 中序遍历

中序遍历的顺序是：左子树 -> 根结点 -> 右子树。

=== 后序遍历

后序遍历的顺序是：左子树 -> 右子树 -> 根结点。

==

#im(14)

==

#im(15)

== 完成 T610447 求先序中序后序遍历

#slide[
  ```cpp
  ...using namespace std;
  struct Tree {
      int left, right;
  } t[100];

  void dfs1(int x) {
      if (!x) return;
      cout << x << " ";
      dfs1(t[x].left);
      dfs1(t[x].right);
  }

  void dfs2(int x) {
      if (!x) return;
      dfs2(t[x].left);
      cout << x << " ";
      dfs2(t[x].right);
  }

  void dfs3(int x) {
      if (!x) return;
      dfs3(t[x].left);
      dfs3(t[x].right);
      cout << x << " ";
  }
  ```
][
  ```cpp

  int main() {
      int n;
      cin >> n;
      for (int i = 1; i <= n; i++) {
          cin >> t[i].left >> t[i].right;
      }
      dfs1(1);
      cout << endl;
      dfs2(1);
      cout << endl;
      dfs3(1);
      return 0;
  }
  ```
]

== 并查集

#im(0)

并查集的重要思想在于，用集合中的一个元素代表集合。我们把集合比喻成帮派，而代表元素则是帮主。接下来我们利用这个比喻，看看并查集是如何运作的。最开始，所有大侠各自为战。他们各自的帮主自然就是自己。这里的箭头表示它认谁为大哥。

#im(1, h: 60%)

现在1号和3号两个帮派要合并，我们可以让3号就认1号作大哥。谁作为大哥都可以，只要认了大哥就是合并了。

图中 3 指向 1 表示 3 号帮派认 1 号为大哥。

#im(2, h: 60%)

#pagebreak()

现在2号所在帮派打算和3号所在帮派合并。但3号表示，别跟我打，让我帮主来收拾你，那么2号也认1号做大哥。观察一下这张图，每个人都是怎么确认帮主的呢？

如果某个人指向自己，那么他所在帮派的帮主。否则，他就要看自己的大哥是谁，他的大哥又要看自己的大哥是谁，直到找到帮主为止.

#im(3, h: 60%)

#pagebreak()

现在我们假设4、5、6号也进行了一番帮派合并，江湖局势变成下面这样：

#im(4, h: 60%)

此时2号想和6号合并他们的帮派，应该怎么办呢？

#pagebreak()

我们让"6号的帮主"认"2号的帮主"为大哥（或者方向反一下也行）。于是我们就让6号的帮主指向2号的帮主。

#im(6, h: 60%)

== 代码模拟每一步

用一样的思想我们可以处理家族关系，每个人都认一个人作为长辈，如果要合并两个家族，就让一个家族的祖先指向另一个家族的祖先。

== 优化并查集

在合并时将这个“族谱树”（或者大哥树）变成长长的一条链，这样每次查询就必须从底部开始一层一层地往上遍历所有的结点才能查询到族长是谁，效率很低。

#im(7, h: 60%)

优化：我们刚才的 find 函数可以找到每个人的祖先是谁。这个过程中，一旦找到祖先，我们就让他们直接指向祖先，这样下次查询的时候就可以一步直接找到祖先了。

#im(8, h: 60%)

== P1536 村村通

[..]

== 字符串哈希（洛谷 P3370）

给定 N(N≤10000) 个字符串,第 i 个字符串长度为 M_i(M_i≤1500),字符串内包含数字、大小写字母(大小写敏感)，请求出 N 个字符串中共有多少个不同的字符串。

分析:先来分析一个简化版的问题：给定 N 个自然数,值域是[0,10^7],求出这 N 个自然数中共有多少个不同的自然数。
如果值域是[0,10^7]，那么定义一个[0,10^7]的大数组 a,每个位置 a[x]所对应的值为 0 代表这个值 x 并没有出现过,为 1 则代表这个值 x 出现过。然后将这 N 个自然数一个个进行判断,如果 a[x] 为 0,则这个数没统计过,把答案加 1,然后把 a[x] 设为 1;否则,这个数已经被统计过了,不对答案进行改变。

那么值域是[0,10^9],该怎么办呢?可以取一个模数 mod,定义一个大大小为 mod 的数组,然后把每个数对 mod 取模。如果两个数对 mod 取模得到相同的值,那么就认为这两个数是相同的。代码: ...

==

可以发现，这个处理方法的优势和劣势都很明显。优势是这个做法有效地减少了空间的利用，只需要定义一个大小为mod的数组。而劣势是，如果有两个不同的数恰好对mod取模之后得到了相同的结果，那这个算法的正确性就得不到保证了——算法会认为这两个数是同一个数，但实际上是两个不同的数，产生了冲突。

该如何优化这个算法，使得一个 mod 为止可以存储多个值？可以把一个int的数组改成一个vector<int>的数组或者一个链表，然后将取模后为同一个数的所有值都存在其对应的vector或者链表中。

然后每次判断一个数x是否存在的时候，遍历x%mod位置的vector或链表中所有元素，看是否有x即可。下面给出代码，使用vector来存元素:

```cpp
#include <iostream>
#include <vector>
const int mod = 233333;
using namespace std;
int n, x, ans;
vector <int> linker[mod + 2];
void insert(int x) {
    for (int i = 0; i < linker[x % mod].size(); i++)
        if (linker[x % mod][i] == x)
            return;
    linker[x % mod].push_back(x);
    ans++;
}
int main() {
    cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> x;
        insert(x);
    }
    cout << ans << endl;
    return 0;
}

```

#im(9, h: 60%)

回到原问题会发现存在一个问题：前面讨论的都是对数字的处理，而一个字符串该如何当作一个数字呢？

还记得前面讲过的ASCII编码吗？这就是将单个字符映射成一个数字的方式。比如说，字符串abAB01就可以映射成

97,98,65,66,48,49

希望把这串序列映射成0到mod-1中的一个数字，称为字符串的Hash值。转换方式：我们把序列中的每一位当作 k 进制数的某一位。转换的方式和k进制转换为十进制一样，就是不断地进行迭代运算hash=(hash*k+s[i])%mod即可。

这里的模数mod会取一个比较大的质数以减少冲突的可能性，而且在空间足够的情况下越大越好。常用的模数有10007、99983等，可以根据实际情况选择合适的数字。

由于可能有多个不同的字符串对应同一个Hash值，对每个Hash值建立一个vector（或者链表），用来存储对应于每个Hash值的所有字符串。这样每次只需要将这个插入的字符串及其Hash值相同的所有字符串比较，看是否相等，就可以知道这个字符串有没有出现过了。

== set 用法

#im(17)

#im(16)

```cpp
#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; cin >> n;
    set<int> s;
    while (n--) {
        int op, t; cin >> op >> t;
        if (op == 1) {
            if (s.count(t) == 1)
                cout << "Already Exist" << endl;
            else
                s.insert(t);
        } else {
            if (s.empty()) {
                cout << "Empty" << endl;
                continue;
            }
            auto low = s.lower_bound(t);
            int choice1 = *low;
            if (low != s.begin())
                --low;
            int choice2 = *low;
            int ans = abs(choice2 - t) <= abs(choice1 - t) ? choice2 : choice1;
            s.erase(ans); // 删除木头
            cout << ans << endl;
```

```cpp
        }
    }
    return 0;
}
```

== map 用法

#im(18)
