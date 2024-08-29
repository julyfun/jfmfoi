#include <cstdio>
#include <cstring>
using namespace std;
const int N = 1e6 + 10;
char s[N + 1];
int nxt[N + 1];
int main() {
    int n;
    scanf("%d", &n);
    scanf("%s", s + 1);
    int prefix = 0;
    nxt[1] = 0;
    for (int i = 2; i <= n; i++) {
        while (prefix && s[prefix + 1] != s[i])
            prefix = nxt[prefix];
        if (s[prefix + 1] == s[i])
            prefix++;
        nxt[i] = prefix;
    }
    printf("%d\n", n - nxt[n]);
    return 0;
}
