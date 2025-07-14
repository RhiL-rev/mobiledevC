import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generated App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xff2196f3),
        canvasColor: const Color(0xfffafafa),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text('INTERNET ACCESS.',
              style: TextStyle(fontSize: 32,
                  fontWeight: ui.FontWeight.w500),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            TextField(
              controller: _controller,
              style: TextStyle(fontSize: 24,),
              minLines: 1,
              maxLines: 5,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.open_in_new),
        onPressed: () {
          addDoc();
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text("loaded!"),
                content: Text("get content from URI."),
              )
          );
        },
      ),
    );
  }

  void addDoc() async{
    var msg = _controller.text;
    final input =msg.split(',');
    final data ={
      'name': input[0],
      'mail': input[1],
      'age': input[2]
    };
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final snapshot = await firestore.collection('mydata').add(data);
    fire();
  }

  void fire() async {
    var msg = _controller.text;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final snapshot = await firestore.collection('mydata')
  .orderBy('name',descending:false)
  .get();
  msg ="";
  snapshot.docChanges.forEach((element) {
    final name = element.doc.get('name');
    final mail = element.doc.get('mail');
    final age = element.doc.get('age');
    msg += "${name} (${age}) <${mail}>\n";
  });
  _controller.text = msg;
  }

  /*Future<UserCredential> signInWithGoogle() async{
    
    final GoogleSignInAccount?
    //version?
      googleUser = await GoogleSignIn().authenticate();
    final GoogleSignInAuthentication?
      googleAuth = await googleUser?.authentication;
  }*/

}