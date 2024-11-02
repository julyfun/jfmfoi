#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
const int N = 3e6 + 10;
ll inv[N];
int main() {
    int n, p; scanf("%d %d", &n, &p);
    inv[1] = 1;
    // 求 i 的逆元
    // 0 = k * i + r (mod p)
    // 0 = k * r^ + i^
    // i^ = - k * r^
    for (int i = 2; i <= n; i++) {
        int k = p / i;
        int r = p % i; // p 质数
        inv[i] = (ll(-k * inv[r]) % p + p) % p;
    }
    for (int i = 1; i <= n; i++)
        printf("%d\n", inv[i]);
    return 0;
}
