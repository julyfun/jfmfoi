#include <bits/stdc++.h>
using namespace std;
const int N = 5e5 + 10;
int c[N];
int bit(int x) { // 求最后一个 1
    return x & -x; // 最后一段连续的 0，取反全 1，加 1 得到倒数第一位 1
}
int n, m;
void add(int p, int x) { // 在 p 位置加 x，维护树状数组
    while (p <= n) {
        c[p] += x;
        p += bit(p);
    }
}
int pre(int p) { // 求 1 ~ p 前缀和
    // 求 1 ~ 1101
    // ask 1101 : 存 1101
    // ask 1100 : 存 1001 ~ 1100, 不存 0001 ~ 1000, 1101+
    // 存的东西：p - bit(p) + 1 ~ p
    // ask 1000 : 存 0001 ~ 1000 
    int res = 0;
    while (p) {
        res += c[p];
        p -= bit(p);
    }
    return res;
}
int main() {
    ios::sync_with_stdio(0); cin.tie(0); cout.tie(0);
    cin >> n >> m;
    for (int i = 1; i <= n; i++) {
        int x; cin >> x;
        add(i, x);
    }
    while (m--) {
        int op, x, y; cin >> op >> x >> y;
        if (op == 1)
            add(x, y);
        else cout << pre(y) - pre(x - 1) << endl;
    }
    return 0;
}
