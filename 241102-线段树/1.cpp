#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
const int N = 1e5 + 10;
ll a[N];
ll sum[4 * N], lazy[4 * N];

void build(int k, int l, int r) {
    if (l == r) {
        sum[k] = a[l];
        lazy[k] = 0;
        return;
    }
    int mid = (l + r) / 2;
    build(k * 2, l, mid);
    build(k * 2 + 1, mid + 1, r);
    sum[k] = sum[k * 2] + sum[k * 2 + 1];
    lazy[k] = 0;
}

void add(int k, int l, int r, ll x) {
    // 对 k 号结点进行区间加
    sum[k] += (r - l + 1) * x;
    lazy[k] += x;
}

void pushdown(int k, int l, int r) {
    // k 号结点的懒惰标记往下加
    int mid = (l + r) / 2;
    sum[k * 2] += (mid - l + 1) * lazy[k];
    sum[k * 2 + 1] += (r - mid) * lazy[k];
    lazy[k * 2] += lazy[k];
    lazy[k * 2 + 1] += lazy[k];
    lazy[k] = 0;
}

void modify(int k, int l, int r, int x, int y, ll t) {
    // 在 k 号节点上，对 x 到 y 区间加 t
    if (r < x || y < l) {
        return;
    }
    if (x <= l && r <= y) {
        add(k, l, r, t);
        return;
    }
    pushdown(k, l, r);
    int mid = (l + r) / 2;
    modify(k * 2, l, mid, x, y, t);
    modify(k * 2 + 1, mid + 1, r, x, y, t);
    sum[k] = sum[k * 2] + sum[k * 2 + 1];
}

ll query(int k, int l, int r, int x, int y) {
    if (r < x || y < l) {
        return 0;
    }
    if (x <= l && r <= y) {
        return sum[k];
    }
    pushdown(k, l, r);
    int mid = (l + r) / 2;
    return query(k * 2, l, mid, x, y) + query(k * 2 + 1, mid + 1, r, x, y);
}

int main() {
    int n, m;
    scanf("%d %d", &n, &m);
    for (int i = 1; i <= n; i++) {
        scanf("%lld", &a[i]);
    }
    build(1, 1, n);
    while (m--) {
        int op;
        scanf("%d", &op);
        if (op == 1) {
            int x, y;
            ll k;
            scanf("%d%d%lld", &x, &y, &k);
            modify(1, 1, n, x, y, k);
        } else {
            int x, y;
            scanf("%d%d", &x, &y);
            printf("%lld\n", query(1, 1, n, x, y));
        }
    }
    return 0;
}
