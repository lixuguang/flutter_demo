# Flutter Common

## 1. Introduction
`Flutter` 是 `Google` 2017年 在 Google I/O 大会上推出的一款用于**跨平台、高性能的移动应用框架**。  
- 跨平台： 对比其他移动端开发手段，Flutter 使用**自绘UI + 原生**，因为是自绘UI， 所以可以确保在**多平台上 UI 保持一致**。
- 高性能： 同样因为使用自绘UI + 原生，对比 `H5（WebView）` + 原生（`Ionic`），或者 `ReactNative`（js + 原生），**Flutter 省去了中间通信的性能损失以及控件树的转换过程，所以性能更高**。
- 开发效率： 得益于 `Dart` 的语言特性，**开发阶段即时编译`JIT`（`Just in time`）可以使用热重载（`hot reload`）功能，减少每次修改都需要重新打包的时间损耗**。发版阶段使用提前编译`AOT`（`Ahead of time`）保证生成的代码性能。  

---

## 2. Widget
`Flutter` 中几乎所有的对象都是 `Widget`。`Widget` 的功能是描述一个 `UI` 元素的配置数据，而真正绘制到屏幕上是通过 `Widget` 创建出来的 `Element`。由于它们之间有对应关系，所以在大多数场景，可以宽泛的认为 `Widget` 指的就是 `UI` 控件。

Flutter 中组件根据提供的功能大概有如下几个分类：
- 基础组件（Text, Button, Icon, Image, Form & Input）
- 布局组件（Row, Column, Flex, Wrap, Flow, Stack, Position, Align）
- 容器类组件(Container, Padding, DecoratedBox, Clip, Scaffold)
- 滚动组件(SingleChildScrollView,ListView, GridView, CustomScrollView)
- 功能型组件（InheritedWidget, Theme, Dialog, FutureBuilder, StreamBuilder, GestureDetector）
- 动画类组件

其中 `Scaffold`， `Button`（`FlatButton`, `RaisedButton`） 等一些组件默认是由 `Material UI` 库提供的，使用的时候一定要在 `MaterialApp` 下使用，否则可能会报错。本质上它们也是由一些基础组件组合而成的。  

---

## 3. Stateful && Stateless
`Flutter` 按照构建机制，`Widget` 又分为**状态组件**和**无状态组件**。  
- 无状态组件： 使用类初始化的数据进行渲染，组件无需管理自己的状态，初始化是什么样，渲染就是什么样子。
- 状态组件：不仅使用类初始化的数据进行渲染，组件也可以声明自己的状态，当自己的状态发生变化时，可以调用方法重新渲染自身。状态组件拥有生命周期。  

以下是两种 `Widget` 的代码：
```dart
// stateless widget
class ArticleHeader extends StatelessWidget {
  final String title;
  final String author;

  ArticleHeader({ @required this.title, @required this.author });

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Row(
        children: <Widget>[
          Text(title, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: MyColors.black_33
          )),
          Spacer(),
          Text(author, style: TextStyle(
            fontSize: 14,
            color: MyColors.black_33
          ))
        ]
      ),
      padding: EdgeInsets.symmetric(vertical: 4),
    );
  }
}

// stateful widget
class ArticleFooter extends StatefulWidget {

  @override
  _ArticleFooterState createState() => _ArticleFooterState();

}

class _ArticleFooterState extends State<ArticleFooter> {

  bool isThumbed = false;

  @override
  Widget build(BuildContext context) {
    final Color themeColor = Theme.of(context).primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildIconButton(
          Icons.thumb_up,
          onPressed: toggleThumb,
          onLongPress: turnAllOn,
          color: isThumbed ? themeColor : MyColors.black_99
        ),
      ],
    );
  }

  Widget _buildIconButton(
    IconData icon,
    {
      Color color,
      Function onPressed,
      Function onLongPress
    }
  ) {
    return InkWell(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: Container(
        child: Icon(icon, color: color),
        padding: EdgeInsets.all(10.0),
      ),
      borderRadius: BorderRadius.circular(30.0),
    );
  }

  void toggleThumb() {
    setState(() {
      isThumbed = !isThumbed;
    });
  }

}
```

使用时尽可能的使用 `StatelessWidget` 来构建。当组件需要管理自己状态时，比如上例中的 `footer` 组件，因为需要根据状态的不同来切换按钮的颜色，所以使用了 `StatefulWidget`。而作为参数传入的属性尽可能的不要修改。  

