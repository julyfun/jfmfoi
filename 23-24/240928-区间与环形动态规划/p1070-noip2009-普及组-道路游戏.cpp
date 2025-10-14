#include <bits/stdc++.h>
using namespace std;
const int N = 1e3 + 10;
int a[N][N], c[N], s[N][N], g[N];
struct P { int k, score; };
deque<P> q[N];
int main() {
    int n, m, p; cin >> n >> m >> p;
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= m; j++)
            cin >> a[((i - j) % n + n) % n + 1][j];
//     for (int i = 1; i <= n; i++, puts(""))
//         for (int j = 1; j <= m; j++)
//             cout << a[i][j] << ' ';
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= m; j++)
            s[i][j] = s[i][j - 1] + a[i][j];
    for (int i = 1; i <= n; i++) cin >> c[i];
    for (int i = 1; i <= n; i++)
        q[i].push_back({ 0, -c[i] });
    for (int t = 1; t <= m; t++) {
        g[t] = -1e9;
        for (int i = 1; i <= n; i++) {
            while (q[i].front().k < t - p) // 上一结尾时刻
                q[i].pop_front();
            g[t] = max(g[t], q[i].front().score + s[i][t]);
        }
        for (int i = 1; i <= n; i++) {
            int score = g[t] - s[i][t] - c[(t + i - 1) % n + 1];
            while (!q[i].empty() && q[i].back().score <= score)
                q[i].pop_back();
            q[i].push_back({ t, score });
        }
    }
    cout << g[m] << endl;
    return 0;
}
