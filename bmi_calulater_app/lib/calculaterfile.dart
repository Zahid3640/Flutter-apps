import 'dart:math';
import 'package:bmi_calulater_app/calculaterfile.dart';
class CalculatorBrain{
 CalculatorBrain({required this.height,required this.weigth});

  final int height;
  final int weigth;
  double _bmi=0.0;
  String  Calculatebmi(){
    _bmi =weigth / pow(height/100, 2);
    return _bmi.toStringAsFixed(1);
  }
  String getresult(){
    if(_bmi>=25){
      return  'Owerweight';
    }else if(_bmi>18.5){
      return'Normal';
    }else{
      return 'Underweight';
    }
  }
  String getInterpretation(){
    if(_bmi>=25){
      return  'You have a heigher than Normal body weight.Try to more exercise.';
    }else if(_bmi>18.5){
      return'You have  Normal body weight.Good Job!';
    }else{
      return 'You have a lower than Normal body weight. You can eat a bit more.';
    }
  }
}