#include <bits/stdc++.h>
using namespace std;
const int N = 1e3 + 10;
int f[N][N];
char s[N];
int main() {
    cin >> (s + 1);
    int n = strlen(s + 1);
    for (int i = 1; i <= n; i++)
        f[i][i] = 0;
    for (int d = 2; d <= n; d++)
        for (int i = 1; i + d - 1 <= n; i++) {
            int j = i + d - 1;
            if (s[i] == s[j]) f[i][j] = f[i + 1][j - 1];
            else f[i][j] = min(f[i][j - 1], f[i + 1][j]) + 1;
        }
    cout << f[1][n] << endl;
    return 0;
}

