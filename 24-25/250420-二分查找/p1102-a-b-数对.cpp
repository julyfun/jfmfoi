#include <bits/stdc++.h>
using namespace std;
int a[1000010], n;
int findl(int x) {
    int l = 1, r = n, ans = -1; // -1 表示没有找到
    while (l <= r) {
        int mid = (l + r) / 2;
        if (a[mid] == x)
            ans = mid;
        if (a[mid] < x) l = mid + 1;
        else r = mid - 1;
    }
    return ans;
}
int findr(int x) {
    int l = 1, r = n, ans = -1; // -1 表示没有找到
    while (l <= r) {
        int mid = (l + r) / 2;
        if (a[mid] == x)
            ans = mid;
        if (a[mid] <= x) l = mid + 1; // 注意这里包含 == 情况，尽可能找右边
        else r = mid - 1;
    }
    return ans;
}
int main() {
    int c; cin >> n >> c;
    for (int i = 1; i <= n; i++) cin >> a[i];
    sort(a + 1, a + n + 1);
    long long ans = 0;
    for (int i = 1; i <= n; i++) {
        // 指定 B 为 a[i]，查找是否有数字等于 B + C
        int l = findl(a[i] + c);
        int r = findr(a[i] + c);
        // 如果找到了
        if (l != -1)
            ans += r - l + 1;
    }
    cout << ans << endl;
    return 0;
}