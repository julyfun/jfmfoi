#include <bits/stdc++.h>
using namespace std;
const int N = 110;
int n;
struct Ed {
    int v;
    int w;
};
std::vector<Ed> e[N];
void adde(int u, int v, int w) {
    e[u].push_back({v, w});
}
// f[u][i] 表示 u 所在的子树，保留 i 个枝条所存有的最大苹果数
int f[N][N], sz[N];
void dfs(int u, int fa, int apple) {
    sz[u] = 1;
    // 二叉树
    int son[2], cnt = 0;
    for (int i = 0; i < e[u].size(); i++) {
        int v = e[u][i].v;
        int w = e[u][i].w;
        // 求 f u i
        if (v == fa) {
            continue;
        }
        dfs(v, u, w);
        sz[u] += sz[v];
        son[cnt++] = v;
    }
    // son[0] 和 son[1] 是两个儿子
    if (!cnt) {
        // 叶子结点
        f[u][1] = apple;
        return;
    }
    for (int tot = 1; tot <= sz[u]; ++tot) {
        // 连接 u 的枝条必须选上，否则 tot 就是 0
        // tot - 1 - left <= sz[son[1]]
        // left >
        for (int left = max(0, tot - 1 - sz[son[1]]); left <= min(sz[son[0]], tot - 1); left++) { 
            f[u][tot] = max(f[u][tot], apple + f[son[0]][left] + f[son[1]][tot - 1 - left]);
        }
    }
}

int main() {
    int q;
    scanf("%d %d", &n, &q);
    for (int i = 1; i <= n - 1; i++) {
        int u, v, w;
        scanf("%d %d %d", &u, &v, &w);
        adde(u, v, w);
        adde(v, u, w);
    }
    dfs(1, 0, 0);
    printf("%d\n", f[1][q + 1]);
    return 0;
}
