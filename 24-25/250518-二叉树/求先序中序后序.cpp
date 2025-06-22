#include <bits/stdc++.h>
using namespace std;

struct Tree {
    int left, right;
} t[100];

void dfs1(int x) {
    if (!x) return;
    cout << x << " ";
    dfs1(t[x].left);
    dfs1(t[x].right);
}

void dfs2(int x) {
    if (!x) return;
    dfs2(t[x].left);
    cout << x << " ";
    dfs2(t[x].right);
}

void dfs3(int x) {
    if (!x) return;
    dfs3(t[x].left);
    dfs3(t[x].right);
    cout << x << " ";
}

int main() {
    int n;
    cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> t[i].left >> t[i].right;
    }
    dfs1(1);
    cout << endl;
    dfs2(1);
    cout << endl;
    dfs3(1);
    return 0;
}
