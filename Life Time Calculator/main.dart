import 'dart:ui';

import 'package:flutter/material.dart';
import 'input_page.dart';
void main(){runApp(MyApp());}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.redAccent),
          textTheme: Theme.of(context).textTheme.apply(
            fontSizeDelta: 2.1,
            fontSizeFactor: 2.2,
            bodyColor: Colors.white,

      ),
        iconTheme: IconThemeData(size: 60,color: Colors.white)

      ),
        home: InputPage(),
      );


    }
}

      




