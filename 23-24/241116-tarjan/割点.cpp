typedef long long ll;
// v:当前点 r：本次搜索树的root
void tarjan(ll u, ll r) {
    dfn[u] = low[u] = ++deep;
    ll child = 0;
    for (unsigned i = 0; i < g[u].size(); i++) {
        ll v = g[u][i];
        if (!dfn[v]) {
            tarjan(v, r);
            low[u] = min(low[u], low[v]);
            if (low[v] >= dfn[u] && u != r)
                cut[u] = 1; //不是根而且他的孩子无法跨越他回到祖先
            if (r == u)
                child++; //如果是搜索树的根，统计孩子数目
        }
        low[u] = min(low[u], dfn[v]); //已经搜索过了
    }
    if (child >= 2 && u == r)
        cut[r] = 1;
}
