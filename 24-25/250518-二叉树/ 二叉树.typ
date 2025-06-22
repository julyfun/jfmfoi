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
    title: [二叉树],
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

== 复习：深度优先搜索

=== 模板示例

```cpp
int a[10], n;
void dfs(int pos) {
    if (pos == n + 1) {
        for (int i = 1; i <= n; i++) {
            cout << a[i] << " ";
        }
        cout << endl;
        return;
    }
    // 探索两种情况
    a[pos] = 0;
    dfs(pos + 1);
    a[pos] = 1;
    dfs(pos + 1);
}

```

=== 经典例题之八皇后

#im(0)

==

如何填写一个 $6 times 6$ 的棋盘. 使得任意两个皇后之间不相互攻击？

- 首先考虑到，逐行填写。
- 第一行有 $6$ 种填法（第 $1$ 列，第 $2$ 列，...，第 $6$ 列）。
  - 第二行在之前的基础上，有 $6$ 种填法，其中有一些是非法的，我们就跳过它（return）
    - 第三行在之前的基础上，有 $6$ 种填法，其中有一些是非法的
      - ...

```cpp
int n, a[20], ans;
void dfs(int x) { // 填第 x 行
	if (x == n + 1) { // 找到答案了，输出
    // [..] 输出答案
	}
	for (int y = 1; y <= n; y++) { // 试图填在第 y 列
		int flag = 0; // 从第 1 行到第 x - 1 行中是否有与我冲突的棋子
		for (int i = 1; i <= x - 1; i++) {
			// 这一行的棋子坐标为 (i, a[i])
			if (a[i] == y || i + a[i] == x + y || i - a[i] == x - y) {
				flag = 1; // 标记为找到冲突
				break;
			}
		}
		if (flag)
			continue;
		a[x] = y; // 第 x 行的棋子填在第 y 列
		dfs(x + 1); // 继续填下一行
	}
}
```

== 二叉树

#im(1)

== 例题：淘汰赛

#im(2)

#import "@preview/grayness:0.2.0": *


- 第二强的不一定是亚军. 比赛的过程呢可以看成一个二叉树.

#im(3)

==

可以看出,最厉害的5号国家是当之无愧的冠军,但是1号国家实力不怎么样,只是在决赛之前遇到的对手更弱,所以侥幸闯进了决赛;而7号国家也挺厉害,但很不幸在半决赛遇到了冠军5号所以惨遭淘汰。可见,并不是第二强的国家就一定能拿到亚军。

从图16-3中还可以看到,从冠军(根结点)往下面看,每个获胜者结点下面都是2个国家。这就是一棵典型的二叉树。更加严格的递归定义是:二叉树要么为空,要么由根结点、左子树、右子树构成,而左右子树分别还是一棵二叉树。

== 严格来说何为树，何为二叉树?

树是由结点组成的。把结点连接起来，而且不能连出环，那就是一颗树.

#im(6)

=== 结点 与 叶子结点

结点就是树的一个节点，叶子结点是指度为0的结点，即没有分支的结点。

== 有根树和无根树

#im(7)

所谓的无根，就是没有明确的根节点。

#im(8)

把图中任何一个蛋提拎起来，都能变成根蛋（根节点）。比如把蛋F拎起来，就可以变成下面的树：

#im(9, h: 70%)

== 二叉树

每个结点最多有两个儿子的特殊的树。

==

如何把比赛过程用代码转换成二叉树？首先要构建底层。

#im(3)

