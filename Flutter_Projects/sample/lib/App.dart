import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generated App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  var time = DateTime.now();
  int idg = 1;
  static List<ToDoElement> tlist = [];
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), _onTimer);
  }

  void _onTimer(Timer timer) {
    var new_time = DateTime.now();
    setState(() {
      time = new_time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Remaining Time Visualizer'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: tlist.length,
            itemBuilder: (BuildContext context, int index) {
              return tlist[index];
            }),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_circle), onPressed: fabPressed),
    );
  }

  void fabPressed() async {
    DateTime? lt;
    _controller.text = "";
    String tmptxt = "";
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('タスク名を入力してください'),
        content: TextField(
          onChanged: (value) {
            setState(() {
              tmptxt = value;
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _controller.text = tmptxt;
              });
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
    String st = _controller.text;
    DateTime? dy = await showDatePicker(
        context: context,
        initialDate: time,
        firstDate: new DateTime(2020),
        lastDate: new DateTime.now().add(new Duration(days: 360)));
    if (dy == null) {
      return;
    }
    TimeOfDay? hm = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 0, minute: 0));
    if (hm == null) {
      return;
    }

    lt = DateTime(dy.year, dy.month, dy.day, hm.hour, hm.minute);
    tlist.add(ToDoElement(
      id: idg,
      name: st,
      timelimit: lt,
      tlist: tlist,
    ));
    tlist.sort((a, b) => a.timelimit.compareTo(b.timelimit));
    idg++;

    setState(() {});
  }
}

class ToDoElement extends StatefulWidget {
  final int id;
  final String name;
  final DateTime timelimit;
  final List<Widget> tlist;

  ToDoElement({
    required this.id,
    required this.name,
    required this.timelimit,
    required this.tlist,
  });
  // TODO: implement key
  Key? get key => ValueKey(id);
  @override
  _ToDoElementState createState() => _ToDoElementState();
}

class _ToDoElementState extends State<ToDoElement> {
  DateTime nowtime = DateTime.now();
  String showstring = "";
  Timer? tmr;
  @override
  void initState() {
    super.initState();
    tmr = Timer.periodic(Duration(seconds: 1), update);
  }

  void update(Timer timer) {
    setState(() {
      nowtime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text(widget.name),
            isThreeLine: true,
            tileColor: (widget.timelimit.millisecondsSinceEpoch >
                    nowtime.millisecondsSinceEpoch)
                ? Colors.white
                : Colors.red,
            subtitle: (widget.timelimit.millisecondsSinceEpoch >
                    nowtime.millisecondsSinceEpoch)
                ? Text("Remaining Time:" +
                    DateFormat('dd日HH:mm:ss').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.timelimit.millisecondsSinceEpoch -
                                nowtime.millisecondsSinceEpoch))+"\nTimeLimit:"
                                +DateFormat("MM月dd日HH時mm分").format(widget.timelimit))
                : Text("Excess Time:" +
                    DateFormat('dd日HH:mm:ss').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            nowtime.millisecondsSinceEpoch - widget.timelimit.millisecondsSinceEpoch))+"\nTimeLimit:"
                                +DateFormat("MM月dd日HH時mm分").format(widget.timelimit)),
            onLongPress: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Delete Task?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('キャンセル'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            tmr?.cancel();
                            widget.tlist.remove(
                                widget.tlist[widget.tlist.indexOf(widget)]);
                          });
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                )));
  }
}
