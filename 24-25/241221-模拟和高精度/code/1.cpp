#include <bits/stdc++.h>
using namespace std;
char a[2500 * 25 + 10];
int n;
void print(int k) {
    int w = 0, l = 0;
    for (int i = 1; i <= n; i++) {
        if (a[i] == 'W') w++;
        else if (a[i] == 'L') l++;
        else if (a[i] == 'E') break;
        if ((w >= k || l >= k) && abs(w - l) >= 2) {
            cout << w << ":" << l << endl;
            w = l = 0;
        }
    }
    cout << w << ":" << l << endl;
}
int main() {
    char tmp;
    while (cin >> tmp) {
        n += 1;
        a[n] = tmp;
    }
    print(11);
    cout << endl; // 题目要求两个分制之间有空行
    print(21);
    return 0;
}
