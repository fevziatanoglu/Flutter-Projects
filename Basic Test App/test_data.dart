import 'package:quiz/questions.dart';

class TestData{
  int _questionNumber=0;
  int _point =0;

  List<Questions> _questions = [
    Questions(question: "Benim adım Fevzi", answer: true),
    Questions(question: "Boyum bir on", answer: false),
    Questions(question: "Kilom yirmi beş", answer: false),
    Questions(question: "Korkun benden", answer: true,)
  ];


  String getQuestions(){
    return _questions[_questionNumber].question;
  }

 bool getAnswers(){
    return _questions[_questionNumber].answer;
 }

 int getLenght(){
    return _questions.length;
}

int getQuestionNumber(){

   return _questionNumber;
}

 void nextQuestion(){
    if(_questions.length-1 > _questionNumber)
    _questionNumber++;
 }

 void resetQuestions(){
    _questionNumber =0;
 }

 bool isFinished(){
   if(_questions.length-1 <= _questionNumber){return true;}
   else{return false;}
 }

 void trueAnswer(){
    _point++;
 }

 void resetPoint(){
    _point =0;
 }

 int point(){
    return _point;
 }

}