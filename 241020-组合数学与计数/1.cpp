#include <bits/stdc++.h>
using namespace std; // min oi
const int N = 11;
int f[N][N];
int s[N][N];
int c[N][N];
int main() {
    int n, r;
    cin >> n >> r;
    f[0][0] = 1;
    for (int i = 0; i <= n; i++)
        c[i][0] = 1;
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= i; j++)
            c[i][j] = c[i - 1][j] + c[i - 1][j - 1];
    for (int i = 1; i <= r; i++)
        for (int j = 1; j <= n; j++) // 一共放 j 
            for (int k = 1; k <= j; k++)
                f[i][j] += f[i - 1][j - k] * c[n - (j - k)][k];
    cout << f[r][n] << endl;
    s[0][0] = 1;
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= r; j++)
            s[i][j] = 
                s[i - 1][j] * j // 前 i - 1 个球放在了 j 箱子，可以任意放
                + s[i - 1][j - 1];
    int ans = s[n][r];
    for (int i = 2; i <= r; i++)
        ans *= i;
    // cout << ans << endl;
    return 0;
}

