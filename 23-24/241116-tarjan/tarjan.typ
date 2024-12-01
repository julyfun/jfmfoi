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
    title: [算法-Tarjan],
    subtitle: [],
    author: [方俊杰.SJTU],
    date: datetime.today(),
    institution: [交附闵分],
    logo: emoji.school,
  ),
)

// #set heading(numbering: numbly("{1}.", default: "1.1"))

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

== Tarjan 缩点

#figure(image("pic/image copy.png"))

#figure(image("pic/image.png"))

#slide[
```cpp
#include <bits/stdc++.h>
using namespace std;
const int N = 1e4 + 10;
int n, m, a[N];
vector<int> e[N];
int dfn[N], low[N], cnt = 0; // low[i]: i 能走到的可达 i 的边中 dfn 最小的
stack<int> st;
bool in[N]; // in[i] 表示 i 还未确认所属强连通分量
int colcnt = 0, col[N], colw[N];
vector<int> cole[N];
int colin[N], f[N];
void dfs(int u) {
    dfn[u] = low[u] = ++cnt;
    in[u] = true;
    st.push(u);
    for (auto v: e[u]) {
        if (dfn[v] == 0) { // 没走过
            dfs(v);
            low[u] = min(low[u], low[v]);
        } else {
            if (in[v]) // 即 v 可达我.
                low[u] = min(low[u], dfn[v]);
        }
    }
    if (dfn[u] == low[u]) {
        ++colcnt;
        while (true) {
            int t = st.top();
            col[t] = colcnt;
            colw[colcnt] += a[t];
            in[t] = false;
            st.pop();
            if (t == u)
                break;
        }
    }
}
```
][
```cpp
int main() {
    ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    cin >> n >> m;
    for (int i = 1; i <= n; i++)
        cin >> a[i];
    for (int i = 1; i <= m; i++) {
        int u, v;
        cin >> u >> v;
        e[u].push_back(v);
    }
    for (int i = 1; i <= n; i++)
        if (dfn[i] == 0)
            dfs(i);
    // 建图 + 拓扑排序
    for (int i = 1; i <= n; i++)
        for (auto v: e[i])
            if (col[i] != col[v]) {
                cole[col[i]].push_back(col[v]);
                ++colin[col[v]];
            }
    queue<int> q;
    for (int i = 1; i <= colcnt; i++)
        if (colin[i] == 0) {
            q.push(i);
            f[i] = colw[i];
        }
    int ans = 0;
    while (!q.empty()) {
        int u = q.front();
        q.pop();
        ans = max(ans, f[u]);
        for (auto v: cole[u]) {
            colin[v]--;
            f[v] = max(f[v], f[u] + colw[v]);
            if (colin[v] == 0)
                q.push(v);
        }
    }
    cout << ans << endl;
    return 0;
}

```
]

== 割点

#figure(image("pic/image copy 2.png"))

```cpp
typedef long long ll;
// v:当前点 r：本次搜索树的root
void tarjan(ll u, ll r) {
    dfn[u] = low[u] = ++deep;
    ll child = 0;
    for (unsigned i = 0; i < g[u].size(); i++) {
        ll v = g[u][i];
        if (!dfn[v]) {
            tarjan(v, r);
            low[u] = min(low[u], low[v]);
            if (low[v] >= dfn[u] && u != r)
                cut[u] = 1; //不是根而且他的孩子无法跨越他回到祖先
            if (r == u)
                child++; //如果是搜索树的根，统计孩子数目
        }
        low[u] = min(low[u], dfn[v]); //已经搜索过了
    }
    if (child >= 2 && u == r)
        cut[r] = 1;
}

```

== 例题：P2341 [USACO03FALL / HAOI2006] 受欢迎的牛 G

https://www.luogu.com.cn/problem/P2341

缩点后出度为 0 的点若只有一个，则其强连通分量大小即为答案.

== 二分图匹配

https://www.luogu.com.cn/problem/P3386

- 左边每个点 `u` 枚举出边，`mch[i]` 记录右边点 `i` 匹配的左边点
  - 如果相连点没有匹配，直接匹配
  - 如果有 `mch[v]`，则让 `mch[v]` 重新匹配
  - 连续重配的过程中不得多次访问同一点
  - 找到一个 `mch[v] == 0` 就会回溯更新

#pagebreak()

```cpp
int main() {
  scanf("%d %d %d", &n, &m, &t);
  for (int u, v; t; --t) {
    scanf("%d %d", &u, &v);
    e[u].push_back(v);
  }
  int ans = 0;
  for (int i = 1; i <= n; ++i) if (dfs(i, i)) {
    ++ans;
  }
  printf("%d\n", ans);
}

bool dfs(const int u, const int tag) {
  if (vistime[u] == tag) return false; // 本轮寻找中是否被访问过
  vistime[u] = tag;
  for (auto v : e[u]) if ((mch[v] == 0) || dfs(mch[v], tag)) {
    mch[v] = u;
    return true;
  }
  return false;
}
```
