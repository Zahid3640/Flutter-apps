import 'package:bmi_calulater_app/constant.dart';
import 'package:flutter/material.dart';
import 'containerpage.dart';
import 'input page.dart';
class resultscreen extends StatelessWidget {
   resultscreen({required this.bmiresult,required this.interpretation,required this.resulttext});
  final String bmiresult;
  final String resulttext;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1D10033),
        title: Text(
          'BMI Results',
              style: klabelstyle,

        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 130,
              child: Center(child: Text('Your Results',style:TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.brown) ,)),
            ),
          ),
          Expanded(child: RepeatContainerCode(colorr: Color(0xFF1D1E33),cardwidgets: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(resulttext,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.grey),),
              Text(bmiresult,style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 60,color: Colors.white),),
              Text(interpretation,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.grey,),textAlign: TextAlign.center,)
            ],
          ),)),
           GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>InputPage()));
            },
            child: Container(
              child: Center(child: Text('ReCalculate',style: klabelstyle,)),
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
      ),
    );
  }
}
