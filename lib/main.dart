import 'package:assigment/firebasemodelclass/Savedataview.dart';
import 'package:assigment/screen/loginscreen.dart';
import 'package:assigment/screen/mainscreen.dart';
import 'package:assigment/screen/registerscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Flutter Database Example',
    home: MyApp(app: app),
  ));
}

bool _issignedin(){
  return true;
}

class MyApp extends StatefulWidget {
  MyApp({required this.app});
  final FirebaseApp app;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isSigned = false;

  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        setState(() {
          isSigned = true;
        });
      } else {
        isSigned = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Database Example',
      home: isSigned == false ?RegisterScreen():MainScreen(),
    );
  }
}
