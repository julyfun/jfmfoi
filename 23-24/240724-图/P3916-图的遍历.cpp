#include <iostream>
#include <vector>
using namespace std;
const int N = 1e5 + 10;
vector<int> e[N];
int big[N];
void dfs(int u, int from) {
    big[u] = from;
    for (int i = 0; i < e[u].size(); ++i) {
        int v = e[u][i];
        if (big[v])
            continue;
        dfs(v, from);
    }
}

int main() {
    int n, m;
    cin >> n >> m;
    while (m--) {
        int u, v;
        cin >> u >> v;
        e[v].push_back(u);
    }
    for (int i = n; i >= 1; i--) {
        if (big[i] == 0) {
            dfs(i, i);
        }
    }
    for (int i = 1; i <= n; i++)
        cout << big[i] << ' ';
    return 0;
}
