#include <iostream>
#include <queue>
using namespace std;
int n;
const int N = 1e4 + 10;
int len[N], in[N], f[N];
std::vector<int> e[N];
std::queue<int> q;
int main() {
    cin >> n;
    for (int i = 1; i <= n; i++) {
        int k;
        cin >> k >> len[i];
        while (true) {
            int p;
            cin >> p;
            if (p == 0)
                break;
            e[p].push_back(i);
            in[i]++;
        }
    }
    for (int i = 1; i <= n; i++) {
        if (in[i] == 0) {
            q.push(i);
            f[i] = len[i];
        }
    }
    int ans = 0;
    while (!q.empty()) {
        int u = q.front();
        q.pop();
        f[u] += len[u];
        ans = max(f[u], ans);
        for (int i = 0; i < e[u].size(); ++i) {
            int v = e[u][i];
            f[v] = max(f[v], f[u]);
            in[v]--;
            if (in[v] == 0) {
                q.push(v);
            }
        }
    }
    cout << ans << endl;
    return 0;
}
