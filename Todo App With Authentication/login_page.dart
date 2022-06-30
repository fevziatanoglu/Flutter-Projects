import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:mytodoapp/register_page.dart';

import 'home_page.dart';


TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();


class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 65,fontWeight: FontWeight.bold),),
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
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: LoginButton(),
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


class  LoginButton extends StatefulWidget{
  String errorText ="";
  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {

  Future<void> ads() async {
    await FirebaseFirestore.instance.collection("users").doc(emailController.text);
    HomePage.currentUser = FirebaseFirestore.instance.collection("users").doc(emailController.text).id;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
  }


  Future<void> login()async{


    if(emailController.text.isEmpty ||passwordController.text.isEmpty ) {
      widget.errorText = "You have to fill all the fields!";
    }else{

      try{
        await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
        HomePage.currentUser = FirebaseFirestore.instance.collection("users").doc(emailController.text).id.toString();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);

      }catch(e){
        widget.errorText = e.toString();
      }

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
              login();
            });

          }





          ,
          child: Text("Login"),
          style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(40),
              primary:Colors.red,
              shadowColor: Colors.black
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("İf you don't  have an account ",style: TextStyle(color: Colors.white),),
            InkWell(onTap: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> RegisterPage()),(route) => false,);
            },
                child: Text("Sign In",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)

            )
          ],),
      ],
    );
  }
}

void asd(){

}

