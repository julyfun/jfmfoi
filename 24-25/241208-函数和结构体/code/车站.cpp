#include <iostream>
using namespace std;
int a, n, m, x, ans;
int f[20], sum[20];
int main() {
    cin >> a >> n >> m >> x;
    ans = a;
    if (x >= 3)
        ans += a; //特判
    if (x >= 4) {
        f[1] = f[2] = 1;
        for (int i = 3; i <= n - 4; i++)
            f[i] = f[i - 1] + f[i - 2]; //求斐波那契数列
        for (int i = 1; i <= n - 4; i++)
            sum[i] = sum[i - 1] + f[i]; //求前缀和
        int y = (m - sum[n - 5] * a - ans) / sum[n - 4]; //用推出的公式求y
        ans += sum[x - 4] * a + sum[x - 3] * y; //将答案加回
    }
    cout << ans << endl;
    return 0;
}
