#include <bits/stdc++.h>
using namespace std;
int main() {
    srand(time(0)); // 随机数种子
    const int ans = rand() % 1000 + 1;
    int cnt = 0;
    while (true) {
        int guess;
        cout << "请输入你猜的数字（1-1000）：";
        cin >> guess;
        if (guess < 1 || guess > 1000) {
            cout << "输入错误，请输入1-1000之间的数字。" << endl;
            continue;
        }
        cnt++;
        cout << "第 " << cnt << " 次猜测：";
        if (guess < ans) {
            cout << "猜小了！" << endl;
        } else if (guess > ans) {
            cout << "猜大了！" << endl;
        } else {
            cout << "恭喜你，猜对了！" << endl;
            cout << "答案是：" << ans << endl;
            break;
        }
    }
}