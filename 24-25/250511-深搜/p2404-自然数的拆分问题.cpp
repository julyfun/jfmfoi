#include <bits/stdc++.h>
using namespace std;
int a[10];
void dfs(int n, int pos) {
    if (n == 0) {
        if (pos == 2) {
            return;
        }
        for (int i = 1; i < pos; i++) {
            cout << a[i];
            if (i != pos - 1) cout << "+";
        }
        cout << endl;
        return;
    }
    for (int i = max(1, a[pos - 1]); i <= n; i++) {
        a[pos] = i;
        dfs(n - i, pos + 1);
    }
}
int main() {
    int n;
    cin >> n;
    dfs(n, 1);
    return 0;
}