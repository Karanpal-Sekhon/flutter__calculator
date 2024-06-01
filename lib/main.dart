// ignore_for_file: non_constant_identifier_names

import 'package:calculator_project/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var user_question = '';
  var user_answer = '';

  var last_answer = '';
  bool error_message = false;

  final screen_text_style =
      const TextStyle(fontSize: 20, color: Colors.tealAccent);

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '⋅',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
        // column wise structure of the app.
        children: <Widget>[
          // list of widgets
          Expanded(
              // shows the numbers, screen of calculator
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                user_question,
                style: screen_text_style,
              )),
              Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                user_answer,
                style: screen_text_style,
              ))
            ],
          )),
          Expanded(
            // shows the buttons, input side of calculator
            flex: 2,
            child: Center(
                child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0){ // clear buton
                  return Mybutton(
                    buttonTapped: (){
                      setState(() {
                        last_answer = user_answer;
                        user_answer = '';
                        user_question ='';
                        error_message = false;
                      });
                    },
                    button_text: buttons[index],
                    color: isOperator(buttons[index])
                        ? Colors.lightBlueAccent
                        : Colors.indigo,
                    text_color: Colors.white,
                  );
                } else if (index == 1){ // delete button
                  return Mybutton(
                  buttonTapped: (){
                    setState(() {
                      if (user_question.isNotEmpty){
                        user_question = user_question.substring(0, user_question.length-1);
                      } else {
                        user_question = "";
                      }
                    });
                  },
                  button_text: buttons[index],
                  color: isOperator(buttons[index])
                      ? Colors.lightBlueAccent
                      : Colors.indigo,
                  text_color: Colors.white,
                );
                } else if(index == buttons.length -1){ // equals buttons
                  return Mybutton(
                    buttonTapped: (){
                      setState(() {
                        if (!error_message){
                          equalPressed();
                          last_answer = user_answer;
                        } else {
                          user_answer = "Error";
                        }
                      });
                    },
                    button_text: buttons[index],
                    color: isOperator(buttons[index])
                        ? Colors.lightBlueAccent
                        : Colors.indigo,
                    text_color: Colors.white,
                  );
                } else if(index == 2){ // % button
                  return Mybutton(
                    buttonTapped: (){
                      setState(() {
                        // Logic for % 
                        // check if its null/empty
                        if(user_question == ''){
                          user_answer = 'Error';
                          error_message = true;
                        } else if(isNumeric(user_question)){// calculate percentage
                          user_answer = calculate_percentage(user_question);
                          last_answer = user_answer;
                        } else {
                          user_answer = 'Error';
                          error_message = true;
                        }
                      });
                    },
                    button_text: buttons[index],
                    color: isOperator(buttons[index])
                        ? Colors.lightBlueAccent
                        : Colors.indigo,
                    text_color: Colors.white,
                  );
                } else if (index == buttons.length - 2){ // ans button
                  return Mybutton(
                    buttonTapped: (){
                      setState(() {
                        user_question += last_answer;
                      });
                    },
                    button_text: buttons[index],
                    color: isOperator(buttons[index])
                        ? Colors.lightBlueAccent
                        : Colors.indigo,
                    text_color: Colors.white,
                  );
                }else{
                  return Mybutton(
                    buttonTapped: (){
                      setState(() {
                        user_question += buttons[index];
                      });
                    },
                    button_text: buttons[index],
                    color: isOperator(buttons[index])
                        ? Colors.lightBlueAccent
                        : Colors.indigo,
                    text_color: Colors.white,
                  );
                }
              },
            )),
          )
        ],
      ),
    );
  }

  bool isOperator(String x) {
    // This is to manipulate the color of the buttons
    if (x == "%" || x == "/" || x == "⋅" || x == "-" || x == "+" || x == "=") {
      return true;
    }
    return false;
  }

  void equalPressed(){
    String final_question = user_question;
    final_question = final_question.replaceAll('⋅', '*');
    Parser p = Parser();
    Expression exp = p.parse(final_question);
    ContextModel cxm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cxm);

    user_answer = eval.toString();

  }

  bool isNumeric(String string) {
  final numericRegex = 
    RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
  return numericRegex.hasMatch(string);
  }

  String calculate_percentage(String number){

    double num = double.parse(number);
    num = num/100;
    String final_string_num = num.toString();
    return final_string_num;
  }
}
