#include <iostream>
using namespace std;
int a[8][6];
int b[6];
int dif[6];
int pos[6];
int main() {
    int n;
    cin >> n;
    for (int k = 1; k <= n; k++)
        for (int i = 1; i <= 5; i++)
            cin >> a[k][i];
    int ans = 0;
    for (int i = 0; i <= 99999; i++) {
        bool all_ok = true;
        for (int d = 1; d <= n; d++) {
            int k = i;
            for (int j = 1; j <= 5; j++) {
                b[j] = k % 10;
                dif[j] = (a[d][j] - b[j] + 10) % 10;
                k /= 10;
            }
            int cnt = 0;
            for (int j = 1; j <= 5; j++)
                if (dif[j] != 0) {
                    cnt++;
                    pos[cnt] = j;
                }
            bool ok = false;
            if (cnt == 1)
                ok = true;
            else if (cnt == 2 && dif[pos[1]] == dif[pos[2]] && pos[1] + 1 == pos[2])
                ok = true;
            if (!ok) {
                all_ok = false;
                break;
            }
        }
        if (all_ok)
            ans++;
    }
    cout << ans << endl;
    return 0;
}
