#include <bits/stdc++.h>
using namespace std; // min oi
bool prime(int x) {
    for (int i = 2; i * i <= x; i++)
        if (x % i == 0) return false;
    return true;
}
int main() {
    int n; cin >> n;
    cout << (n + 1 <= 3 ? 1 : 2) << endl;
    for (int i = 2; i <= n + 1; i++)
        cout << (prime(i) ? 1 : 2) << ' ';
    return 0;
}

