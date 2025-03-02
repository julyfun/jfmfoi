#include<iostream>
#include<iomanip>
#include<cmath>
#include<cstring>
#include<cstdio>
#include<algorithm>
#include<queue>
using namespace std;
#define md(a) a=(a%mod+mod)%mod
#define file(a) freopen(#a".in","r",stdin);freopen(#a".out","w",stdout)
const int Ns=305,Ncd=4000005,Ncol=705;
int T,Now;
int n,m,Num,col[Ncd];
int nxt[Ncd],las[Ncol];
int Free,st[Ns][2];
struct Do{int op,x,y;};
vector<Do>Res;
void Clear()
{
	Res.clear();
	for(int i=1;i<=n;i++)st[i][0]=st[i][1]=0;
	for(int i=1;i<=m;i++)nxt[i]=0;
	for(int i=1;i<=Num;i++)las[i]=0;
}
void Up(int x){Res.push_back({1,x,0});}
void Down(int x,int y){Res.push_back({1,y,0}),Res.push_back({2,min(x,y),max(x,y)});}
pair<int,int>Fcol(int c){for(int i=1;i<=n;i++){if(col[st[i][0]]==c)return {i,0};if(col[st[i][1]]==c)return {i,1};}}
int Fsta(){for(int i=1;i<=n;i++)if(i!=Free&&st[i][0]==0)return i;return -1;}
int Fuld(){for(int i=1;i<=n;i++)if(i!=Free&&nxt[st[i][0]]>nxt[st[i][1]])return i;return -1;}
int Fmin(){pair<int,int>ans={m+1,0};for(int i=1;i<=n;i++)if(i!=Free)ans=min(ans,{nxt[st[i][1]],i});return ans.second;}
void Use_Normal(int i)
{
	if(nxt[i]==0)
	{
		pair<int,int>Pos=Fcol(col[i]);
		int x=Pos.first,y=Pos.second;
		if(y==0)Up(x),st[x][0]=0;
		else Down(x,Free),st[x][1]=st[x][0],st[x][0]=0;
	}
	else
	{
		int Pos=Fsta();
		Up(Pos),st[Pos][(st[Pos][1]==0)]=i;
	}
}
int Use_Free(int i)
{
	int Pos=Fuld();
	if(Pos!=-1)
	{
		Up(Pos);int mn=min(nxt[st[Pos][1]],nxt[i]);
		for(int j=i+1;j<=mn-1;j++)Use_Normal(j);
		if(nxt[st[Pos][1]]<nxt[i])Down(Pos,Free),st[Pos][1]=st[Pos][0],st[Pos][0]=i;
		else Up(Pos);
		return mn+1;
	}
	else
	{
		Pos=Fmin(),Up(Free);
		int mn=min(nxt[st[Pos][1]],nxt[i]);
		if(nxt[st[Pos][1]]<nxt[i])st[Free][1]=i,Free=Pos;
		for(int j=i+1;j<=mn-1;j++)Use_Normal(j);
		if(nxt[st[Pos][1]]<nxt[i])Up(Pos),st[Pos][1]=0;
		else Up(Free),st[Free][1]=0;
		return mn+1;
	}
}
void Start()
{
	if(n==1){for(int i=1;i<=m;i++)Up(1);return ;}
	Free=n;
	for(int i=1;i<=m;)
	{
		if(nxt[i]==0)Use_Normal(i),i++;
		else
		{
			int Pos=Fsta();
			if(Pos!=-1)Up(Pos),st[Pos][(st[Pos][1]==0)]=i,i++;
			else i=Use_Free(i);
		}
	}
}
void Play_Game()
{
	scanf("%d%d%d",&n,&m,&Num);
	for(int i=1;i<=m;i++)scanf("%d",&col[i]);
	for(int i=1;i<=m;i++)
	{
		if(las[col[i]])nxt[las[col[i]]]=i,las[col[i]]=0;
		else las[col[i]]=i;
	}
	Start();
	cout<<Res.size()<<endl;
	for(Do x:Res)
	{
		if(x.op==1)printf("1 %d\n",x.x);
		else printf("2 %d %d\n",x.x,x.y);
	}
	Clear();
}
signed main()
{
	scanf("%d",&T);
	while(T--)Play_Game();
	return 0;
} 
