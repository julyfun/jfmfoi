#include <iostream>
using namespace std;
string s, t;
int a[5010], b[5010], c[5010];
int main() {
    cin >> s;
    cin >> t;
    int lena = s.length(), lenb = t.length();
    for (int i = 0; i < lena; i++)
        a[i] = s[lena - 1 - i] - '0';
    for (int i = 0; i < lenb; i++)
        b[i] = t[lenb - 1 - i] - '0';
    for (int i = 0; i < lena; i++)
        for (int j = 0; j < lenb; j++)
            c[i + j] += a[i] * b[j]; // 注意一定要写成 +=
    // 处理进位。c 最多有 lena + lenb 位
    int lenc = lena + lenb;
    for (int i = 0; i < lenc; i++) {
        c[i + 1] += c[i] / 10;
        c[i] %= 10;
    }
    // 可能有多余的 0，比如有一个乘数为 0..
    while (lenc > 1 && c[lenc - 1] == 0)
        lenc--;
    for (int i = lenc - 1; i >= 0; i--)
        cout << c[i];
    return 0;
}

