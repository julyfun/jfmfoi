#include <bits/stdc++.h>
using namespace std;
const int N = 5e3 + 10;
int f[N], a[N];
int main() {
    int n;
    cin >> n;
    for (int i = 1; i <= n; i++) cin >> a[i];
    for (int i = 1; i <= n; i++) {
        f[i] = 1;
        for (int j = 1; j <= i - 1; j++)
            if (a[j] < a[i])
                f[i] = max(f[i], f[j] + 1);
    }
    int ans = 0;
    for (int i = 1; i <= n; i++) ans = max(ans, f[i]);
    cout << ans << endl;

return 0;}

