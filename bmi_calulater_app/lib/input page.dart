import 'dart:math';

import 'package:bmi_calulater_app/calculaterfile.dart';
import 'package:flutter/material.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'resultfile.dart';
import 'constant.dart';
import 'containerpage.dart';
import 'iconpage.dart';
import 'calculaterfile.dart';
enum Gender{
  male,female
}
int sliderheight=180;
int weightvalue=60;
int agevalue=20;
class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Color malecolor=DeactiveColor;
  Color femalecolor=DeactiveColor;
  void UpdateColor(Gender gendertype){
   if(gendertype==Gender.male){
     malecolor=ActiveColor;
     femalecolor=DeactiveColor;
   }
   if(gendertype==Gender.female){
     malecolor=DeactiveColor;
     femalecolor=ActiveColor;
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1D10033),
        title: Center(child: Text('BMI Calculator',style:klabelstyle,)),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         Expanded(
           child: Row(
             children: [
               Expanded(
                 child: GestureDetector(
                   onTap: (){
                     setState(() {
                       UpdateColor(Gender.male);
                     });
                   },
                   child: RepeatContainerCode(colorr:  malecolor,
                   cardwidgets: Repeattexticonswidgets(iconData: FontAwesomeIcons.male,label: 'MALE'),),
                 ),
               ),
               Expanded(
                 child: GestureDetector(
               onTap: (){
               setState(() {
               UpdateColor(Gender.female);
               });
               },
                   child: RepeatContainerCode(colorr: femalecolor,
                     cardwidgets: Repeattexticonswidgets(iconData: FontAwesomeIcons.female,label: 'FEMALE',),),
                 ),
               ),
             ],
           ),
         ),
          Expanded(
            child: RepeatContainerCode(
              colorr: Color(0xFF1D1E33),
              cardwidgets: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Height',style: klabelstyle,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(sliderheight.toString(),style: knumstyle,),
                      Text('Cm',style: klabelstyle,),
                    ],
                  ),
                 Slider(value: sliderheight.toDouble(),
                     min: 0.0,
                     max: 210.0,
                     activeColor:Color(0xFF1D10033) ,
                     inactiveColor:Color(0xFF111328) ,
                     onChanged: (double newvalue){
                   setState(() {
                     sliderheight=newvalue.round();
                   });
                 })
                ],
              ),
            )),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: RepeatContainerCode(colorr: Color(0xFF1D1E33),cardwidgets: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Weight',style: klabelstyle,),
                      Text(weightvalue.toString(),style: knumstyle,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: (){
                                setState(() {
                                  weightvalue--;
                                });
                              },
                              child: Icon(FontAwesomeIcons.minus,size: 40,color: Colors.white,)),
                          SizedBox(width: 20,),
                          GestureDetector(
                              onTap: (){
                              setState(() {
                                weightvalue++;
                              });
                              },
                              child: Icon(FontAwesomeIcons.plus,size: 40,color: Colors.white,)),

                        ],
                      )
                    ],
                  ),),),
                Expanded(
                  child:RepeatContainerCode(colorr: Color(0xFF1D1E33),cardwidgets: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Age',style: klabelstyle,),
                      Text(agevalue.toString(),style: knumstyle,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: (){
                                setState(() {
                                  agevalue--;
                                });
                              },
                              child: Icon(FontAwesomeIcons.minus,size: 40,color: Colors.white,)),
                          SizedBox(width: 20,),
                          GestureDetector(
                              onTap: (){
                                setState(() {
                                  agevalue++;
                                });
                              },
                              child: Icon(FontAwesomeIcons.plus,size: 40,color: Colors.white,)),

                        ],
                      )
                    ],
                  ),),),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              CalculatorBrain cal=CalculatorBrain(height:sliderheight,weigth:weightvalue  );
              Navigator.push(context, MaterialPageRoute(builder: (context)=>resultscreen(
                bmiresult: cal.Calculatebmi(),
                resulttext: cal.getresult(),
                interpretation:cal.getInterpretation(),
              )));
            },
            child: Container(
              child: Center(child: Text('Calculate',style: klabelstyle,)),
              width: double.infinity,
              margin: EdgeInsets.all( 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color(0xFF1D10033)
              ),
              height: 60,
            ),
          )
        ],
      )

    );
  }}



