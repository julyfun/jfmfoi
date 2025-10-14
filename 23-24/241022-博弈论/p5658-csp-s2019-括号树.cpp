#include <bits/stdc++.h>
using namespace std; // min oi
typedef long long ll;
const int N = 5e5 + 10;
char s[N];
vector<int> e[N]; int fa[N]; ll ans[N];
int st[N], top = 0, pre[N];
void find(int u) {
    if (s[u] == '(')
        st[++top] = u;
    else {
        if (top != 0) {
            int l = st[top];
            top--;
            pre[u] = l;
            ans[u] = 1 + ans[fa[l]];
        }
    }
    for (int i = 0; i < e[u].size(); i++) {
        int v = e[u][i];
        find(v);
    }
    if (s[u] == '(')
        top--;
    else if (pre[u] != 0) {
        st[++top] = pre[u];
    }
}
void calc(int u) {
    for (int i = 0; i < e[u].size(); i++) {
        int v = e[u][i];
        ans[v] += ans[u];
        calc(v);
    }
}
int main() {
    ios::sync_with_stdio(0); cin.tie(0); cout.tie(0);
    int n; cin >> n;
    cin >> (s + 1);
    for (int i = 2; i <= n; i++) {
        cin >> fa[i];
        e[fa[i]].push_back(i);
    }
    find(1);
    calc(1);
    ll res = 0;
    for (int i = 1; i <= n; i++)
        res ^= ans[i] * i;
//     for (int i = 1; i <= n; i++, puts(""))
//         cout << i << ' ' << ans[i] << endl;
    cout << res << endl;
    return 0;
}

