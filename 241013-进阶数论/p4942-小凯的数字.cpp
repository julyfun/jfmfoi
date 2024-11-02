#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
int main() {
    ll t;
    cin >> t;
    while (t--) {
        ll l, r; cin >> l >> r;
        cout << (l + r) % 9 * (r - l + 1) % 9 * 5 % 9 << endl;
    }
    return 0;
}
