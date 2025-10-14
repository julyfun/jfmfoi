#include <cstdio>
#include <cstring>
#include <iostream>
using namespace std;
const int N = 1e6 + 10;
int nxt[N];
char s[N], t[N];
int main() {
    scanf("%s", s + 1);
    scanf("%s", t + 1);
    int tlen = strlen(t + 1);
    nxt[1] = 0; // nxt[i]: 前 i 位的最长相同前后缀长度（不含整串）
    int prefix = 0;
    for (int i = 2; i <= tlen; i++) {
        while (prefix && t[prefix + 1] != t[i])
            prefix = nxt[prefix];
        if (t[prefix + 1] == t[i])
            prefix++;
        nxt[i] = prefix;
    }
    int slen = strlen(s + 1);
    int ok = 0;
    for (int i = 1; i <= slen; i++) {
        while (ok && t[ok + 1] != s[i])
            ok = nxt[ok];
        if (t[ok + 1] == s[i])
            ok++;
        if (ok == tlen) {
            printf("%d\n", i - tlen + 1);
            ok = nxt[ok];
        }
    }
    for (int i = 1; i <= tlen; i++) {
        printf("%d ", nxt[i]);
    }
    return 0;
}
