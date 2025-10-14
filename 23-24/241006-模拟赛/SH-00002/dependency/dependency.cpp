#include <bits/stdc++.h>
using namespace std;
const int N = 110;
int d[N];
int sub[N][N];
int pass[N];
int main() {
    freopen("dependency.in", "r", stdin);
    freopen("dependency.out", "w", stdout);
    int n; cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> d[i];
        for (int j = 1; j <= d[i]; j++) {
            int x; cin >> x;
            sub[i][j] = x;
        }
    }
    int m; cin >> m;
    while (m--) {
        int ans = 0;
        memset(pass, 0, sizeof(int) * (n + 1));
        for (int i = 1; i <= n; i++) {
            int t; cin >> t;
            if (t == 1) {
                bool all = true;
                for (int j = 1; j <= d[i]; j++)
                    if (pass[sub[i][j]] == 0)
                        all = false;
                if (all) ans++;
                pass[i] = all;
            }
        }
        cout << ans << endl;
    }
    return 0;
}
