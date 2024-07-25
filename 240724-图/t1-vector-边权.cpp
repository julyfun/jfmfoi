#include <iostream>
#include <vector>
using namespace std;
int n, m;
struct E {
    int v; // 目的地
    int w; // 道路的长度
};
vector<E> e[110];
// 每个 e[i] 都是一个 E 类型的动态数组，存储 i 点所有连出去的边的信息，
// 例如 e[2][0] = { 1, 15 }, e[2][1] = { 4, 23 }
int main() { 
    cin >> n >> m;
    while (m--) {
        int u, v, w;
        cin >> u >> v >> w;
        e[u].push_back({v, w}); // 这种方式直接产生一个 E 结构体
    }
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < e[i].size(); j++)
            cout << e[i][j].v << ' ';
        cout << '\n';
        for (int j = 0; j < e[i].size(); j++)
            cout << e[i][j].w << ' ';
        cout << '\n';
    }
    return 0;
}

