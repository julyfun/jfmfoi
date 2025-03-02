#include <bits/stdc++.h>
using namespace std; // min oi
const int N = 1e3 + 10;
typedef long long ll;
const ll P = 998244353;
int a[N][N];
char s[N];
/*
1---

----
|
2

3
|
|
*/
int as1[N][N];
int as2[N][N];
int as3[N][N];
int main() {
    int t, id;
    cin >> t >> id;
    while (t--) {
        int n, m, c, f;
        cin >> n >> m >> c >> f;
        for (int i = 1; i <= n; i++) {
            cin >> s + 1;
            for (int j = 1; j <= m; j++) {
                a[i][j] = s[j] - '0';
                as1[i][j] = 0;
                as2[i][j] = 0;
                as3[i][j] = 0;
            }
        }
        for (int i = 1; i <= n; i++) {
            //  000111000
            int cur = 0;
            for (int j = m; j >= 2; j--) {
                if (a[i][j] == 0) cur++;
                else cur = 0;
                if (a[i][j - 1] == 0) as1[i][j - 1] = cur;
            }
        }
        for (int j = 1; j <= m; j++) {
            int cur = 0;
            for (int i = n; i >= 2; i--) {
                if (a[i][j] == 0) cur++;
                else cur = 0;
                if (a[i - 1][j] == 0) as3[i - 1][j] = cur;
            }
        }
        for (int j = 1; j <= m; j++) {
            ll cur = 0;
            for (int i = 1; i <= n - 2; i++) {
                if (a[i][j] == 0) (cur += as1[i][j]) %= P;
                else cur = 0;
                // 贡献到 i + 2 的前提是没有障碍物
                if (a[i + 1][j] == 0 && a[i + 2][j] == 0) as2[i + 2][j] = cur;
            }
        }
        ll ansc = 0;
        for (int i = 1; i <= n; i++)
        // for (int i = 1; i <= n; i++, puts(""))
            for (int j = 1; j <= m; j++) {
                ll asc = (ll)as2[i][j] * as1[i][j] % P;
                (ansc += asc) %= P;
                // cout << asc << ' ';
            }
        ll ansf = 0;
        for (int i = 1; i <= n; i++)
            for (int j = 1; j <= m; j++) {
                ll asf = (ll)as2[i][j] * as1[i][j] % P * as3[i][j] % P;
                (ansf += asf) %= P;
            }
        cout << ansc * c << ' ' << ansf * f << "\n";
    }

    return 0;
}

