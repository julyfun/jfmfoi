#include <cstdio> 
#include <algorithm>
using namespace std;

const char G[6][6] = 
{
	{'#', '#', '#', '#', '#', '#'},
	{'#', '1', '1', '1', '1', '1'},
	{'#', '0', '1', '1', '1', '1'},
	{'#', '0', '0', '*', '1', '1'},
	{'#', '0', '0', '0', '0', '1'},
	{'#', '0', '0', '0', '0', '0'}
};

char g[6][6];

const int wx[8] = {2, 2, 1, 1,-2,-2,-1,-1};
const int wy[8] = {1,-1, 2,-2, 1,-1, 2,-2};

int Min, T;

inline int D()
{
	int res = 0;
	for(int i = 1; i <= 5; ++i)
		for(int j = 1; j <= 5; ++j)
			if(g[i][j] != G[i][j])
				++res;
	return res;
}

void dfs(int x, int y, int st)
{
	int d = D();
	if(d + st > 16)
		return;
	if(d + st >= Min)
		return;
	if(d == 0)
	{
		Min = min(Min, st);
		return;
	}
	for(int i = 0; i <= 7; ++i)
	{
		int tx = x + wx[i];
		int ty = y + wy[i];
		if(tx < 1 || tx > 5 || ty < 1 || ty > 5)
			continue;
		
		swap(g[x][y], g[tx][ty]);
		dfs(tx, ty, st+1);
		swap(g[x][y], g[tx][ty]);
	}
} 

int main()
{
	scanf("%d", &T);
	while(T--)
	{
		int x, y;
		for(int i = 1; i <= 5; ++i)
			for(int j = 1; j <= 5; ++j)
			{
				char ch = getchar();
				while(!(ch == '0' || ch == '1' || ch == '*'))
					ch = getchar();
				g[i][j] = ch;
				if(ch == '*')
					x = i, y = j;
			}
		Min = 0x7fffffff;
		dfs(x, y, 0);
		printf("%d\n", Min > 15 ? -1 : Min);
	}
	return 0;
}
