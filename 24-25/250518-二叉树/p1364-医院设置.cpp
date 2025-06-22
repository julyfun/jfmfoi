#include <bits/stdc++.h>
using namespace std;
const int N = 105;
struct Node {
    int l, r;
    int w;
};
int ans = 0, sz[N], dep[N];
Node t[N];
void dfs(int u) {
    sz[u] = t[u].w;
    int l = t[u].l, r = t[u].r;
    if (l) {
        dep[l] = dep[u] + 1;
        dfs(l);
        sz[u] += sz[l];
    }
    if (r) {
        dep[r] = dep[u] + 1;
        dfs(r);
        sz[u] += sz[r];
    }
}
void find(int u, int sum) {
    if (u != 1) {
        sum -= sz[u];
        sum += sz[1] - sz[u];
        ans = min(ans, sum);
    }
    if (t[u].l)
        find(t[u].l, sum);
    if (t[u].r)
        find(t[u].r, sum);
}
int main() {
    int n;
    cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> t[i].w >> t[i].l >> t[i].r;
    }
    dep[1] = 0;
    dfs(1);
    for (int i = 1; i <= n; i++) {
        ans += dep[i] * t[i].w;
    }
    find(1, ans);
    cout << ans << endl;
    return 0;
}
