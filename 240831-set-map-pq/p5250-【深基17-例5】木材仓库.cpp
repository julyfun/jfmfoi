#include <bits/stdc++.h>
using namespace std;
int main() {
    int n; cin >> n;
    set<int> s;
    while (n--) {
        int op, t; cin >> op >> t;
        if (op == 1) {
            if (s.count(t) == 1)
                cout << "Already Exist" << endl;
            else
                s.insert(t);
        } else {
            if (s.empty()) {
                cout << "Empty" << endl;
                continue;
            }
            auto low = s.lower_bound(t);
            int choice1 = *low;
            if (low != s.begin())
                --low;
            int choice2 = *low;
            int ans = abs(choice2 - t) <= abs(choice1 - t) ? choice2 : choice1;
            s.erase(ans); // 删除木头
            cout << ans << endl;
        }

    }
    return 0;
}
