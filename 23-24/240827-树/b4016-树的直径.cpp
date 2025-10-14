#include <bits/stdc++.h>
using namespace std;
const int N = 1e5 + 10;
vector<int> e[N];
int far_u = 0;
int fardis = 0;
void dfs(int u, int f, int dis) {
    if (dis > fardis) {
        fardis = dis;
        far_u = u;
    }
    for (int i = 0; i < e[u].size(); i++) {
        int v = e[u][i];
        if (v == f) continue;
        dfs(v, u, dis + 1);
    }
}
int main() {
    int n;
    cin >> n;
    for (int i = 1; i <= n - 1; i++) {
        int u, v;
        cin >> u >> v;
        e[u].push_back(v);
        e[v].push_back(u);
    }
    dfs(1, 0, 0);
    int u1 = far_u;
    dfs(u1, 0, 0);
    cout << fardis << endl;
    return 0;
}
