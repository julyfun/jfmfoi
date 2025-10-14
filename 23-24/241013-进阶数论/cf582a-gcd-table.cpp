#include <bits/stdc++.h>
using namespace std; // min oi
typedef long long ll;
const int N = 510;
pair<int, int> f[N]; int cnt = 0;
map<int, int> m;
int gcd(int x, int y) {
    return y == 0 ? x : gcd(y, x % y);
}
int main() {
    ios::sync_with_stdio(0); cin.tie(0); cout.tie(0);
    int n; cin >> n;
    for (int i = 1; i <= n * n; i++) {
        int x; cin >> x;
        m[x] += 1; 
    }
    for (auto it = m.end(); it != m.begin();) {
        it--;
        if (it->second == 0) continue;
        f[++cnt].first = it->first;
        // p * p + k * p * 2 = second
        // / 2 * (-2k + sqrt(4k ** 2 + 4 second))
        int k = 0;
        for (int j = 1; j <= cnt - 1; j++)
            if (gcd(f[j].first, f[cnt].first) == f[cnt].first)
                k += f[j].second;
        f[cnt].second = ll(-2 * k + sqrt(4ll * k * k + 4ll * it->second)) / 2ll;
        for (int j = 1; j <= cnt - 1; j++) {
            // 12 12
            // 10 10 10
            // -> 2 * 3 * 2
            int g = gcd(f[j].first, f[cnt].first);
            m[g] -= f[j].second * f[cnt].second * 2;
        }
    }
    for (int i = 1; i <= cnt; i++)
        for (int j = 1; j <= f[i].second; j++)
            cout << f[i].first << ' ';
    return 0;
}

