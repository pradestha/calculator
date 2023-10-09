import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

// ignore: must_be_immutable
String userInput = " ";
  String result = "0";

// ignore: must_be_immutable
class Calculator extends StatefulWidget {
  Calculator({super.key});
 Color getBgColor= Colors.black;
  
  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3', 
    '-',
    'C',
    '0',
    '.',
    '=', 
  ];
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String? buttonText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child:  Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child:  Text(
                    result,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.red,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: widget.buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return CustomButton(widget.buttonList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CustomButton(String buttonText) {
    return InkWell(
      splashColor: Color.fromARGB(255, 229, 244, 144),
      onTap: () {
        setState(() {
          handleButtons(buttonText);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                 Color.fromARGB(234, 215, 224, 240),
                 Color.fromARGB(226, 228, 236, 184),
              ],
              ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 0.5,
                offset: const Offset(-3, -3),
              ),
            ]),
        child: Center(
          // child: Text(text),
          child: Text(
            buttonText,
            style: TextStyle(
              color: getBgColor(buttonText),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  getColor(String buttonText) {
    if (buttonText == "/" ||
       buttonText == "*" ||
        buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "C" ||
        buttonText == "(" ||
        buttonText == ")") {
      return const Color.fromARGB(255, 252, 100, 100);
    }
    return Colors.white;
  }

  getBgColor(String buttonText) {
    if (buttonText == "AC") {
      return const Color.fromARGB(255, 139, 4, 4);
    }
    if (buttonText == "=") {
      return const Color.fromARGB(222, 232, 161, 30);
    }
    return const Color.fromRGBO(8, 54, 140, 0.843);
  }



handleButtons(String buttonText) {
  if (buttonText == "AC") {
    userInput = "";
    result = "0";
    return;
  }
  if (buttonText == "C") {
    if (userInput.isNotEmpty) {
      userInput = userInput.substring(0, userInput.length - 1);
      return;
    } else {
      return null;
    }
  }

  if (buttonText == "=") {
    result = calculate();
    
    if (userInput.endsWith(".0")) {
      userInput = userInput.replaceAll(".0", "");
    }
    if (result.endsWith(".0")) {
      result = result.replaceAll(".0", "");
      return;
    }
  }
  userInput = userInput + buttonText;
}

String calculate() {
  try {
    var exp = Parser().parse(userInput);
    var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
    return evaluation.toString();
  } catch (e) {
    return "Error";
  }
}
}