---

## 4. Common Layout
#### 1\. 弹性布局
`Flutter` 中的弹性布局模型跟 `web` 开发中的弹性布局非常类似，以下是实现弹性布局的组件。
##### Row
```dart
Row({
  ...
  MainAxisSize mainAxisSize = MainAxisSize.max,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  List<Widget> children = const <Widget>[],
})
```
`Row` 是水平方向上的弹性布局组件，可以考虑成 `css` 的 `flex-direction: row`。
- `mainAxisSize`: 表示主轴（水平）方向上占用的空间，默认是 `MainAxisSize.max`， 表示尽可能多的占用水平方向的空间。`MainAxisSize.min` 则 `Row` 的实际宽度是所有子组件占有的水平空间。
- `mainAxisAlignment`: 可以参照 `css` 的 `justify-content` 属性，表示子组件在水平空间内的对齐方式。
- `crossAxisAlignment`: 可以参照 `css` 的 `align-items`属性，表示子组件在垂直空间内的对齐方式。交叉轴的高度取决于子组件中最高的子组件。  

下面是例子：
```dart
  // article_footer.dart
  @override
  Widget build(BuildContext context) {
    final Color themeColor = Theme.of(context).primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildIconButton(
          Icons.thumb_up,
          onPressed: toggleThumb,
          onLongPress: turnAllOn,
          color: isThumbed ? themeColor : MyColors.black_99
          // color: Theme.of(context).primaryColor
        ),
        _buildIconButton(
          Icons.monetization_on,
          onPressed: toggleCoin,
          color: isCoined ? themeColor : MyColors.black_99
          // color: Theme.of(context).primaryColor
        ),
        _buildIconButton(
          Icons.bookmark,
          onPressed: toggleFavor,
          color: isFavor ? themeColor : MyColors.black_99
          // color: Theme.of(context).primaryColor
        )
      ],
    );
  }
```
其中 `MainAxisAlignment.spaceEvenly` 属性表示**将主轴的空白区域平均分**，所以子组件之间的间距应该是一致的（**包括首尾组件到边缘的距离**）。  

##### Column
```dart
Column({
  ...
  MainAxisSize mainAxisSize = MainAxisSize.max,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  List<Widget> children = const <Widget>[],
})
```
`Column` 是垂直方向上的弹性布局组件，可以考虑成 `css` 的 `flex-direction: column`。
- `mainAxisSize`: 表示主轴（垂直）方向上占用的空间，默认是 `MainAxisSize.max`， 表示尽可能多的占用垂直方向的空间。`MainAxisSize.min` 则 `Column` 的实际宽度是所有子组件占有的垂直空间。
- `mainAxisAlignment`: 可以参照 `css` 的 `justify-content` 属性，表示子组件在垂直空间内的对齐方式。
- `crossAxisAlignment`: 可以参照 `css` 的 `align-items`属性，表示子组件在垂直空间内的对齐方式。交叉轴的高度取决于子组件中最高的子组件。  

下面是例子：  
```dart
  // drawer.dart
  @override
  Drawer build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildDrawerHeader(),
          _buildList(context)
        ],
      ),
    );
  }
```

#### 2\. 滚动布局  
##### 基于 `Sliver` 的延迟构建模型
通常可滚动组件的子组件数量可能会非常多、占用的总高度非常大；如果要一次性将子组件全部构建出将会非常损耗性能。为此，`Flutter` 中提出一个 `Sliver`（薄片）概念，如果一个可滚动组件支持 `Sliver` 模型，那么该滚动可以将子组件分成好多个`薄片（Sliver）`，只有当 `Sliver` 出现在视口中时才会去构建它，这种模型也称为**基于 `Sliver` 的延迟构建模型**。  

##### SingleChildScrollView
`SingleChildScrollView` 是一个只接受一个子组件的滚动组件。它只应在期望的内容不会超过屏幕太多时使用，因为它**不支持延迟实例化模型**，所以在渲染超出屏幕尺寸太多时，性能会很差。一个常用的场景是当调用键盘视口缩小，导致 `Flutter` 报出渲染溢出时使用。下例：  
```dart
    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            // autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ...
                TextFormField(
                  controller: _title,
                  autofocus: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Article Title',
                    hintText: 'Article Title'
                  ),
                  validator: (v) => v.trim().length > 0
                    ? null
                    : 'Please input a title.'
                ),
                _mySigninButton()
              ],
            )
          )
        )
      )
    );
```

