
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_deneme/signin_page.dart';
import 'package:flutter/material.dart';

TextEditingController controller = TextEditingController();

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();


   runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        ),
        home:
    SignInPage()
    );
  }
}



