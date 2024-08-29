#include <bits/stdc++.h>
using namespace std;
const int N = 5e5 + 10;
int n, m, q;
// 所有点出度为 1
set<int> from[N], desfrom[N];
int out[N], init[N], cnt1 = 0;
void modify(int i, int d) {
    int before = out[i];
    out[i] += d;
    cnt1 -= (before == 1);
    cnt1 += (out[i] == 1);
}
int main() {
    ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    cin >> n >> m;
    for (int i = 1; i <= m; i++) {
        int u, v;
        cin >> u >> v;
        out[u]++;
        from[v].insert(u);
    }
    for (int i = 1; i <= n; i++) {
        if (out[i] == 1)
            cnt1++;
    }
    cin >> q;
    while (q--) {
        int op, u, v;
        cin >> op;
        if (op == 1) {
            cin >> u >> v;
            modify(u, -1);
            from[v].erase(u);
            desfrom[v].insert(u);
        } else if (op == 2) {
            cin >> u;
            for (auto f: from[u]) {
                modify(f, -1);
                desfrom[u].insert(f);
            }
            from[u].clear();
        } else if (op == 3) {
            cin >> u >> v;
            modify(u, +1);
            from[v].insert(u);
            desfrom[v].erase(u);
        } else {
            cin >> u;
            for (auto f: desfrom[u]) {
                modify(f, +1);
                from[u].insert(f);
            }
            desfrom[u].clear();
        }
        if (cnt1 == n)
            cout << "YES" << endl;
        else
            cout << "NO" << endl;
    }
    return 0;
}
