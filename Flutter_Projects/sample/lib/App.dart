import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:ffi';
import 'dart:math';

void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primaryColor: const Color(0xFF3f51b5),
        canvasColor: const Color(0xFFfafafa),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(secondary: const Color(0xFF3f51b5)),
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static var time = DateTime.now();
  static List<Data> items =[];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), _onTimer);
  }

    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Deadline Visualizer'),
          foregroundColor: const Color(0xFFfafafa),
          backgroundColor: const Color(0xFF3f51b5),
          shadowColor: Colors.grey,
          
          ),
        body:
          ListView.builder(itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            // background: スワイプ時の背景
            background: Container(
              color: Colors.greenAccent,
              child: const Align(
                  alignment: Alignment.center, child: Icon(Icons.check)),
            ),

            // onDismissed: ウィジェットが閉じられたときに呼び出される
            onDismissed: (DismissDirection direction) {
              setState(() {
                // スワイプしたリストのアイテムを削除
                items.removeAt(index);
              });
            },

            // key: 表示するリストアイテムにキーを付与し、正常にアイテムが置き換わるようにする
            key: ValueKey<int>(index),

            // child: 表示するリストアイテム
            child: ListTile(
              title: Text('Item ${items[index]}'),
              
            ),
          );
      },
    ),
    
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add_circle),
          onPressed: fabPressed),
        bottomNavigationBar: new BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
              icon: const Icon(Icons.assignment),
              label: 'Tasks',
            ),
    
            new BottomNavigationBarItem(
              icon: const Icon(Icons.tune),
              label: 'Settings',
            )
          ]
    
        ),
      );
    }
    void fabPressed() async {
      final pickedDate = await showDatePicker(
       context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime(2000),
       lastDate: DateTime(2100));
       if (pickedDate == null) return;


   // showTimePickerで時間を選択する
      if (!context.mounted) return;
      final pickedTime =
       await showTimePicker(context: context, initialTime: TimeOfDay.now());


   // 時間が選択されなかった場合は早期return
    if (pickedTime == null) return;


   // 選択した日付と時間を結合する
      final dateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
       pickedTime.hour, pickedTime.minute);
    }
  
    
  void _onTimer(Timer timer){
    time = DateTime.now();
  }

    
}
class Data{
  String _task;
  DateTime _dateTime;
  Data(this._task,this._dateTime):super();
}


