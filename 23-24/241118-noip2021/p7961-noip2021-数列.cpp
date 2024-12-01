#include <bits/stdc++.h>
using namespace std; // min oi
typedef long long ll;
const ll P = 998244353;
int n, m, K;
int f[110][32][32][32];
int v[110][32];
int c[32][32];
int cnt(int x) {
    int res = 0;
    while (x) {
        res += x & 1;
        x >>= 1;
    }
    return res;
}
int main() {
    ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    cin >> n >> m >> K;
    for (int i = 1; i <= m + 1; i++) {
        v[i][0] = 1;
        cin >> v[i][1];
        for (int j = 2; j <= n; j++)
            v[i][j] = ll(v[i][j - 1]) * v[i][1] % P;
    }
    for (int i = 0; i <= n; i++) c[i][0] = 1;
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= i; j++)
                c[i][j] = (c[i - 1][j - 1] + c[i - 1][j]) % P;
    f[0][0][0][0] = 1;
    for (int i = 0; i <= m; i++) { // m + 1 不需要后推
        // 前推
        for (int t = 0; t <= n; t++) {
            for (int j = 0; j <= K; j++) {
                for (int k = 0; k <= 31; k++) {
                    // 考虑前 i 个 v
                    // 使用了 t 个 v
                    // S 已经拼了 j 个 1 （前 i 位）
                    // 进位状态为 k （从 i + 1 位开始算）
                    // 所有序列方案的权值和
                    for (int p = 0; p <= n - t; p++) {
                        // v[i + 1] 要拼 p 个
                        int nt = t + p;
                        int nj = j + (k + p) % 2;
                        int nk = (k + p) >> 1;
                        f[i + 1][nt][nj][nk] +=
                            ll(f[i][t][j][k]) * v[i + 1][p] % P
                            * c[n - t][p] % P;
                        f[i + 1][nt][nj][nk] %= P;
                    }
                }
            }
        }
    }
    
    // f[m + 1][n][
    ll ans = 0;
    for (int j = 0; j <= K; j++)
        for (int k = 0; k <= 31; k++) {
            if (j + cnt(k) <= K)
                ans = (ans + f[m + 1][n][j][k]) % P;
        }
    
    cout << ans << endl;
    return 0;
}

