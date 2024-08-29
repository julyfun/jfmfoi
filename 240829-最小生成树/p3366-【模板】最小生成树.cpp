#include <bits/stdc++.h>
using namespace std;
const int N = 5e3 + 10, M = 2e5 + 10;
int n, m, fa[N];
struct edge {
    int x, y, w;
} e[M];
bool cmp(edge e1, edge e2) { return e1.w < e2.w; }
int find(int x) {
    if (x == fa[x]) return x;
    return fa[x] = find(fa[x]);
}
int main() {
    cin >> n >> m;
    for (int i = 1; i <= m; i++)
        cin >> e[i].x >> e[i].y >> e[i].w;
    sort(e + 1, e + m + 1, cmp);
    for (int i = 1; i <= n; i++)
        fa[i] = i; // 每个点的父亲是自己
    int ans = 0, num = 0;
    for (int i = 1; i <= m; i++) {
        // 如果 x 和 y 不在同一个集合里面就连上这条边
        if (find(e[i].x) != find(e[i].y)) {
            ans += e[i].w, num += 1;
            fa[find(e[i].x)] = find(e[i].y);
        }
    }
    if (num == n - 1)
        cout << ans << endl;
    else
        cout << "orz" << endl;
    return 0;
}
