#include <bits/stdc++.h>
using namespace std;
const int N = 1e4 + 10;
vector<pair<int, int>> e[N];
int f[N];
int main() {
    int n, m, s, t; cin >> n >> m >> s >> t;
    while (m--) {
        int u, v, w; cin >> u >> v >> w;
        e[u].push_back(v, w);
        e[v].push_back(u, w);
    }
    return 0;
}
