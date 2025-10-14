#include <bits/stdc++.h>
using namespace std;
const int N = 5e3 + 10, M = 2e5 + 10;
int n, m, fa[N], dis[N], used[N];
struct edge { int v, w; }; vector<edge> e[N];
// struct node { int u, d; }; priority_queue<node> q[N];
int main() {
    cin >> n >> m;
    while (m--) {
        int u, v, w; cin >> u >> v >> w;
        e[u].push_back({v, w}); e[v].push_back({u, w});
    }
    memset(dis, 0x3f, sizeof(dis));
    dis[1] = 0;
    int ans = 0;
    for (int i = 1; i <= n; i++) {
        int u = 0, mind = 1e9 + 7;
        for (int j = 1; j <= n; j++)
            if (!used[j] && dis[j] < mind)
                u = j, mind = dis[j];
        if (u == 0) {
            cout << "orz" << endl;
            return 0;
        }
        used[u] = 1, ans += dis[u];
        for (auto [v, w]: e[u])
            dis[v] = min(dis[v], w);
    }
    cout << ans << endl;
    return 0;
}
