#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; cin >> n;
    if (n & 1) {
        cout << -1 << endl;
        return 0;
    }
    int t = 1 << 30;
    while (n) {
        if (n >= t) {
            cout << t << ' ';
            n -= t;
        }
        t >>= 1;
    }
    return 0;
}
