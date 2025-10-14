#include <bits/stdc++.h>
using namespace std; // min oi
int sg[(1 << 20) + 10];
int main() {
    ios::sync_with_stdio(0); cin.tie(0); cout.tie(0);
    sg[0] = 0;
    for (int i = 1; i <= (1 << 20) - 1; i++) {
        int lst0 = -1;
        set<int> s;
        for (int j = 0; j < 20; j++) {
            if ((i & (1 << j)) == 0)
                lst0 = 1 << j;
            else if (lst0 != -1) {
                int nxt = (i ^ lst0) ^ (1 << j);
                s.insert(sg[nxt]);
            }
        }
        int p = 0;
        for (auto it = s.begin(); ; it++, p++) {
            if (it == s.end() || p != *it) {
                sg[i] = p;
                break;
            }
        }
    }
    int t; cin >> t;
    while (t--) {
        int n; cin >> n;
        int ans = 0;
        for (int i = 1; i <= n; i++) {
            int m; cin >> m;
            int st = 0;
            for (int j = 1; j <= m; j++) {
                int x; cin >> x;
                st ^= 1 << (20 - x);
            }
            ans ^= sg[st];
        }
        if (ans == 0) cout << "NO\n";
        else cout << "YES\n";
    }
    return 0;
}

