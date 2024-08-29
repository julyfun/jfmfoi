#include <cstring>
#include <iostream>
using namespace std;

const int N = 2e3 + 10;
char s[80];
struct Node {
    int is_end;
    int ch[26] = { 0 };
} node[N * 80]; // 字母用边来表示，不用记录在节点上
int cnt = 0;
int ans = 0;
void dfs(int now, int num) {
    if (node[now].is_end)
        num++;
    if (num > ans)
        ans = num;
    for (int i = 0; i < 26; i++)
        if (node[now].ch[i] != 0)
            dfs(node[now].ch[i], num);
}

int main() {
    int n;
    cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> s + 1;
        int len = strlen(s + 1);
        int now = 0; // 0 是 root
        for (int j = 1; j <= len; j++) {
            if (node[now].ch[s[j] - 'a'] == 0) {
                // 增加新节点
                cnt++; // 新节点的编号
                node[now].ch[s[j] - 'a'] = cnt;
            }
            now = node[now].ch[s[j] - 'a'];
            if (j == len)
                node[now].is_end = 1;
        }
    }
    dfs(0, 0);
    cout << ans << endl;
    return 0;
}
