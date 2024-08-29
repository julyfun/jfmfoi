#include <cstring>
#include <iostream>
#include <queue>
#include <utility>
using namespace std;
int n, m;
char a[310][310];
int dis[310][310];
struct P {
    int x, y;
};
int d[4][2] = { { 0, 1 }, { 0, -1 }, { 1, 0 }, { -1, 0 } };
P pos[26][2];
std::queue<P> q;
int main() {
    memset(dis, -1, sizeof(dis));
    cin >> n >> m;
    for (int i = 1; i <= n; i++)
        cin >> a[i] + 1;
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= m; j++) {
            if (a[i][j] == '@') {
                q.push({ i, j });
                dis[i][j] = 0;
            } else if (a[i][j] >= 'A' && a[i][j] <= 'Z') {
                if (pos[a[i][j] - 'A'][0].x == 0)
                    pos[a[i][j] - 'A'][0] = { i, j };
                else
                    pos[a[i][j] - 'A'][1] = { i, j };
            }
        }
    int ans = 0;
    while (!q.empty()) {
        P u = q.front();
        q.pop();
        for (int k = 0; k < 4; k++) {
            int x = u.x + d[k][0], y = u.y + d[k][1];
            if (a[x][y] == '#')
                continue;
            else if ('A' <= a[x][y] && a[x][y] <= 'Z') {
                P p = pos[a[x][y] - 'A'][0];
                if (p.x == x && p.y == y)
                    p = pos[a[x][y] - 'A'][1];
                if (dis[p.x][p.y] != -1)
                    continue;
                dis[p.x][p.y] = dis[u.x][u.y] + 1;
                q.push(p);
            } else if (dis[x][y] != -1)
                continue;
            else if (a[x][y] == '=') {
                dis[x][y] = ans = dis[u.x][u.y] + 1;
            } else {
                dis[x][y] = dis[u.x][u.y] + 1;
                q.push({ x, y });
            }
        }
    }
    cout << ans << endl;
    return 0;
}
