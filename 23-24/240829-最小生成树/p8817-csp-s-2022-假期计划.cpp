#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
const int N = 2.5e3 + 10;
int n, m, k, dis[N], best[N][3];
vector<int> e[N];
ll s[N];
bool linked[N][N];
void bfs(int x) {
    memset(dis, -1, (n + 1) * sizeof(int));
    queue<int> q;
    q.push(x); dis[x] = 0;
    while (!q.empty()) {
        int u = q.front();
        q.pop();
        for (auto v: e[u])
            if (dis[v] == -1) { // 首次访问
                dis[v] = dis[u] + 1;
                q.push(v);
            }
    }
    for (int i = 1; i <= n; i++)
        if (i != x && dis[i] != -1 && dis[i] <= k + 1)
            linked[x][i] = true;
}
bool diff(int x, int y, int z, int w) { // 判断四个数不同
    return x != y && x != z && x != w && y != z && y != w && z != w;
}
int main() {
    cin >> n >> m >> k;
    for (int i = 2; i <= n; i++) cin >> s[i];
    for (int i = 1; i <= m; i++) {
        int x, y; cin >> x >> y;
        e[x].push_back(y);
        e[y].push_back(x);
    }
    for (int i = 1; i <= n; i++) bfs(i);
    for (int i = 2; i <= n; i++)
        // 获取前三大可直达 i 和家的景点
        for (int j = 2; j <= n; j++) {
            if (!(linked[1][j] && linked[i][j]))
                continue;
            if (s[j] > s[best[i][0]])
                best[i][2] = best[i][1], best[i][1] = best[i][0], best[i][0] = j;
            else if (s[j] > s[best[i][1]])
                best[i][2] = best[i][1], best[i][1] = j;
            else if (s[j] > s[best[i][2]])
                best[i][2] = j;
        }
    ll ans = 0;
    for (int x = 2; x <= n - 1; x++)
        for (int y = x + 1; y <= n; y++)
            for (int i = 0; i <= 2; i++)
                for (int j = 0; j <= 2; j++) {
                    int s1 = best[x][i], s4 = best[y][j];
                    if (linked[x][y] && s1 != 0 && s4 != 0 && diff(s1, x, y, s4)) {
                       ans = max(ans, s[s1] + s[x] + s[y] + s[s4]);
                    }

                }
    cout << ans << endl;
    return 0;
}

