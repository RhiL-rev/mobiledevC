import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


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
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  List<CheckList> tasks= [];
  
  static final _controller = TextEditingController();

  int index_id =0;
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('TODO'),
          backgroundColor: const Color(0xFF2196f3),
          surfaceTintColor: const Color(0xFF2196f3),
          ),
        body:
          ListView(
            shrinkWrap: true,
            padding:const EdgeInsets.all(20.0),
            children: tasks
            ,
            ),
        floatingActionButton: FloatingActionButton(
          child:Icon(Icons.add),
          onPressed:(){
            _controller.text="";
            showDialog(
            context:context,
            builder:(BuildContext context){return StatefulBuilder(
            builder: (context, setState) {return AlertDialog(
              
            title:Text("Add Task",style:TextStyle(
              fontSize:20.0,
            )),
            content:const Text("Details",style:TextStyle(fontSize: 15.0)),
            actions:<Widget>[
              Column(children: [
                TextField(
                  controller:_controller,
                  style:TextStyle(
                  fontSize:15.0,
                   color:Colors.black,
                   fontWeight: FontWeight.w200,
                   fontFamily: "Roboto"
                  )
               ),
               Row(children: [
                  TextButton(
                 onPressed:()=>Navigator.pop<bool>(context,false) ,
                  child:const Text("Cancel")
                  ,
                  ),
                  TextButton(
                    onPressed:()=>Navigator.pop<bool>(context,true) ,
                    child:const Text("Add Task")
                  )
               ],)
                
              ])
      
            ]
            );}
          );}
          ).then<void>((value){
            setState((){resultAlert(value);});});})
          
          
        
    
      );
    }
    void checkChanged(bool ischanged){
      
    }
    

    void resultAlert(bool addTask){
      
      if(addTask){
          
          tasks.add(CheckList(
            title:_controller.text,
          ));
          setState((){});

        }
      
    }

    
  
}

class CheckList extends StatefulWidget{
  const CheckList({
      super.key,
      required this.title,
      
      
  });
  final String title;
  
  @override
  State<CheckList> createState() =>CheckTile();
}

class CheckTile extends State<CheckList>{
  bool isChecked = false;
  var TextStyle_active = TextStyle(color: Colors.black,);
  var TextStyle_deactive = TextStyle(color:Colors.grey,decoration:TextDecoration.lineThrough);
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title,style: isChecked? TextStyle_deactive:TextStyle_active),// コンストラクタで受け取ったtitleを指定
      value: isChecked,
      onChanged: (value) => setState(() {
        isChecked = value!;
        
      }),
      controlAffinity: ListTileControlAffinity.leading,
      
      // コンストラクタで受け取ったtitleを指定
    );
  }
  
}