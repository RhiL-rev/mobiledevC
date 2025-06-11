import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  Map<int,ListTile> tasks ={};
  
  static final _controller = TextEditingController();
  int id=1;
  int index_id =0;
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('TODO'),
          backgroundColor: const Color(0xFF2196f3),
          surfaceTintColor: const Color(0xFF2196f3),
          ),
        floatingActionButton: FloatingActionButton(
          child:Icon(Icons.add),
          onPressed:(){
            _controller.text="";
            showDialog(
            context:context,
            builder:(BuildContext context)=>AlertDialog(
    
            title:Text("Add Task"),
            content:const Text("Details"),
            actions:<Widget>[
              Column(children: [
                TextField(
                  controller:_controller,
                  style:TextStyle(
                  fontSize:20.0,
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
            )
          ).then<void>((value)=>setState((){resultAlert(value);})); }
          ),
        body:
          ListView(
            shrinkWrap: true,
            padding:const EdgeInsets.all(20.0),
            children: getlist()
            )
    
      );
    }
    void checkChanged(bool ischanged){
      
    }
    List<Widget> getlist(){
      
      List<Widget> ret=[];
      if(tasks.isEmpty){
        return ret;
      }
      tasks.forEach((id,tile){
        ret.add(tile);
      });
      return ret;
    }

    void resultAlert(bool addTask){
      var listid = id;
      id++;
      if(addTask){
        
          tasks.addEntries([MapEntry(
            listid,
            
          ListTile(
            key:Key(id.toString()),
            leading: Icon(Icons.check_box_outline_blank),
            title:Text(_controller.text),
            selected: false,
            onTap:((){onTapped(listid);})
              
            )
          )]
          );

        }

    }

    void onTapped(int index){
      tasks.forEach((key,value){
        if(key==index)
      });
    }
    
}