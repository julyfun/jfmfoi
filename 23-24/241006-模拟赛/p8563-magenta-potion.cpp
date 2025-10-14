#include <bits/stdc++.h>
using namespace std;
const int N = 2e5 + 10;
typedef long long ll;
ll a[N], f[110], g[110];
int main() {
    ios::sync_with_stdio(0); cin.tie(0); cout.tie(0);
    int n, q; cin >> n >> q;
    for (int i = 1; i <= n; i++) cin >> a[i];
    while (q--) {
        int op, l, r;
        cin >> op >> l >> r;
        if (op == 1) { a[l] = r; continue; }
        if (r - l + 1 > 61) {
            cout << "Too large" << endl;
            continue;
        }
        f[0] = g[0] = 0;
        for (int i = 1; i <= r - l + 1; i++) {
            int v = l + i - 1;
            if (a[v] > 0) {
                f[i] = max(a[v], f[i - 1] * a[v]);
                g[i] = f[i - 1] * a[v];
            } else {
                f[i] = g[i - 1] * a[v];
                g[i] = min(a[v], f[i - 1] * a[v]);
            }
            f[i] = min(f[i], (ll)2e9);
            g[i] = max(g[i], (ll)-2e9);
        }
        ll ans = 1;
        for (int i = 1; i <= r - l + 1; i++) ans = max(ans, f[i]);
        if (ans > (1ll << 30))
            cout << "Too large" << endl;
        else cout << ans << endl;
    }
    return 0;
}
