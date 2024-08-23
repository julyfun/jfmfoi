// P7072 [CSP-J2020] 直播获奖
#include <iostream>
#include <algorithm>
using namespace std;
int n, w;
int b[1100];
int main() {
    cin >> n >> w;
    for (int i = 1; i <= n; i++) {
        int x;
        cin >> x;
        b[x] += 1;
        int man = 0;
        for (int j = 600; j >= 0; j--) {
            man += b[j];
            if (man >= max(1, i * w / 100)) {
                cout << j << ' ';
                break;
            }
        }
    }
    return 0;
}
