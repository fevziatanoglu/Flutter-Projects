import 'package:flutter/material.dart';
import 'input_page.dart';

class ResultPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.red,
     appBar: AppBar(
       title: Text("Results"),
       centerTitle: true,),
         body: Center(
           child: Expanded(
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(

                 mainAxisSize: MainAxisSize.max,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.stretch,

                 children: [
                 Text("Sex " + userData.getSex()),
           Text("Height " + userData.getHeight().toString()+ " cm"),
           Text("Weight " + userData.getWeight().toString() + " kg"),
                 Text((userData.getSmoke().toInt()).toString()+ " times smoke a day"),
                 Text((userData.getWorkOut().toInt()).toString() + " times work out in a week"),
                   Text("Note : Sen yarra yemişsin!!!")

     ],),
             ),
           ),
         ),
     );

  }

}