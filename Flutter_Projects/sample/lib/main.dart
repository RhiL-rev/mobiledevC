import 'package:flutter/material.dart';

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
        primaryColor: const Color(0xFF2196f3),
        hintColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
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
  static var _message ="ok";
  static final _controller = TextEditingController();
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('App Name'),
          ),
        body:
          Center(
            child:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                  _message,
                    style: TextStyle(fontSize:12.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
                  ),
    
                  TextField(
                    controller:_controller,
                    style: TextStyle(fontSize:12.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
                    onChanged:textChanged,
                  ),
    
                  ElevatedButton(key:null, onPressed:buttonPressed,
                    
                    child:
                      Padding(padding:EdgeInsets.all(10.0),
                      child:Icon(
                        Icons.android,
                        size:50.0
                      ),
                      )
                  ),
                      
                    
                ]
    
              ),
    
          ),
    
      );
    }
    void buttonPressed(){
      setState((){
        _message = "you said: ${_controller.text}";
      });
    }

    void textChanged(String val){
      setState((){
        _message = val.toUpperCase();
      });
    }
    
}