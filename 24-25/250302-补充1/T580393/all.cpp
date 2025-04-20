// 1
#include <bits/stdc++.h>
using namespace std;

int main() {
    //coins保存金币，days累加天数
    int k, coins = 0, days = 0;
    cin >> k;
    for (int i = 1; i <= k; i++) {
        for (int j = 1; j <= i; j++) {
            // i 代表行数，同时也是当天可得的金币数
            coins += i;
            days++;
            if (days == k) {
                //天数达到了指定的天数
                break;
            }
        }
        //结束外层循环
        if (days == k) {
            //天数达到了指定的天数
            break;
        }
    }
    cout << coins;
    return 0;
}
