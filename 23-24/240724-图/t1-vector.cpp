#include <iostream>
#include <vector>
using namespace std;
int n, m;
vector<int> e[110];
// 每个 e[i] 存储 i 点所有连出去的边（这题没有边权），
// 每个 e[i] 都是一个 int 类型的动态数组，
// 例如 e[1] = { 3, 4, 5 }，e[1] 就是一个 vector<int> 动态数组！
// 这表示 1 号点连向 3, 4, 5
int main() { 
    cin >> n >> m;
    while (m--) {
        int u, v;
        cin >> u >> v;
        e[u].push_back(v);
    }
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < e[i].size(); j++)
            cout << e[i][j] << ' ';
        cout << endl;
    }
    return 0;
}

