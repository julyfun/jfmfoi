#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
int n, p;
ll qpow(ll a, ll b) {
    ll base = a, ans = 1;
    while (b) {
        if (b & 1) ans = ans * base % p;
        base = base * base % p;
        b >>= 1;
    }
    return ans;
}
ll inv(ll a) {
    return qpow(a, p - 2);
}

int main() {
    scanf("%d%d", &n, &p);
    for (int i = 1; i <= n; i++)
        printf("%lld\n", inv(i));
    return 0;
}
