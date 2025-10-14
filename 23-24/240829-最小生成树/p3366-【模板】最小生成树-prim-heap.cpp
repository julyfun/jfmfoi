#include <bits/stdc++.h>
using namespace std;
const int N = 5e3 + 10, M = 2e5 + 10;
int n, m, dis[N], ok[N];
struct edge { int v, w; }; vector<edge> e[N];
struct node { int u, d; 
    bool operator<(const node& g) const {
        return d > g.d;
    }
}; priority_queue<node> q;
int main() {
    cin >> n >> m;
    while (m--) {
        int u, v, w; cin >> u >> v >> w;
        e[u].push_back({v, w}); e[v].push_back({u, w});
    }
    memset(dis, 0x3f, sizeof(dis));
    dis[1] = 0;
    q.push({1, 0});
    int ans = 0;
    while (!q.empty()) {
        auto [u, d] = q.top(); q.pop();
        if (ok[u]) continue;
        ok[u] = true;
        // 可确定 d 为最优解
        ans += d;
        for (auto [v, w]: e[u])
            if (w < dis[v]) {
                dis[v] = w;
                if (!ok[v]) {
                    q.push({v, w});
                }
            }
    }
    bool all_ok = true; for (int i = 1; i <= n; i++) if (!ok[i]) all_ok = false;
    if (all_ok) cout << ans << endl;
    else cout << "orz" << endl;
    return 0;
}
