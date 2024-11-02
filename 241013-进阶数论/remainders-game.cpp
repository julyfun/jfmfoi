#include <bits/stdc++.h>
using namespace std; // min oi
bool ok[80];
int main() {
    int n, k; scanf("%d %d", &n, &k);
    vector<int> fac;
    // 对 k 分解质因数
    for (int x = 2; x * x <= k; x++) {
        int p = 1;
        while (k % x == 0) k /= x, p *= x;
        if (p > 1) fac.push_back(p);
    }
    if (k > 1) fac.push_back(k);
    int okcnt = 0;
    for (int i = 1; i <= n; i++) {
        // can you finish..
        int x; scanf("%d", &x);
        for (int j = 0; j < fac.size(); j++)
            if (x % fac[j] == 0 && !ok[j]) {
                ok[j] = true;
                ++okcnt;
            }
    } 
    puts(okcnt == fac.size() ? "Yes" : "No");
    return 0;
}

