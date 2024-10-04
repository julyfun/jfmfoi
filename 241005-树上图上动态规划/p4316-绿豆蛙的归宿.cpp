#include <bits/stdc++.h>
using namespace std; // min oi
const int N = 1e5 + 10;
struct E { int v, w; };
vector<E> e[N]; int cnt[N];
double f[N]; int in[N];
int main() {
    int n, m; cin >> n >> m;
    for (int i = 1; i <= m; i++) {
        int u, v, w; cin >> u >> v >> w;
        e[v].push_back({ u, w });
        in[u]++; // 反向边，u 入度++
        cnt[u]++;
    }
    f[n] = 0.0;
    queue<int> q;
    for (int i = 1; i <= n; i++)
        if (in[i] == 0)
            q.push(i);
    while (!q.empty()) {
        int u = q.front();
        q.pop();
        for (auto [v, w]: e[u]) {
            f[v] += (f[u] + w) / cnt[v];
            in[v]--;
            if (in[v] == 0)
                q.push(v);
        } 
    }
    printf("%.2f\n", f[1]);
    return 0;
}

