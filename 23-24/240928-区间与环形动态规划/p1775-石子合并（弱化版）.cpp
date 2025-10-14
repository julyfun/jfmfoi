#include <bits/stdc++.h>
using namespace std;
const int N = 310;
int a[N], f[N][N], pre[N];
int main() {
    int n; cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> a[i];
        pre[i] = pre[i - 1] + a[i];
    }
    for (int d = 2; d <= n; d++)
        for(int i = 1; i + d - 1 <= n; i++) {
            int j = i + d - 1;
            f[i][j] = 1e9;
            for (int k = i; k <= j - 1; k++)
                 f[i][j] = min(f[i][j], f[i][k] + f[k + 1][j] + pre[j] - pre[i - 1]);
        }
    cout << f[1][n] << endl;
    return 0;
}
