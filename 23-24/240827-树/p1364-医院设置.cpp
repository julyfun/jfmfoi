#include <bits/stdc++.h>
using namespace std;
const int N = 1e2 + 10;
int n;
vector<int> e[N];
int num[N];
int totdis[N];
int sz[N];
void dfs_init(int u, int f, int dep) {
    sz[u] = num[u];
    for (auto v: e[u]) {
        if (v == f) continue;
        dfs_init(v, u, dep + 1);
        sz[u] += sz[v];
    }
    totdis[1] += dep * num[u];
}
void dfs_get(int u, int f) {
    if (u != 1)
        totdis[u] = totdis[f] - (sz[u]) + (sz[1] - sz[u]);
    for (auto v: e[u]) {
        if (v == f) continue;
        dfs_get(v, u);
    }
}
int main() {
    cin >> n;
    for (int i = 1; i <= n; i++) {
        int l, r;
        cin >> num[i] >> l >> r;
        if (l) e[i].push_back(l);
        if (r) e[i].push_back(r);
    }
    dfs_init(1, 0, 0);
    dfs_get(1, 0);
    int ans = 1e9;
    for (int i = 1; i <= n; i++)
        if (ans > totdis[i])
            ans = totdis[i];
    cout << ans << endl;
    return 0;
}
