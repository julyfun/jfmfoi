#include <bits/stdc++.h>
using namespace std; // min oi
const int N = 1e7 + 110;
const int T = 1e7 + 100;
bool f[N];
int ans[N];
int main() {
    ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    for (int i = 1; i <= T; i++) {
        if (f[i]) continue;
        int k = i, yes = 0;
        while (k) {
            if (k % 10 == 7) yes = 1;
            k /= 10;
        }
        if (yes)
            for (int j = i; j <= T; j += i)
                f[j] = true;
    }
    int last = 0;
    for (int i = 1; i <= T; i++)
        if (!f[i]) {
            ans[last] = i;
            last = i;
        }
    int t; cin >> t;
    while (t--) {
        int x; cin >> x;
        if (f[x]) cout << "-1\n";
        else cout << ans[x] << "\n";
    }
    return 0;
}

