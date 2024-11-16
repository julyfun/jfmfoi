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
