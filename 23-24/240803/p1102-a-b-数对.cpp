#include <bits/stdc++.h>
using namespace std;

long long a[200001], ans = 0;
map<long long, long long> g;

int main() {
    int n, c;
    cin >> n >> c;
    for (int i = 1; i <= n; i++) {
        scanf("%lld", &a[i]);
        g[a[i]]++;
    }
    for (int i = 1; i <= n; i++)
        ans += g[a[i] - c]; //B³öÏÖµÄ´ÎÊý
    printf("%lld\n", ans);
    return 0;
}
