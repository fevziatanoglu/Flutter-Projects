import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_deneme/login_page.dart';
import 'package:flutter/material.dart';

TextEditingController controller = TextEditingController();

class HomePage extends StatelessWidget{
  static late String user;
  @override
  Widget build(BuildContext context) {


   return Scaffold(
     appBar: AppBar(title: Row(children: [Text("Welcome " + user)],),backgroundColor: Colors.red,),
     backgroundColor: Colors.black,


     body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [



         Expanded(child: Container(color: Colors.black,
             child: StreamBuilder<QuerySnapshot>(
                 stream: FirebaseFirestore.instance.collection(user).snapshots(),
                 builder: (context,AsyncSnapshot<QuerySnapshot> dataFromDatabase){
                   return ListView.builder(
                       itemCount: dataFromDatabase.data!.docs.length,
                       itemBuilder: (context , index){

                         return Padding(
                           padding: const EdgeInsets.all(40.0),
                           child: Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(30),
                               color: Colors.red
                             ),

                               child: Flexible

                                 (child: Row(
                                 children: [
                                   Expanded(child: Padding(
                                     padding: const EdgeInsets.all(30.0),
                                     child: Text(dataFromDatabase.data!.docs[index]["thing"].toString(),
                                       style: TextStyle(color: Colors.white,fontSize: 20),
                                     ),
                                   )),

                                   Padding(
                                     padding: const EdgeInsets.all(20.0),
                                     child: ElevatedButton(onPressed: ()async{
                                       await FirebaseFirestore.instance.collection(user).doc(
                                           dataFromDatabase.data!.docs[index].id
                                       ).delete();
                                     },
                                         style: ElevatedButton.styleFrom(
                                           primary: Colors.redAccent
                                         ),
                                         child: Icon(Icons.delete)),
                                   ),

                                 ],
                               ),)
                           ),
                         );
                       }
                   );
                 }
             )

         )),
       ],
     ),


bottomNavigationBar:
BottomAppBar(child:
Expanded(
  child:   Row(
    children: [
      //add alert button
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                  primary:Colors.green,
                  shadowColor: Colors.black
              ),
              onPressed: (){
                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(
                    backgroundColor: Colors.black,
                    content:  Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextFormField(controller: controller,
                                style: TextStyle(color: Colors.white,),
                                decoration: InputDecoration(
                                    labelText: "Enter",
                                    labelStyle: TextStyle(color: Colors.white24),
                                    enabledBorder:OutlineInputBorder(
                                      borderSide:BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(20),
                                    )
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ElevatedButton(onPressed: (){

                              FirebaseFirestore.instance.collection(user).add({"thing":controller.text});
                              controller.text = "";
                              Navigator.pop(context);
                            }, child: Text("Add"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green
                            ),)
                            ,
                          )]),
                  );
                }
                  ,
                );
              } ,
              child: Icon(Icons.add)),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
                  } ,
                   child: Icon(Icons.logout),
                   style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40),
                        primary:Colors.red,
                        shadowColor: Colors.black

            )
        ),
      ),

      )
    ],
  ),
 ),
    color: Colors.black,),


   );
  }

}
/*
Expanded(child: Container(color: Colors.redAccent,
child: StreamBuilder<QuerySnapshot>(
stream: FirebaseFirestore.instance.collection("list2").snapshots(),
builder: (context,AsyncSnapshot<QuerySnapshot> dataFromDatabase){
return ListView.builder(
itemCount: dataFromDatabase.data!.docs.length,
itemBuilder: (context , index){
return Container(
child: Flexible(child: Row(
children: [
Text(dataFromDatabase.data!.docs[index]["thing"].toString()),


ElevatedButton(onPressed: ()async{
await FirebaseFirestore.instance.collection("list2").doc(
dataFromDatabase.data!.docs[index].id
).delete();
}, child: Text("Delete")),
ElevatedButton(onPressed: ()async{
await FirebaseFirestore.instance.collection("list1").add(
{"thing":dataFromDatabase.data!.docs[index]["thing"]}
);

await FirebaseFirestore.instance.collection("list2").doc(
dataFromDatabase.data!.docs[index].id
).delete();
}, child: Text("Push")),
],
),)
);
}
);
}
)

))
*/