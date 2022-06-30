import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quiz/test_data.dart';
import 'constants.dart';



TestData test1 = TestData();
List <Widget> checkAnswers = [];




void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("QuizApp"), centerTitle: true,backgroundColor: Colors.indigo[800],),
        backgroundColor: Colors.indigo,
        body: SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }}
class QuizPage extends StatefulWidget{
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children:  <Widget>[
          //Questions
        Expanded(child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text((test1.getQuestionNumber()+1).toString() + ". soru " ,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 35),
                ),
                Text(
                  test1.getQuestions(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25),

                  ),
                 ],
                ),
              ),
             ),),

          //AnswersChecks
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(children: checkAnswers),
          ),

          //Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Row(
              children: <Widget>[

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    onPressed: (){
                      setState(() {
                        button(true);
                      },
                      );
                    },
                    color: Colors.green,
                    child: Icon(
                      Icons.thumb_up,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child:
                  RaisedButton(
                    onPressed: (){
                    setState(() {
                      button(false);
                        },
                      );
                    },
                    padding: EdgeInsets.symmetric(vertical: 16),
                  color: Colors.red,
                  child: Icon(
                    Icons.thumb_down,
                    color: Colors.white,
                    size: 35,
                     ),
                    ),
                   ),
                  )
                ],
              ),
            ),
           ],
         );
        }



  void button(bool myAnswer){
    bool correctAnswer = (test1.getAnswers());
    if(test1.isFinished()){
      myAnswer == correctAnswer
          ? checkAnswers.add(trueIcon)
          : checkAnswers.add(falseIcon); test1.trueAnswer();


      showDialog(
        context: context, builder:
          (BuildContext context) {
          return AlertDialog(
            title: Text("Test bitti"),
            content: Text("Skor :" + test1.point().toString()+"/"+test1.getLenght().toString()),
          actions: <Widget>[
            FlatButton(
                child: Text("Tekrar"),
                onPressed: ()
                {
                  setState(() {
                    checkAnswers = [];
                    test1.resetQuestions();
                    test1.resetPoint();
                    },
                  );
                  Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
    }
    else {

      if( myAnswer == correctAnswer){
        checkAnswers.add(trueIcon);
        test1.trueAnswer();

      }

        else
        checkAnswers.add(falseIcon);




      test1.nextQuestion();
    }}
}







