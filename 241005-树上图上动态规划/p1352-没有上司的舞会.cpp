#include <bits/stdc++.h>
using namespace std;
const int N = 6e3 + 10;
int r[N]; vector<int> e[N];
int f[N], g[N], fa[N];
void dfs(int u) {
    f[u] = r[u], g[u] = 0;
    for (auto v: e[u]) {
        dfs(v);
        f[u] += g[v];
        g[u] += max(g[v], f[v]);
    }
}
int main() {
    int n; cin >> n;
    for (int i = 1; i <= n; i++) { cin >> r[i]; }
    for (int i = 1; i <= n - 1; i++) {
        int x, y; cin >> x >> y;
        e[y].push_back(x);
        fa[x] = y;
    }
    int rt = 0;
    for (int i = 1; i <= n; i++) if (fa[i] == 0) rt = i;
    dfs(rt);
    cout << max(f[rt], g[rt]) << endl;
    return 0;
}

