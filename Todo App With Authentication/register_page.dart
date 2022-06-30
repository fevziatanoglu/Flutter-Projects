
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:mytodoapp/home_page.dart';
import 'package:mytodoapp/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

class RegisterPage extends StatelessWidget{

  static var currentUser;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
       resizeToAvoidBottomInset: false,
     backgroundColor: Colors.white24,

     appBar: AppBar(title: Text("ToDoApp"),backgroundColor: Colors.red,),
     body: Center(child: Column(
       children: [

         Padding(
           padding: const EdgeInsets.symmetric(vertical: 30),
           child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 65,fontWeight: FontWeight.bold),),
         ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 40),
           child: Divider(color: Colors.white30,height: 100,thickness: 2,),
         ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 40),
           child: Column(
             children: [
               InputText(controller: emailController, labelText: " email", obsureText: false),
               InputText(controller: passwordController, labelText: " password", obsureText: true),
               InputText(controller: confirmPasswordController, labelText: " confirm password", obsureText: true),
             ],
           ),
         ),
         Column(
           children: [
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 80),
               child: RegisterButton(),
             ),

           ],
         ),
       ],
     ),)
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
            enabledBorder:OutlineInputBorder(
              borderSide:BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            )
        ),
      ),
    );
  }

}
class RegisterButton extends StatefulWidget{
  String errorText="";
  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {

  Future<void> register()async{

    if(emailController.text.isEmpty ||passwordController.text.isEmpty ||confirmPasswordController.text.isEmpty ){
      widget.errorText = "You have to fill all the fields";
    }else{


      if(confirmPasswordController.text == passwordController.text){
        try{
          await firebase_auth.FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
          await FirebaseFirestore.instance.collection("users").doc(emailController.text).collection("todos").add({});
          HomePage.currentUser = FirebaseFirestore.instance.collection("users").doc(emailController.text).id.toString();

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
        }catch(e){
          print(e.toString());
          widget.errorText=e.toString();
        }

      }
      else{widget.errorText = "Passwords do not match!";}



    }





  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.errorText,style: TextStyle(color: Colors.red),),
        ElevatedButton(

onPressed: ()async{
  setState(() {
    register();
  });

}
          ,
          child: Text("Sign İn"),
          style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(40),
              primary:Colors.red,
              shadowColor: Colors.black
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("İf you already have an account ",style: TextStyle(color: Colors.white),),
            InkWell(onTap: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginPage()),(route) => false,);

            },
                child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)

            )],),
      ],
    );
  }
}

