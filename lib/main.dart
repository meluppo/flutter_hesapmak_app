import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {



  String islem = '0';
  String result = '0';
  String expression = '';

  void onDigitPress(String buttonText){
    setState(() {
      if(buttonText == 'C'){
        islem = '0';
        result = '0';

      }

      else if(buttonText == '⌫'){

        islem = islem.substring(0, islem.length - 1);
        if(islem == ''){
          islem = '0';
        }
      }

      else if(buttonText == '='){


        expression = islem;
        expression = expression.replaceAll('x', '*');


        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = 'Yanlış Girdi!!!';
        }

      }

      else{

        if(islem == '0'){
          islem = buttonText;
        }else {
          islem = islem + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('CET Hesap Makinesi'),

        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '$islem',
                  style: TextStyle(fontSize: 30),
                ),

              ),

            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '$result',
                  style: TextStyle(fontSize: 55, fontFamily: 'SulphurPoint'),


                ),

              ),

            ),

            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        buildCalcButton('C', Colors.redAccent),

                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        buildCalcButton('⌫', Colors.lightBlue),
                        buildCalcButton('/', Colors.lightBlue),
                      ],
                    ),
                  ),
                ],
              ),

            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('7', Colors.black54),
                  buildCalcButton('8', Colors.black54),
                  buildCalcButton('9', Colors.black54),
                  buildCalcButton('x', Colors.lightBlue),

                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('4', Colors.black54),
                  buildCalcButton('5', Colors.black54),
                  buildCalcButton('6', Colors.black54),
                  buildCalcButton('+', Colors.lightBlue),

                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('1', Colors.black54),
                  buildCalcButton('2', Colors.black54),
                  buildCalcButton('3', Colors.black54),
                  buildCalcButton('-', Colors.lightBlue),

                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('.', Colors.black54),
                  buildCalcButton('0', Colors.black54),
                  buildCalcButton('00', Colors.black54),
                  buildCalcButton('=', Colors.lightBlue),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildCalcButton(String text, Color color) {
    return Expanded(
      child: FlatButton(
        onPressed: () {
          onDigitPress(text);
        },
        shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: Colors.white30,

              width: 1.0,
              style: BorderStyle.solid,
            )),
        color: color,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}