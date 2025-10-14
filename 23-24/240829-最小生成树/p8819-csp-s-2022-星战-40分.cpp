#include <bits/stdc++.h>
using namespace std;
const int N = 5e3 + 10;
int a[N][N], init[N][N], out[N];
int main() {
    int n, m, q;
    cin >> n >> m;
    while (m--) {
        int u, v;
        cin >> u >> v;
        init[u][v] = a[u][v] = 1;
        out[u]++;
    }
    cin >> q;
    while (q--) {
        int op, u, v;
        cin >> op;
        if (op == 1) {
            cin >> u >> v;
            a[u][v] = 0;
            out[u]--;
        } else if (op == 2) {
            cin >> u; // 通向 u 的都摧毁
            for (int i = 1; i <= n; i++)
                if (a[i][u]) {
                    out[i]--;
                    a[i][u] = 0;
                }
        } else if (op == 3) {
            cin >> u >> v;
            a[u][v] = 1;
            out[u]++;
        } else {
            // 恢复原先通向 u 的边
            cin >> u;
            for (int i = 1; i <= n; i++)
                if (init[i][u] && !a[i][u]) {
                    out[i]++;
                    a[i][u] = 1;
                }
        }
        bool all1 = true;
        for (int i = 1; i <= n; i++)
            if (out[i] != 1)
                all1 = false;
        cout << (all1 ? "YES" : "NO") << endl;
        ;
    }

    return 0;
}
