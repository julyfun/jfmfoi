#include <bits/stdc++.h>
using namespace std;
int a[1000010];
int main() {
    ios::sync_with_stdio(0);
    int n, m;
    cin >> n >> m;
    for (int i = 1; i <= n; i++) cin >> a[i];
    while (m--) {
        int x; cin >> x;
        int l = 1, r = n, ans = -1; // -1 表示没有找到
        while (l <= r) {
            int mid = (l + r) / 2;
            if (a[mid] == x) ans = mid;
            if (a[mid] < x) l = mid + 1;
            else r = mid - 1;
        }
        // 平移到最左边
        cout << ans << " ";
    }
    return 0;
}