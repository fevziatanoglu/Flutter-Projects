import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:mytodoapp/todo.dart';
import 'login_page.dart';


TextEditingController titleContorller= TextEditingController();
TextEditingController descriptionController = TextEditingController();
late List<ToDo> toDoList;

class HomePage extends StatefulWidget{

  static late var currentUser;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {






  return Scaffold(
    backgroundColor: Colors.white24,
    appBar: AppBar(title: Text("Welcome "+ HomePage.currentUser,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
      backgroundColor: Colors.red,),
    body: Center(
      child: Column(
      children: [

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(HomePage.currentUser).
                    collection("todos").
                    snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot> dataFromDatabase) {

                    return ListView.builder(
                        itemCount: dataFromDatabase.data!.docs.length,
                        itemBuilder: (context, index) {
                          if(!dataFromDatabase.data!.docs.isEmpty){

                          }
                          return Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.red
                                ),
                                //color: Colors.red,

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Title: " +
                                                dataFromDatabase.data!.docs[index]["title"].toString()
                                              , style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Description: " +
                                                dataFromDatabase.data!.docs[index]["description"].toString()
                                              , style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),),
                                          )
                                        ],
                                      ),
                                    ),
                                    IconButton(onPressed: () async {
                                      await FirebaseFirestore.instance.collection(
                                          "users").doc(HomePage.currentUser).
                                      collection("todos")
                                          .doc(
                                          dataFromDatabase.data!.docs[index].id)
                                          .delete();
                                    },
                                      icon: Icon(Icons.delete), color: Colors.white,

                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    );


                }
            ),
          ),
        ),
          ],
        ),
       ),
    bottomNavigationBar: BottomAppBar(color: Colors.red,child: Row(children: [
        Expanded(child: AddButtonAlert()),
        Expanded(child: LogOutButton(),
        ),
      ],
    ),
    ),
      );
    }
  }




class InputText extends StatelessWidget{
  TextEditingController controller;
  String labelText;
  bool obsureText;
  InputText({required this.controller,required this.labelText, required this.obsureText});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obsureText,
        style: TextStyle(color: Colors.white,),
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white24),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20) ,
            )
        ),
      ),
    );
  }
}
class AddToDoButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    addToDo()async{
      if(titleContorller.text.isEmpty || descriptionController.text.isEmpty){

      }else{


        await FirebaseFirestore.instance.collection("users").doc(HomePage.currentUser).collection("todos").add({"title":titleContorller.text,"description":descriptionController.text});
        titleContorller.text="";
        descriptionController.text = "";
      }


    }


    return ElevatedButton(onPressed: (){
      addToDo();
    },
        child: Text("Add To Do"),
        style: ElevatedButton.styleFrom(
            primary:Colors.green,
            shadowColor: Colors.black));
  }

}
class AddButtonAlert extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return ElevatedButton(onPressed: (){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.black
        ,content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        InputText(controller: titleContorller, labelText: " title", obsureText: false),
        InputText(controller: descriptionController, labelText: " description", obsureText: false),
        AddToDoButton(),
      ],

      ),
      );
    });
  },
      child: Text("Add ToDo"),
      style: ElevatedButton.styleFrom(
          primary:Colors.green,
          shadowColor: Colors.black));
  }
}
class LogOutButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    void logOut()async{
      await firebase_auth.FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
    }

    return ElevatedButton(onPressed: (){
      logOut();
    }, child: Text("Log out"),
        style: ElevatedButton.styleFrom(
            primary:Colors.white10,
            shadowColor: Colors.black)
    );
  }

}

