#include <bits/stdc++.h>
using namespace std; // min oi
priority_queue<int, vector<int>, greater<int>> small;
priority_queue<int> big;
int main() {
    ios::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    int n; cin >> n;
    for (int i = 1; i <= n; i++) {
        // i 奇数时，保证大根堆存小的 i / 2 + 1 个数
        // 小根堆存大的 i / 2 个数
        int x; cin >> x;
        if (i == 1) big.push(x);
        else if (x <= big.top()) big.push(x);
        else small.push(x);
        if (i % 2 == 1) {
            while (big.size() < i / 2 + 1) {
                int t = small.top(); small.pop();
                big.push(t);
            }
            while (big.size() > i / 2 + 1) {
                int t = big.top(); big.pop();
                small.push(t);
            }
            cout << big.top() << endl;
        }
    }
    return 0;
}

