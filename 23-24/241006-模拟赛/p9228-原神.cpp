#include <bits/stdc++.h>
using namespace std;
const int N = 1e6 + 10;
typedef long long ll;
int a[N], b[N];
int main() {
    ll ans = 0;
    int n, m, k; scanf("%d%d%d", &n, &m, &k);
    for (int i = 1; i <= n; i++) {
        scanf("%d", &a[i]);
        ans += a[i];
    }
    for (int i = 1; i <= m; i++) {
        scanf("%d", &b[i]);
        ans += b[i];
    }
    int d = min(n, m);
    sort(a + 1, a + n + 1);
    for (int i = 1; i <= d; i++)
        ans += max(a[n - i + 1], k);
    printf("%lld\n", ans);
    return 0;
}

