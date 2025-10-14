#import "@preview/touying:0.4.2": *
#import "@preview/cetz:0.2.2"
#import "@preview/ctheorems:1.1.2": *
#import "@preview/fletcher:0.5.0" as fletcher: diagram, node, edge, shapes

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

// Register university theme
// You can replace it with other themes and it can still work normally
#let s = themes.university.register(aspect-ratio: "16-9")

// Set the numbering of section and subsection
#let s = (s.methods.numbering)(self: s, section: "1.", "1.1")

// Set the speaker notes configuration
// #let s = (s.methods.show-notes-on-second-screen)(self: s, right)

// [my]

#set text(
  font: ("New Computer Modern", "Songti SC")
)
#show strong: set text(weight: 900)  // Songti SC 700 不够粗

// Global information configuration
#let s = (s.methods.info)(
  self: s,
  title: [set, map, 优先队列],
  subtitle: [],
  author: [方俊杰.SJTU],
  date: datetime.today(),
  institution: [交附闵分 OI],
)

// Pdfpc configuration
// typst query --root . ./example.typ --field value --one "<pdfpc-file>" > ./example.pdfpc
#let s = (s.methods.append-preamble)(self: s, pdfpc.config(
  duration-minutes: 30,
  start-time: datetime(hour: 14, minute: 10, second: 0),
  end-time: datetime(hour: 14, minute: 40, second: 0),
  last-minutes: 5,
  note-font-size: 12,
  disable-markdown: false,
  default-transition: (
    type: "push",
    duration-seconds: 2,
    angle: ltr,
    alignment: "vertical",
    direction: "inward",
  ),
))

// Theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

// Extract methods
#let (init, slides, touying-outline, alert, speaker-note) = utils.methods(s)
#show: init

#show strong: alert

// Extract slide functions
#let (slide, empty-slide) = utils.slides(s)

// --- 以下为正文

#show raw.where(lang: "cpp"): it => {
  set text(12pt)
  it
}

#set text(20pt)

#show: slides

= set

std::set 有序、不重地存储元素。

- 关于头文件

== P1059 [NOIP2006 普及组] 明明的随机数

```
10
20 40 32 67 40 20 89 300 400 15
```

=>

```
8
15 20 32 40 67 89 300 400
```

== 用 set

```cpp
// 定义
set<类型> s;
s.insert(value): 向 set 中插入元素。
s.erase(value) 或 erase(iterator): 移除指定元素或指定位置的元素。
s.count(value): 返回 set 中等于 value 的元素的数量
s.find(value): 查找指定元素，如果找到则返回指向该元素的迭代器，否则返回 set.end() 。
s.size(): 返回 set 中元素的数量。
s.empty(): 判断 set 是否为空。
```

本题目:

```cpp
	int n, num;//n为数据个数
	set<int> st;//定义一个名为st的set容器
	cin >> n;
	for (int i = 0; i < n; i++) {
		cin >> num;
		st.insert(num);//将输入的数据插入st，且为有序
	}
	cout << st.size() << endl;;
	for (auto it = st.begin(); it != st.end(); it++)//使用迭代器循环输出数据
		cout << *it <<" ";
```

== 使用 auto 很方便，但是需要开启 C++11

#slide[
这里 auto 代表的是 set<int>::iterator 类型，可以直接使用 \*it 访问迭代器指向的元素。开启方式:
#image("image.png")
][
  #image("image copy.png")
]

== P5250 【深基17.例5】木材仓库

+ 读入操作次数 `n`。
+ 循环 `n` 次，每次读入操作类型 `op` 和目标值 `t`
    - 如果 `op` 是 1（添加操作）：
        - 如果 `t` 已存在，输出 "Already Exist" `s.count()`
        - 否则尝试将 `t` 添加到集合中。 `s.insert()`
    - 如果 `op` 不是 1（删除最接近的值操作）：
        - 如果集合为空，输出 "Empty" `s.empty()`
        - 如果集合中有 `t`，输出并删除 `t` `s.count()`
        - 否则，找到集合中最接近 `t` 的值，输出并删除该值 `什么方法？`

=== lower_bound()

+ `lower_bound()` 返回一个迭代器，指向第一个 `>= t` 的元素。
+ 只需要在 `lower_bound()` 的返回值和前一个元素中选择一个即可。

= map

== 

#slide[
=== 初始化
```cpp
map<int, string> m;
```
=== 插入元素
```cpp
m[1] = "first";
m[2] = "second";
```
=== 遍历
```cpp
for (auto it = m.begin(); it != m.end(); it++)
    cout << it->first << " " << it->second << endl;
```
=== 查找

```cpp
auto it = m.find(1);
if (it != m.end())
    cout << it->second << endl;
else
    cout << "Not Found" << endl;
```
][
=== 删除
```cpp
m.erase(1);
// or
auto it = m.find(1);
if (it != m.end())
    m.erase(it);
```

=== 大小

```cpp
cout << m.size() << endl;
```
]

== A-B 数对

用 `map<int, int>` 记录每个数出现的次数，并遍历 map，遍历元素为 `i` 则查找 `i - C` 有几个

= 优先队列(堆)

== 堆

- 堆是一种完全二叉树，满足堆性质：父节点的值总是小于或等于子节点的值。
- 构造一个堆: 每个元素首先插入到最后，然后向上调整。
- 提取最小元素: 取出根节点，将最后一个元素放到根节点，然后向下调整。

=== 最大堆 / 最小堆？

== 优先队列用法

```cpp
priority_queue<int> q;
q.push(1);
q.push(2);
q.push(3);
while (!q.empty()) {
    cout << q.top() << endl;
    q.pop();
} // 输出 3 2 1 从大到小输出（q.top() 就是优先级最大的）
```

复杂度: 插入 $O(log n)$, 取出 $O(log n)$

可以自定义结构体并进行排序。

== P4779 【模板】单源最短路径（标准版）

#image("image copy 2.png")

复杂度优化至 $O(m log n)$，入队次数最多 m 次

== P3366 【模板】最小生成树

prim 算法: 从任意点开始作为生成树，每次找到距离生成树最近的点加入生成树。

同样可以用优先队列优化。
