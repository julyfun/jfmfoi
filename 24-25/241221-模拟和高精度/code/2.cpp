#include <iostream>
using namespace std;
string s, t;
int a[510], b[510], c[510];
int main() {
    cin >> s;
    cin >> t;
    // 第一步: 由于读入的字符串 s[0] 存储了最高位，我们要把它反转一下，用 a[0] 存储最低位, a[1] 存储第二低位..
    for (int i = 0; i < s.length(); i++)
        a[i] = s[s.length() - 1 - i] - '0';
    for (int i = 0; i < t.length(); i++)
        b[i] = t[t.length() - 1 - i] - '0';
    int len = max(s.length(), t.length());
    for (int i = 0; i < len; i++) {
        c[i] += a[i] + b[i];
        c[i + 1] += c[i] / 10;
        c[i] %= 10;
    }
    if (c[len] > 0)
        len++;
    for (int i = len - 1; i >= 0; i--)
        cout << c[i];
    return 0;
}

