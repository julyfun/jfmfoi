#include <deque>
#include <iostream>
using namespace std;
deque<int> small;
deque<int> big;
const int N = 1e6 + 10;
int a[N];
int anssmall[N];
int ansbig[N];
int main() {
    int n, k;
    cin >> n >> k;
    for (int i = 1; i <= n; i++)
        cin >> a[i];
    for (int i = 1; i <= n; i++) {
        while (!small.empty() && small.front() < i - k + 1)
            small.pop_front();
        while (!small.empty() && a[i] <= a[small.back()])
            small.pop_back();
        small.push_back(i);

        while (!big.empty() && big.front() < i - k + 1)
            big.pop_front();
        while (!big.empty() && a[i] >= a[big.back()])
            big.pop_back();
        big.push_back(i);

        if (i >= k) {
            anssmall[i - k + 1] = a[small.front()];
            ansbig[i - k + 1] = a[big.front()];
        }
    }

    for (int i = 1; i <= n - k + 1; i++)
        cout << anssmall[i] << ' ';
    cout << endl;
    for (int i = 1; i <= n - k + 1; i++)
        cout << ansbig[i] << ' ';
    cout << endl;

    return 0;
}
