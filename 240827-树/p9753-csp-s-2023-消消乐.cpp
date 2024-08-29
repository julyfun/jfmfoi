#include <bits/stdc++.h>
using namespace std;
typedef unsigned long long ull; // 自然溢出
const ull N = 2e6 + 10, BASE = 19260817;
int n;
string s;
stack<char> stk;
unordered_map<ull, ull> cnt;
ull p[N];
int main() {
    cin >> n;
    cin >> s;
    p[0] = 1;
    for (int i = 1; i < n; i++) {
        p[i] = p[i - 1] * BASE;
    }
    ull h = 0;
    ull ans = 0;
    cnt[0] = 1; // 空串
    for (int i = 0; i < n; i++) {
        if (!stk.empty() && s[i] == stk.top()) {
            h -= p[stk.size() - 1] * s[i];
            stk.pop();
        } else {
            stk.push(s[i]);
            h += p[stk.size() - 1] * s[i];
        }
        ans += cnt[h];
        cnt[h]++;
    }
    cout << ans << endl;
    return 0;
}
