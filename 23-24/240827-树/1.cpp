#include <bits/stdc++.h>
using namespace std;
const int N = 5e5 + 10, T = 21;
int n, m, s;
vector<int> e[N];
int f[N][T];
int dep[N];
void dfs(int u, int fa) {
    dep[u] = dep[fa] + 1;
    f[u][0] = fa;
    for (int i = 0; i < e[u].size(); i++) {
        int v = e[u][i];
        if (v == fa) {
            continue;
        }
        dfs(v, u);
    }
}
int lca(int x, int y) {
    if (dep[x] < dep[y]) {
        swap(x, y);
    }
    // 一定要从大到小枚举 t 才能减干净
    for (int t = 20; t >= 0; --t) {
        //        printf("%d\n", t);
        if (dep[x] - dep[y] >= (1 << t)) {
            x = f[x][t];
        }
    }
    if (x == y) {
        return x;
    }
    // 如果跳到同一深度还不是同一点
    for (int t = 20; t >= 0; --t) {
        if (f[x][t] != f[y][t]) {
            // 放心跳
            x = f[x][t];
            y = f[y][t];
        }
    }
    return f[x][0];
}

int main() {
    scanf("%d%d%d", &n, &m, &s);
    for (int i = 1; i <= n - 1; i++) {
        int u, v;
        scanf("%d %d", &u, &v);
        e[u].push_back(v);
        e[v].push_back(u);
    }
    dfs(s, 0);
    for (int t = 1; t <= 20; t++) {
        for (int i = 1; i <= n; i++) {
            f[i][t] = f[f[i][t - 1]][t - 1];
        }
    }
    while (m--) {
        int x, y;
        scanf("%d %d", &x, &y);
        printf("%d\n", lca(x, y));
    }

    return 0;
}
