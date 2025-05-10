#include <bits/stdc++.h>
using namespace std;
int a[1000010], n;
int main() {
    int c; cin >> n >> c;
    for (int i = 1; i <= n; i++) cin >> a[i];
    sort(a + 1, a + n + 1);
    long long ans = 0;
    for (int i = 1; i <= n; i++) {
        // 指定 B 为 a[i]，查找是否有数字等于 B + C
        int l = lower_bound(a + 1, a + n + 1, a[i] + c) - a;
        int r = upper_bound(a + 1, a + n + 1, a[i] + c) - a - 1;
        if (l != n + 1)
            ans += r - l + 1;
    }
    cout << ans << endl;
    return 0;
}