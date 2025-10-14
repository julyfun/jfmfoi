#include <bits/stdc++.h>
using namespace std;
int n; const int N = 1e5 + 10;
int a[N];
int main() {
    ios::sync_with_stdio(0); cin.tie(0); cout.tie(0);
    cin >> n;
    for (int i = 1; i <= n; i++)
        cin >> a[i];
    sort(a + 1, a + n + 1);
    int i = 1, j = 2;
    int ans = n;
    while (j <= n) {
        if (a[i] < a[j]) ans--, i++, j++;
        else j++;
    }
    cout << ans << "\n";
    return 0;
}