##### ListVew
`ListVew` 是最常用的可滚动组件，它可以沿一个方向线性排布所有子组件，并且它**支持基于Sliver的延迟构建模型**。  
`ListVew` 一般使用在列表项较多的情况下，所以它提供了以下两种常用的构造函数。
- `ListVew.builder`
```dart
ListView.builder({
  ...
  @required IndexedWidgetBuilder itemBuilder,
  int itemCount,
  ...
})
```
`itemBuilder` 是列表项的构建器，执行时它返回一个 `Widget`。当列表滚动到具体的 `index` 位置时，该构建器会执行并创建列表项。
`itemCount` 是列表项的数量， 如果为 `null`，则为无限列表。
```dart
ListView.builder(
  itemCount: 100,
  itemBuilder: (BuildContext context, int index) {
    return ListTile(title: Text("$index"));
  }
);
```
- `ListVew.separated`
```dart
ListView.separated({
  ...
  @required IndexedWidgetBuilder itemBuilder,
  @required separatorBuilder,
  int itemCount,
  ...
})
```
`ListVew.separated` 作用是在生成的列表中添加一个分割组件，它比 `ListVew.builder` 多了一个 `separatorBuilder` 参数， 该参数返回一个分割器。
```dart
// article_list.dart
return ListView.separated(
  itemCount: articles.length,
  itemBuilder: (BuildContext context, int index) {
    return GestureDetector(
      child: ArticleItem(article: articles[index]),
      onTap: () {
        final String userName = _getUserName(context);
        if (userName.length > 0) {
          Navigator.of(context)
            .pushNamed('/article', arguments: articles[index].id);
        } else {
          setState(() {
            showDialog = true;
            curId = articles[index].id;
          });
        }
      }
    );
  },
  separatorBuilder: (BuildContext context, int index) => Divider(
    height: 0.5,
    color: Colors.black26,
  )
);
```

#### 3\. 层叠布局  
层叠布局和 `Web` 中的绝对定位是相似的，子组件可以根据距父容器四个角的位置来确定自身的位置。绝对定位允许子组件堆叠起来（按照代码中声明的顺序）。** `Flutter` 中使用 `Stack` 和 `Positioned` 这两个组件来配合实现绝对定位**。`Stack` 允许子组件堆叠，而 `Positioned` 用于根据 `Stack` 的四个角来确定子组件的位置。  

##### Stack
```dart
Stack({
  this.alignment = AlignmentDirectional.topStart,
  this.fit = StackFit.loose,
  this.overflow = Overflow.clip,
  List<Widget> children = const <Widget>[],
})
```
- `alignment`: 此参数决定如何去对齐没有定位（没有使用 `Positioned` ）或部分定位的子组件。所谓部分定位，在这里特指没有在某一个轴上定位：left、right为横轴，top、bottom为纵轴，只要包含某个轴上的一个定位属性就算在该轴上有定位。
- `fit`: 此参数用于确定没有定位的子组件如何去适应 `Stack` 的大小。`StackFit.loose` 表示使用子组件的大小，`StackFit.expand` 表示扩伸到`Stack` 的大小。
- `overflow`: 此属性决定如何显示超出 `Stack` 显示空间的子组件；值为 `Overflow.clip` 时，超出部分会被剪裁（隐藏），值为 `Overflow.visible` 时则不会。  

##### Positioned
```dart
const Positioned({
  Key key,
  this.left,
  this.top,
  this.right,
  this.bottom,
  this.width,
  this.height,
  @required Widget child,
})
```
定位属性跟 `web` 中的绝对定位概念一致。同一轴上，给定其中任意两个值，就会自动计算出第三个值（`web` 中一样）。`Flutter` 中同时指定同一轴上的三个属性就会报错。下例：  
```dart
return Stack(
  children: [
    _buildList(context),
    Visibility(
      visible: showDialog,
      child: Positioned(
        child: Container(
          child: _buildDialog(context),
          decoration: BoxDecoration(
            cViolor: Color.fromRGBO(0, 0, 0, .3)
          ),
        )
      )
    )
  ],
);
```
其中 `Visibility` 是一个根据条件（`showDialog`）显示的组件，如果 `showDialog` 为 `true`， 则组件显示，反之则不显示。