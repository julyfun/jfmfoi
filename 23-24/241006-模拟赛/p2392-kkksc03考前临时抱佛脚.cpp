#include <bits/stdc++.h>
using namespace std;
int main() {
    int s[4], ans = 0;
    cin >> s[0] >> s[1] >> s[2] >> s[3];
    for (int i = 0; i < 4; i++) {
        int sum = 0, ma = 0;
        for (int j = 0; j < s[i]; j++) {
            int x; cin >> x;
            sum += x; ma = max(ma, x);
        }
        ans += 
    }

    return 0;
}

