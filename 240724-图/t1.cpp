#include <iostream>
using namespace std;
int n, m;
int e[110][110];
int main() { 
    cin >> n >> m;
    memset(e, -1, sizeof(e));
    while (m--) {
        int u, v, w;
        cin >> u >> v >> w;
        e[u][v] = w;
    }
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++)
            cout << e[i][j] << ' ';
        cout << '\n';
    }

    return 0;
}
