#include <cstring>
#include <iostream>
using namespace std;
long long n, m, k, a[210], ans = 1e18, minn[210];
int used[210];
void dfs(long long u, long long v, long long cs) {
    if (u < 1 || u > n) //剪枝1
        return;
    if (cs >= minn[u]) //剪枝2
        return;
    if (cs >= ans) //剪枝3
        return;
    if (used[u])
        return;
    used[u] = 1; //标记这个点已经搜过了
    if (u == v) //如果搜到了
    {
        ans = cs; //记录答案
        used[u] = 0;
        return;
    }
    minn[u] = cs; //更新到达这个点的最小次数
    dfs(u + a[u], v, cs + 1);
    dfs(u - a[u], v, cs + 1);
    used[u] = 0;
}
#define IOS ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);
#define endl '\n'
#define QwQ return 0;
int main() {
    IOS;
    cin >> n >> m >> k;
    for (int i = 1; i <= n; i++)
        cin >> a[i], minn[i] = 1e18;
    dfs(m, k, 0);
    if (ans != 1e18)
        cout << ans;
    else
        cout << -1;
    QwQ;
}
