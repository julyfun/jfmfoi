#include <bits/stdc++.h>
using namespace std;
string solve() {
    string ans;
    char c;
    while (cin >> c) {
        if (c == '[') {
            int num; cin >> num; // 这个会读入有效的数字
            string x = solve(); // 进入下一层递归
            while (num--) ans += x; // 复制 num 次
        } else if (c == ']') {
            return ans; // 返回上一层递归
        } else {
            ans += c;
        }
    }
    return ans;
}
int main() {
    cout << solve();
    return 0;
}
