#include <bits/stdc++.h>
using namespace std; // min oi
const int N = 1e3 + 10, MOD = 1e9 + 7, M = 210;
int f[M][M]; // 目前所有分 j 段，完成 k 个之方案
int g[2][M][M]; // 结尾位置 i(i - 1)，分 j 段完成 k 个的方案
char a[N], b[N];
int main() {
    int n, m, cut; cin >> n >> m >> cut;
    cin >> a + 1 >> b + 1;
    int ans = 0;
    for (int i = 1, p = 0; i <= n; i++, p ^= 1) {
        // if a[i] == b[k]
        //     g[i][j][k] = g[i - 1][j][k - 1] + f[i - 1][cur][j - 1][k - 1]
        //
        // else g[i][j][k] = 0
        for (int j = cut; j >= 1; j--)
            for (int k = m; k >= j; k--) {
                if (a[i] == b[k]) {
                    if (k == 1)
                        g[p][j][k] = 1;
                    else
                        (g[p][j][k] =
                            g[p ^ 1][j][k - 1]
                            + f[j - 1][k - 1]) %= MOD;
                }
                else
                    g[p][j][k] = 0;
        }
        (ans += g[p][cut][m]) %= MOD;
        // cout << g[p][cut][m] << endl;
        for (int j = cut; j >= 1; j--)
            for (int k = m; k >= 1; k--)
                if (a[i] == b[k]) {
                    if (k == 1)
                        (f[j][k] += 1) %= MOD;
                    else
                        f[j][k] +=
                            f[j - 1][k - 1];
                        f[j][k] %= MOD;
                        (f[j][k] += 
                            + g[p ^ 1][j][k - 1]) %= MOD;
                }
    }
    cout << ans << endl;
    return 0;
}