#slide[
  ```cpp
  ...using namespace std;

  int value[260], winner[260];
  int n;

  void dfs(int x) {
      if (x >= 1 << n)
          return;
      else {
          dfs(2 * x); // 遍历左子树
          dfs(2 * x + 1); // 遍历右子树
          int lvalue = value[2 * x], rvalue = value[2 * x + 1];
          if (lvalue > rvalue) { // 左结点获胜
              value[x] = lvalue; // 记录下获胜方的能力值
              winner[x] = winner[2 * x]; // 和获胜方的编号
          } else { // 右结点获胜
              value[x] = rvalue;
              winner[x] = winner[2 * x + 1];
          }
      }
  }
  ```
][
  ```cpp
  int main() {
      cin >> n;
      for (int i = 0; i < 1 << n; i++) {
          cin >> value[i + (1 << n)]; // 读入各个结点的能量值
          winner[i + (1 << n)] = i + 1; // 叶子结点的获胜方就是自己国家的编号
      }
      dfs(1); // 从根结点开始遍历
      cout << (value[2] > value[3] ? winner[3] : winner[2]); // 找亚军
      return 0;
  }
  ```
]

== 求深度: 用结构体构建二叉树

#im(4)

```cpp
...const int MAXN = 2e5 + 7;
struct Node {
    int left, right;
} t[MAXN];

int n;

void build() {
    for (int i = 1; i <= n; i++) {
        cin >> t[i].left >> t[i].right;
    }
}

int dfs(int x) {
    if (!x) return 0;
    return max(dfs(t[x].left), dfs(t[x].right)) + 1;
}

int main() {
    cin >> n;
    build();
    cout << dfs(1);
    return 0;
}

```

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



== 求后序遍历

输入：

#im(16)

==

```
　　　　　　　　 C
　　　　　　   /  \
　　　　　　  /　　\
　　　　　　 B　　  G
　　　　　　/ \　　/
　　　　   A   D  H
　　　　　　  / \
　　　　　　 E   F

```

==

分析：通过前序遍历可以找出当前二叉树的根（即前序遍历中第一个位置的值），然后可以在中序遍历中找到当前二叉树的根所在的位置，此时可以得到左子树和右子树的大小，于是可以继续递归下去操作。
仍以上面的树为例子。
1）前序遍历：1234567。
2）中序遍历：4352617。
先找出前序遍历的根1，然后在中序遍历中找到1的位置。

1）前序遍历：[1]234567。

2）中序遍历：43526[1]7。

所以“43526”这些数都是在以1为根的左子树里面，“7”是在以1为根的右子树里面。因此，可以在前序遍历中提取出“23456”这个区间作为左子树的前序遍历，“7”这个区间作为右子树的前序遍历。然后递归的时候按照后序遍历的顺序输出根结点的值即可。于是可以递归求解：

```cpp
void build(int l1, int r1, int l2, int r2) {
    for (int i = l2; i <= r2; i++) {
        if (b[i] == a[l1]) {
            build(l1 + 1, l1 + i - l2, l2, i - 1);
            build(l1 + i - l2 + 1, r1, i + 1, r2);
            cout << a[l1] << " ";
        }
    }
    return;
}

```

== 求子树的大小和总权重？

== 医院设置

#slide[
  #im(17)
][
  #im(18)
]

#slide[
  ```cpp
  #include <bits/stdc++.h>
  using namespace std;
  const int N = 105;
  struct Node {
      int l, r;
      int w;
  };
  int ans = 0, sz[N], dep[N];
  Node t[N];
  void dfs(int u) {
      sz[u] = t[u].w;
      int l = t[u].l, r = t[u].r;
      if (l) {
          dep[l] = dep[u] + 1;
          dfs(l);
          sz[u] += sz[l];
      }
      if (r) {
          dep[r] = dep[u] + 1;
          dfs(r);
          sz[u] += sz[r];
      }
  }
  void find(int u, int sum) {
  ```
][
  ```cpp
      if (u != 1) {
          sum -= sz[u];
          sum += sz[1] - sz[u];
          ans = min(ans, sum);
      }
      if (t[u].l)
          find(t[u].l, sum);
      if (t[u].r)
          find(t[u].r, sum);
  }
  int main() {
      int n;
      cin >> n;
      for (int i = 1; i <= n; i++) {
          cin >> t[i].w >> t[i].l >> t[i].r;
      }
      dep[1] = 0;
      dfs(1);
      for (int i = 1; i <= n; i++) {
          ans += dep[i] * t[i].w;
      }
      find(1, ans);
      cout << ans << endl;
      return 0;
  }

  ```
]
