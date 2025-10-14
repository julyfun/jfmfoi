#include <bits/stdc++.h>
using namespace std;
const int N = 3.2e4 + 10;
int n, m, f[N], q[N];
struct item { int v, w; }; 
vector<item> sub[N]; item my[N];
vector<item> choice[N]; int cnt = 0; 
int main() {
    cin >> n >> m;
    for (int i = 1; i <= m; i++) {
        int v, p; cin >> v >> p >> q[i];
        if (q[i] != 0) sub[q[i]].push_back({v, p * v});
        else my[i] = {v, p * v};
    }
    for (int i = 1; i <= m; i++)
        if (q[i] == 0) {
            ++cnt;
            int v = my[i].v, w = my[i].w;
            choice[cnt].push_back({v, w});
            if (sub[i].size() == 1)
                choice[cnt].push_back({v + sub[i][0].v, w + sub[i][0].w });
            if (sub[i].size() == 2) {
                choice[cnt].push_back({v + sub[i][0].v, w + sub[i][0].w });
                choice[cnt].push_back({v + sub[i][1].v, w + sub[i][1].w });
                choice[cnt].push_back({v + sub[i][0].v + sub[i][1].v, w + sub[i][0].w + sub[i][1].w });
            }
        }
    for (int i = 1; i <= cnt; i++)
        for (int j = n; j >= 0; j--) {
            int best = f[j];
            for (int c = 0; c < choice[i].size(); c++)
                if (j >= choice[i][c].v)
                    best = max(best, f[j - choice[i][c].v] + choice[i][c].w);
            f[j] = best;
        }
    cout << f[n] << endl;
    return 0;
}
