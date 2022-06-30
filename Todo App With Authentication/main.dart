import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mytodoapp/login_page.dart';
import 'package:mytodoapp/register_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return(MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: RegisterPage(),
      ),
      )
    );
  }

}