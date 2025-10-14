#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
const int N = 2e5 + 10, M = 1e6 + 19;
int a[N];
int last[M];
ll f[N][2];
ll pre[N];
// f[i][0]: i 没得分的最高分
// f[i][1]: i 得分的最高分，如 i - 1 与我不同则我与他颜色不同，否则颜色当然相同
int main() {
    ios::sync_with_stdio(0); cin.tie(0); cout.tie(0);
    int t = 0; cin >> t;
    while (t--) {
        int n; cin >> n;
        memset(last, 0, sizeof(last));
        for (int i = 1; i <= n; i++) {
            cin >> a[i];
            f[i][0] = f[i][1] = 0;
        }
        for (int i = 2; i <= n; i++) {
            pre[i] = pre[i - 1];
            if (a[i] == a[i - 1]) pre[i] += a[i];
        }
        for (int i = 1; i <= n; last[a[i]] = i, i++) {
            f[i][0] = max(f[i - 1][0], f[i - 1][1]);
            if (last[a[i]] == 0) {
                continue;
            }
            if (last[a[i]] == i - 1) {
                f[i][1] = max(f[i - 1][0], f[i - 1][1]) + a[i];
                continue;
            }
            int j = last[a[i]];
            // j, j + 1 同色方案一定不会成为 f[j + 1] 的最优解
            f[i][1] = max(f[j + 1][0], f[j + 1][1]) + a[i] + pre[i - 1] - pre[j + 1];
        }
        cout << max(f[n][0], f[n][1]) << endl;
    }
    return 0;
}
