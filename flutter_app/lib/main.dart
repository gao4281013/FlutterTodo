import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'dart:async';
import 'CostumIcons.dart';
import 'todo.dart';
import 'package:flutter/foundation.dart';
import 'CostumCheckboxTile.dart';
import 'package:intl/intl.dart';
import 'CostumAppbar.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ColorChoies{
  static const List<Color> colors = [
    const Color(0xFF5A89E6),
    const Color(0xFFF77B67),
    const Color(0xFF5A89E6),
  ];

}

List<TodoObject> todos = [

  new TodoObject.import("SOME_RANDOM_UUID", 1, "Custom", ColorChoies.colors[1], Icons.alarm, {
    new DateTime(2018,5,24):[
      new TaskObject(new DateTime(2018,5,24),"Meet Clients"),
      new TaskObject(new DateTime(2018,5,24),"Coding"),
      new TaskObject(new DateTime(2018,5,24),"Code for main.dart"),
      new TaskObject(new DateTime(2018,5,24),"Flutter Study"),
    ],
    new DateTime(2018,5,25):[
      new TaskObject(new DateTime(2018,5,24),"Meet Clients"),
      new TaskObject(new DateTime(2018,5,24),"Coding"),
      new TaskObject(new DateTime(2018,5,24),"Code for main.dart"),
      new TaskObject(new DateTime(2018,5,24),"Flutter Study"),
    ],
  }),
  new TodoObject("Personal", Icons.person),
  new TodoObject("Work", Icons.work),
  new TodoObject("Home", Icons.home),
  new TodoObject("Wife", Icons.person),
  new TodoObject("Bady", Icons.menu),
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  ScrollController scrollController;
  Color backgroundColor;
  Tween<Color> colorTween;
  int currentPage = 0;
  Color constBackColor;


  @override
  void initState() {
    colorTween = new ColorTween( begin: ColorChoies.colors[0],end: ColorChoies.colors[1]);
    backgroundColor = todos[0].color;
    scrollController = new ScrollController();
    scrollController.addListener((){
      ScrollPosition position = scrollController.position;
      ScrollDirection direction = position.userScrollDirection;
      int page = (position.pixels / (position.maxScrollExtent/(todos.length.toDouble() -1 ))).toInt();
      double pageDo = (position.pixels /(position.maxScrollExtent/(todos.length.toDouble() -1)));
      double percent = pageDo -page;

      if(direction == ScrollDirection.reverse){
        if(todos.length -1 < page+1){
          return;
        }
        colorTween.begin = todos[page].color;
        colorTween.end = todos[page+1].color;
        setState(() {
          backgroundColor = colorTween.lerp(percent);
        });
      }else if (direction == ScrollDirection.forward){
        if(todos.length -1 <page+1){
          return;
        }
        colorTween.begin = todos[page].color;
        colorTween.end = todos[page+1].color;
        setState(() {
          backgroundColor = colorTween.lerp(percent);
        });

      }else {
        return;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final double _width = MediaQuery.of(context).size.width;
    final double _ratioW = _width/375.0;

    final double _height = MediaQuery.of(context).size.height;
    final double _ratioH = _height/812.0;

    return new Container(
      decoration: new BoxDecoration(
        color: backgroundColor
      ),
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: new Text("TODO"),
          leading: new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: (){}
              ),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(CustomIcons.search,size: 26.0),
                onPressed: (){}
                ),
          ],
        ),
        body: new Container(
          child: new Stack(
            children: <Widget>[
              new Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.only(top: 20.0,bottom: 20.0,left: 50.0,right: 60.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black38,
                                    offset: new Offset(5.0, 5.0),
                                    blurRadius: 15.0,
                                  ),
                                ],
                                shape: BoxShape.circle,
                              ),
                              child: new CircleAvatar(
                                backgroundColor: Colors.grey,
                              ),
                            ),
                          ),
                          new Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                          child: new Text(
                            "Hello, Gavin",
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                            ),
                          ),
                          ),
                          new Text(
                            "This is a daily quote",
                            style: new TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          new Text(
                            "You have 10 tasks to do today",
                              style: new TextStyle(
                                color: Colors.white70,
                              ),
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      height: 350.0,
                      width: _width,
                      child: new ListView.builder(
                          itemBuilder: (context,index){
                            TodoObject todoObject = todos[index];
                            EdgeInsets padding = const EdgeInsets.only(left: 10.0,right: 10.0,top: 20.0,bottom: 30.0);

                            double percentComplete = todoObject.percentComplete();

                            return new Padding(
                                padding: padding,
                                child: new InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(new PageRouteBuilder(
                                        pageBuilder: (BuildContext context,Animation<double> animation,Animation<double> secondaryAnimation) => new DetailPage(todoObject: todoObject),
                                        transitionsBuilder: (BuildContext context,Animation<double> animation,Animation<double> secondaryAnimation,Widget child){
                                          return new SlideTransition(
                                              position: new Tween<Offset>(
                                                 begin: const Offset(0.0,1.0),
                                                 end: Offset.zero,
                                              ).animate(animation),
                                              child: new SlideTransition(
                                                  position: new Tween<Offset>(
                                                    begin: Offset.zero,
                                                    end: const Offset(0.0, 1.0),
                                                  ).animate(secondaryAnimation),
                                                child: child,
                                              ),
                                          );
                                        },
                                      transitionDuration: const Duration(milliseconds: 1000)
                                    ),);
                                  },
                                 child: new Container(
                                   decoration: new BoxDecoration(
                                     borderRadius: new BorderRadius.circular(10.0),
                                     boxShadow: [
                                       new BoxShadow(
                                         color: Colors.black.withAlpha(70),
                                         offset: const Offset(3.0, 10.0),
                                         blurRadius: 15.0
                                       )
                                     ]
                                   ),
                                   height: 250.0,
                                   child: new Stack(
                                     children: <Widget>[
                                       new Hero(
                                           tag: todoObject.uuid + "_background",
                                           child: new Container(
                                               decoration: new BoxDecoration(
                                                 color: Colors.white,
                                                 borderRadius: new BorderRadius.circular(10.0),
                                               ),
                                           )
                                       ),
                                       new Padding(
                                           padding: null),
                                     ],
                                   ),
                                 ),
                                ),
                            );
                          }),

                    ),
                  ],
                ),

              ),
              new Padding(
                  padding: const EdgeInsets.only(right: 15.0,bottom: 15.0),
                  child: new Align(
                    alignment: Alignment.bottomRight,
                    child: new FloatingActionButton(
                        onPressed: (){},
                        tooltip: 'Increment',
                        child: new Icon(Icons.add),
                    ),
                  ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final TodoObject todoObject;


  DetailPage({@required this.todoObject,Key key}):super(key:key);

  @override
  _DetailPageState createState() => new _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}

class CustomScrollPhysics extends ScrollPhysics{

}