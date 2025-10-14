#include <bits/stdc++.h>
typedef unsigned long long ll;
using namespace std;
const int N = 5e5 + 10;
ll w[N], sumw, g[N], sumin, cur[N];
int n, m, q;
// 所有点出度为 1
int main() {
    ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    srand(time(0));
    cin >> n >> m;
    for (int i = 1; i <= n; i++) {
        w[i] = ll(rand()) * ll(RAND_MAX + 1ll) + ll(rand());
        sumw += w[i];
    }
    for (int i = 1; i <= m; i++) {
        int u, v;
        cin >> u >> v;
        g[v] += w[u]; // 静态
        cur[v] += w[u]; // 指向点 v 的出点的权值和
        sumin += w[u]; // 统计每个出点的权值和
    }
    cin >> q;
    while (q--) {
        int op, u, v;
        cin >> op;
        if (op == 1) {
            cin >> u >> v;
            sumin -= w[u];
            cur[v] -= w[u];
        } else if (op == 2) {
            cin >> u;
            sumin -= cur[u];
            cur[u] = 0;
        } else if (op == 3) {
            cin >> u >> v;
            sumin += w[u];
            cur[v] += w[u];
        } else {
            cin >> u;
            sumin += g[u] - cur[u];
            cur[u] = g[u];
        }
        if (sumin == sumw)
            cout << "YES" << endl;
        else
            cout << "NO" << endl;
    }
    return 0;
}
