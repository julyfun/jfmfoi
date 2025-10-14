#include <bits/stdc++.h>
using namespace std; // min oi
int cnt[100010]; // cnt[j]: 选择 j 作为公因数时，能有几个精灵
int main() {
    ios::sync_with_stdio(0); cin.tie(0); cout.tie(0);
    int n; cin >> n;
    for (int i = 1; i <= n; i++) {
        int x; cin >> x;
        for (int j = 1; j * j <= x; j++)
            if (x % j == 0) {
                int ano = x / j;
                cnt[j]++;
                if (ano != j) cnt[ano]++;
            }
    }
    int ans = 1;
    for (int i = 2; i <= 100000; i++)
        ans = max(ans, cnt[i]);
    cout << ans << endl;
    return 0;
}

