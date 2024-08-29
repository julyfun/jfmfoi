#include <bits/stdc++.h>
using namespace std; typedef long long ll;
int n, m, q; const int N = 1e5 + 10, T = 21;
const ll INF = 1e9 + 7;
ll a[N], b[N], lmin[N][T], lmax[N][T], rmin[N][T], rmax[N][T], lminpos[N][T], lmaxneg[N][T];
void calc(ll f[][T], int op) {
    for (int t = 1; t <= 20; t++)
        for (int i = 1; i + (1 << t) - 1 <= n; i++) {
            if (op == 0) f[i][t] = min(f[i][t - 1], f[i + (1 << (t - 1))][t - 1]);
            else f[i][t] = max(f[i][t - 1], f[i + (1 << (t - 1))][t - 1]);
        }
}
ll query(int l, int r, ll f[][T], int op) {
    int len = r - l + 1;
    int t = log2(len);
    if (op == 0) return min(f[l][t], f[r - (1 << t) + 1][t]);
    return max(f[l][t], f[r - (1 << t) + 1][t]);
}
int main() {
    cin >> n >> m >> q;
    for (int i = 1; i <= n; i++) {
        cin >> a[i];
        lmin[i][0] = lmax[i][0] = a[i];
        lmaxneg[i][0] = a[i] < 0 ? a[i] : -INF; // 表示无效
        lminpos[i][0] = a[i] >= 0 ? a[i] : +INF;
    }
    for (int i = 1; i <= m; i++) {
        cin >> b[i]; 
        rmin[i][0] = rmax[i][0] = b[i];
    }
    calc(lmin, 0); calc(rmin, 0); calc(lminpos, 0);
    calc(lmax, 1); calc(rmax, 1); calc(lmaxneg, 1);
    while (q--) {
        int l1, r1, l2, r2; cin >> l1 >> r1 >> l2 >> r2;
        vector<ll> ans;
        ll lminn = query(l1, r1, lmin, 0);
        ll lmaxx = query(l1, r1, lmax, 1);
        ll rminn = query(l2, r2, rmin, 0);
        ll rmaxx = query(l2, r2, rmax, 1);
        ll lminposs = query(l1, r1, lminpos, 0);
        ll lmaxnegg = query(l1, r1, lmaxneg, 1);
        if (lminn < 0) { // 试图出负数
            if (rmaxx >= 0) ans.push_back(lmaxnegg * rmaxx);
            else ans.push_back(lminn * rmaxx);
        }
        if (lmaxx >= 0) {
            if (rminn < 0) ans.push_back(lminposs * rminn);
            else ans.push_back(lmaxx * rminn);
        }
        ll maxans = ans[0];
        for (auto res: ans)
            if (res > maxans) maxans = res;
        cout << maxans << endl;
    }
    return 0;
}
