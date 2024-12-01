#include <bits/stdc++.h>
using namespace std; // min oi
const int N = 5e5 + 10;
int n, m, dfn[N], low[N], cnt = 0;
bool tag[N];
vector<int> e[N];
void dfs(int u, int fa) {
    dfn[u] = low[u] = ++cnt;
    for (auto v: e[u]) {
        if (v == fa) continue;
        if (!dfn[v]) {
            dfs(v, u);
            low[u] = min(low[u], low[v]);
        } else
            low[u] = min(low[u], dfn[v]);
    }
    for (auto v: e[u]) {
        if (v == fa) continue;
        if (low[v] > low[u]) tag[v] = true;
    }
}
int main() {
    ios::sync_with_stdio(0); cin.tie(0), cout.tie(0);
    cin >> n >> m;
    for (int i = 1; i <= m; i++) {
        int u, v; cin >> u >> v;
        e[u].push_back(v);
        e[v].push_back(u);
    }

    return 0;
}

