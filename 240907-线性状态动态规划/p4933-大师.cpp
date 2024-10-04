#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
const int N = 1e3 + 10, V = 2e4;
const ll MOD = 998244353;
int h[N];
ll ans; int f[N][V * 2 + 10];
int main() {
    int n; cin >> n;
    for (int i = 1; i <= n; i++) cin >> h[i];
    ll ans = 0;
    for (int i = 1; i <= n; i++) {
        (ans += 1) %= MOD;
        for (int j = 1; j <= i - 1; j++) {
            if (abs(h[i] - h[j]) > V) {
                (ans += 1) %= MOD;
                continue;
            }
            (f[i][h[i] - h[j] + V] += 1 + f[j][h[i] - h[j] + V]) %= MOD;
            (ans += 1 + f[j][h[i] - h[j] + V]) %= MOD;
        }
    }
    cout << ans << endl;
    return 0;
}

