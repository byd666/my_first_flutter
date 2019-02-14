import 'package:flutter/material.dart ';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

void main() => runApp(MyApp());

enum BuildingType { theater, restaurant }

//数据建模
class Building {
  final BuildingType type;
  final String title;
  final String address;

  Building(this.type, this.title, this.address);
}

//定义ItemView的回调接口
typedef OnItemClickListener = void Function(int position);

//实现ItemView
class ItemView extends StatelessWidget {
  final int position;
  final Building building;
  final OnItemClickListener listener;

  ItemView(this.position, this.building, this.listener);

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
        building.type == BuildingType.restaurant
            ? Icons.restaurant
            : Icons.theaters,
        color: Colors.blue[500]);
    final widget = Row(
      children: <Widget>[
        Container(margin: EdgeInsets.all(16.0), child: icon),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(building.title,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
              Text(building.address)
            ],
          ),
        ),
      ],
    );
    // 一般来说，为了监听手势事件，我们使用 GestureDetector。但这里为了在点击的时候有个
    // 水波纹效果，使用的是 InkWell。
//    return GestureDetector(
//      onTap: () => listener(position),
//      child: widget,
//    );
    return InkWell(
      onTap: () => listener(position),
      child: widget,
    );
  }
}

//实现ListView
class BuildingListView extends StatelessWidget {
  final List<Building> list;
  final OnItemClickListener listener;

  BuildingListView(this.list, this.listener);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return new ItemView(index, list[index], listener);
        });
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ListView Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new HomeScreen());
  }
//弹吐司的方式
//  void showColoredToast(index) {
//    Fluttertoast.showToast(
//        msg: '$index 被点击了',
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.CENTER,
//        timeInSecForIos: 1,
//        backgroundColor: Colors.black,
//        textColor: Colors.white,
//        fontSize: 16.0);
//  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final buildings = [
      Building(
          BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
      Building(BuildingType.theater, 'The Castro Theater', '429 Castro St'),
      Building(
          BuildingType.theater, 'Alamo Drafthouse Cinema', '2550 Mission St'),
      Building(BuildingType.theater, 'Roxie Theater', '3117 16th St'),
      Building(BuildingType.theater, 'United Artists Stonestown Twin',
          '501 Buckingham Way'),
      Building(BuildingType.theater, 'AMC Metreon 16', '135 4th St #3000'),
      Building(BuildingType.restaurant, 'K\'s Kitchen', '1923 Ocean Ave'),
      Building(BuildingType.restaurant, 'Chaiya Thai Restaurant',
          '72 Claremont Blvd'),
      Building(BuildingType.restaurant, 'La Ciccia', '291 30th St'),

      // double 一下
      Building(
          BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
      Building(BuildingType.theater, 'The Castro Theater', '429 Castro St'),
      Building(
          BuildingType.theater, 'Alamo Drafthouse Cinema', '2550 Mission St'),
      Building(BuildingType.theater, 'Roxie Theater', '3117 16th St'),
      Building(BuildingType.theater, 'United Artists Stonestown Twin',
          '501 Buckingham Way'),
      Building(BuildingType.theater, 'AMC Metreon 16', '135 4th St #3000'),
      Building(BuildingType.restaurant, 'K\'s Kitchen', '1923 Ocean Ave'),
      Building(BuildingType.restaurant, 'Chaiya Thai Restaurant',
          '72 Claremont Blvd'),
      Building(BuildingType.restaurant, 'La Ciccia', '291 30th St'),
    ];
    return new Scaffold(
        appBar: AppBar(title: Text('Flutter Demo Home Page')),
        body: BuildingListView(
            buildings,
            (index) => Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        new DetailScreen(building: buildings[index])))));
  }
}

class DetailScreen extends StatelessWidget {
  final Building building;

  DetailScreen({Key key, @required this.building}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    final titleSection = _TitleScreen(building.title, building.address, 41);
    final buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildButtonColumn(context, Icons.call, 'CALL'),
          _buildButtonColumn(context, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(context, Icons.share, 'SHARE')
        ],
      ),
    );
    final textSection = Container(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        '''
         Oeschinen湖位于阿尔卑斯山脉的脚下。海拔1578米,它是一个的最大内陆湖之一，穿过草地和松林大约半小时的路程,夏天温度到20摄氏度。在这里你可以尽情享受包括划船,骑夏季平底雪橇等项目，Oeschinen湖位于阿尔卑斯山脉的脚下。海拔1578米,它是一个的最大内陆湖之一，穿过草地和松林大约半小时的路程,夏天温度到20摄氏度。在这里你可以尽情享受包括划船,骑夏季平底雪橇等项目
        ''',
        softWrap: true,
      ),
    );
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("${building.title}"),
        ),
        body: ListView(
          children: <Widget>[
            Image.asset('images/image.jpg',
                width: 600.0, height: 200.0, fit: BoxFit.cover),
            titleSection,
            buttonSection,
            textSection
          ],
        ));
  }
}

Widget _buildButtonColumn(BuildContext context, IconData data, String str) {
  final color = Theme.of(context).primaryColor;
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(data, color: color),
      Container(
        margin: const EdgeInsets.only(top: 8.0),
        child: Text(
          str,
          style: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
        ),
      )
    ],
  );
}

class _TitleScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final int starCount;

  _TitleScreen(this.title, this.subtitle, this.starCount);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text(starCount.toString())
        ],
      ),
    );
  }
}
