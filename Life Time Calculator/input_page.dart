
import 'package:flutter/material.dart';
import 'package:life_time/result_page.dart';
import 'user_data.dart';

class InputPage extends StatefulWidget{

  State<InputPage> createState() => _InputPageState();
}


String seciliCinsiyet = "";
double sigaraSayisi = 0;
double sporSayisi =0;
int height =170;
int weight =70;
UserData userData = UserData(seciliCinsiyet: seciliCinsiyet, sigaraSayisi: sigaraSayisi, sporSayisi: sporSayisi, height: height, weight: weight);



class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[800],
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
          [
            Text("Health App",style: TextStyle(fontSize: 25),),

            RaisedButton(
                onPressed: (){
                  userData = UserData(seciliCinsiyet: seciliCinsiyet, sigaraSayisi: sigaraSayisi, sporSayisi: sporSayisi, height: height, weight: weight);
                  Route route = MaterialPageRoute(builder: (context){return ResultPage();});
                  Navigator.push(context, route);
                  },
                child: Text("Calculate",style: TextStyle(fontSize: 25,color: Colors.red[100],fontWeight: FontWeight.bold),),
                color: Colors.red[900],
            )
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(child:

      Column(
        children: [
          Expanded(
            child: Row(

              children: [
                Expanded(
                    child: MyTwoButtonContainer(varible:weight ,varibleText: "Weight",)
                ),
                Expanded(
                    child: MyTwoButtonContainer(varible: height,varibleText: "Height",)
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(

              children: [
                Expanded(
                    child: MySliderContainer(min: 0,max: 7,variable: sporSayisi,text: "How often do you work out",)
                ),

              ],
            ),
          ),
          Expanded(
            child: Row(

              children: [
                Expanded(
                    child: MySliderContainer(min: 0,max: 30,variable: sigaraSayisi,text: "How many cigaratte do you smoke",),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(

              children: [
                Expanded(
                      child: MyButtonContainer(
                          containerColor: seciliCinsiyet == "Male"
                        ? Colors.red
                        : Colors.redAccent,

                        child: Column(children: [Text("Male"),Icon(Icons.male)],),
                          onTap: (){
                            setState(() {
                              seciliCinsiyet = "Male";
                            });}
                      ),
                    ),

                Expanded(
                    child: MyButtonContainer(
                      containerColor: seciliCinsiyet == "Female"
                          ? Colors.red
                          : Colors.redAccent,

                      child: Column(children: [Text("Female"),Icon(Icons.female)],),
                      onTap: (){
                        setState(() {
                          seciliCinsiyet = "Female";
                        });}
                    ),
                ),
              ],
            ),
          ),

        ],
      ),
      ),



      );






  }
}

class MyButtonContainer extends StatefulWidget {
  Color containerColor;
  Widget child;
   var onTap;
  MyButtonContainer({this.containerColor = Colors.redAccent,required this.child,required this.onTap});

  @override
  State<MyButtonContainer> createState() => _MyButtonContainerState();
}
class _MyButtonContainerState extends State<MyButtonContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: GestureDetector(
          onTap: widget.onTap,

          child: widget.child),
            padding: EdgeInsets.all(10.5),
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: widget.containerColor,
                borderRadius: BorderRadius.circular(10)),
    );
  }
}




class MyContainer1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}

class MySliderContainer extends StatefulWidget{
  double variable,min,max;

  String text;
  MySliderContainer({required this.variable,required this.max,required this.min, required this.text});
  State<MySliderContainer> createState() => _MySliderContainerState();
}
class _MySliderContainerState extends State<MySliderContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Text((widget.variable.toInt()).toString(),style: TextStyle(fontSize: 35,color: Colors.red[800]),),
          Slider(

              activeColor: Colors.red[700],
              min: widget.min,
              max: widget.max,
              value: widget.variable,
              onChanged: (double newValue){
                setState(() {
                  widget.variable = newValue;
                });
              })
        ],),



      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}




class MyTwoButtonContainer extends StatefulWidget{
  int varible;
  String varibleText;

  MyTwoButtonContainer({required this.varible,required this.varibleText});
  State<MyTwoButtonContainer> createState() => _MyTwoButtonContainerState();
}

class _MyTwoButtonContainerState extends State<MyTwoButtonContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(widget.varibleText,style: TextStyle(fontSize: 20),),
        Text(widget.varible.toString(),style: TextStyle(color: Colors.red[700]),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Expanded(child: ElevatedButton(
                child: Text("+"),
                onPressed: (){
                  setState(() {
                    widget.varible++;
                  });
                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
              )
              ),


            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Expanded(
                child: ElevatedButton(
                  child: Text("-"),
                  onPressed: (){
                    setState(() {
                      widget.varible--;
                    });

                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                ),
              ),
            ),
          ],
        )
      ],),


      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}