#include <bits/stdc++.h>
using namespace std;
int main() {
    int n, c;
    cin >> n >> c;
    map<int, int> m;
    for (int i = 1; i <= n; i++) {
        int x;
        cin >> x;
        if (m.find(x) != m.end())
            m[x]++;
        else
            m[x] = 1;
    }
    long long ans = 0;
    for (auto it = m.begin(); it != m.end(); it++) {
        int key = it->first;
        auto it2 = m.find(key - c);
        if (it2 != m.end())
            ans += (long long)(it->second) * it2->second;
    }
    cout << ans << endl;
    return 0;
}
