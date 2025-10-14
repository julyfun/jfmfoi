#include <bits/stdc++.h>
#define re register

using namespace std;

int n, m; 

bool g[101][101][71]; 

int dis[101][101];

int main()
{
	memset(dis, 20, sizeof(dis));
	cin >> n >> m;
	for(re int i = 1; i <= m; ++i)
	{
		int u, v;
		scanf("%d %d", &u, &v);
		g[u][v][0] = 1;
		dis[u][v] = 1;
	}
	for(re int k = 1; k <= 32; ++k)
		for(re int i = 1; i <= n; ++i)
			for(re int j = 1; j <= n; ++j)
				for(re int d = 1; d <= n; ++d) 					
					if(g[i][d][k-1] == 1 && g[d][j][k-1] == 1)
						g[i][j][k] = 1, dis[i][j] = 1;
	
	for(re int d = 1; d <= n; ++d)
		for(re int i = 1; i <= n; ++i)
			for(re int j = 1; j <= n; ++j)
				if(dis[i][d] + dis[d][j] < dis[i][j])
					dis[i][j] = dis[i][d] + dis[d][j];
					
	printf("%d\n", dis[1][n]); 
	return 0;
}
