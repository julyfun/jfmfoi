#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
const int N = 41, V = 1e6 + 10;
int n;
ll m;
ll a[N];
ll ans = 0;
void dfs(int pos, ll s) {
    if (pos == n + 1) {
        if (s <= m)
            ans++;
        return;
    }
    dfs(pos + 1, s + a[pos]);
    dfs(pos + 1, s);
}

ll f[V];
vector<ll> lsum, rsum;

void find(int pos, int to, vector<ll>& v, ll s) {
    if (pos == to + 1) {
        v.push_back(s);
        return;
    }
    find(pos + 1, to, v, s + a[pos]);
    find(pos + 1, to, v, s);
}

int main() {
    cin >> n >> m;
    for (int i = 1; i <= n; i++)
        cin >> a[i];
    if (n <= 20) {
        dfs(1, 0);
        cout << ans << endl;
        return 0;
    }
    if (m <= 1e6) {
        f[0] = 1;
        for (int i = 1; i <= n; i++)
            for (int j = m; j >= a[i]; j--)
                f[j] += f[j - a[i]];
        for (int i = 0; i <= m; i++)
            ans += f[i];
        cout << ans << endl;
        return 0;
    }
    find(1, n / 2, lsum, 0);
    find(n / 2 + 1, n, rsum, 0);
    sort(lsum.begin(), lsum.end());
    sort(rsum.begin(), rsum.end());
    ll p = rsum.size() - 1;
    for (int i = 0; i < lsum.size(); i++) {
        while (p >= 0 && lsum[i] + rsum[p] > m)
            p--;
        ans += p + 1;
    }
    cout << ans << endl;
    return 0;
}
