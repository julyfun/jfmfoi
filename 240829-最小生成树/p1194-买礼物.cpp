#include <bits/stdc++.h>
using namespace std;
const int N = 5e2 + 10, M = N * N;
int fa[N], cnt = 0;
struct edge {
    int x, y, w;
} e[M];
bool cmp(edge e1, edge e2) { return e1.w < e2.w; }
int find(int x) {
    if (x == fa[x]) return x;
    return fa[x] = find(fa[x]);
}
int main() {
    int a, b;
    cin >> a >> b;
    for (int i = 1; i <= b; i++)
        for (int j = 1; j <= b; j++) {
            int w; cin >> w;
            if (w == 0) w = a;
            e[++cnt] = { i, j, min(w, a) };
        }
    sort(e + 1, e + cnt + 1, cmp);
    for (int i = 1; i <= b; i++)
        fa[i] = i; // 每个点的父亲是自己
    int ans = a;
    for (int i = 1; i <= cnt; i++) {
        // 如果 x 和 y 不在同一个集合里面就连上这条边
        if (find(e[i].x) != find(e[i].y)) {
            ans += e[i].w;
            fa[find(e[i].x)] = find(e[i].y);
        }
    }
    cout << ans << endl;
    return 0;
}
