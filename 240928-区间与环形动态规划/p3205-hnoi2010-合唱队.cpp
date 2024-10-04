#include <bits/stdc++.h>
using namespace std;
const int N = 1e3 + 10; const int MOD = 19650827;
int h[N]; int f[N][N][2];
int main() {
    int n; cin >> n;
    for (int i = 1; i <= n; i++) cin >> h[i];
    for (int i = 1; i <= n; i++) f[i][i][0] = 1;
    for (int d = 2; d <= n; d++)
        for (int i = 1; i + d - 1 <= n; i++) {
            int j = i + d - 1;
            // [1] + [2 3 4]
            if (h[i] < h[i + 1]) (f[i][j][0] += f[i + 1][j][0]) %= MOD;
            if (h[i] < h[j]) (f[i][j][0] += f[i + 1][j][1]) %= MOD;
            // [1 2 3] + [4]
            if (h[j] > h[i]) (f[i][j][1] += f[i][j - 1][0]) %= MOD;
            if (h[j] > h[j - 1]) (f[i][j][1] += f[i][j - 1][1]) %= MOD;
        }
    cout << (f[1][n][0] + f[1][n][1]) % MOD << endl;
    return 0;
}

