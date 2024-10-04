#include <bits/stdc++.h>
using namespace std;
int a[510], f[510][510];
int main() {
    int n; cin >> n;
    for (int i = 1; i <= n; i++) cin >> a[i];
    for (int i = 1; i <= n; i++) f[i][i] = 1;
    for (int d = 2; d <= n; d++)
        for (int i = 1; i + d - 1 <= n; i++) {
            int j = i + d - 1;
            f[i][j] = 1e9;
            if (a[i] == a[j]) {
                if (d == 2) f[i][j] = min(f[i][j], 1);
                else f[i][j] = min(f[i][j], f[i + 1][j - 1]);
            }
            for (int k = i; k <= j - 1; k++)
               f[i][j] = min(f[i][j], f[i][k] + f[k + 1][j]);
        }
//     for (int i = 1; i <= n; i++, puts(""))
//         for (int j = 1; j <= n; j++)
//             cout << f[i][j] << " "; 
    cout << f[1][n] << endl;
    return 0;
}
