import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_selective/constants/constants.dart';
import 'package:warehouse_selective/constants/thema_provider.dart';

class calculator_screen extends StatefulWidget {
  const calculator_screen({super.key});

  @override
  State<calculator_screen> createState() => _calculator_screenState();
}

class _calculator_screenState extends State<calculator_screen> {
  String ara = '';
  String son = '';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(fontSize: 25),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 35,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: _getTexts(),
            ),
          ),
          Expanded(
            flex: 65,
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                  children: [
                    _getButtons("Ü", 'C', 'DE', '(', ')'),
                    _getButtons("M", '7', '8', '9', '/'),
                    _getButtons("R", '4', '5', '6', 'x'),
                    _getButtons("Mz", '1', '2', '3', '+'),
                    _getButtons("", '.', '0', '=', '-'),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _getTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          ara,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 10),
        Text(
          son,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _getButtons(String t0, String t1, String t2, String t3, String t4) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(7),
              child: TextButton(
                onPressed: () => Calculate(t0),
                child: Text(t0),
                style: TextButton.styleFrom(
                  backgroundColor: darkgray,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(7),
              child: TextButton(
                onPressed: () => Calculate(t1),
                child: Text(t1),
                style: TextButton.styleFrom(
                  backgroundColor: darkgray,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(7),
              child: TextButton(
                onPressed: () => Calculate(t2),
                child: Text(t2),
                style: TextButton.styleFrom(
                  backgroundColor: darkgray,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(7),
              child: TextButton(
                onPressed: () => Calculate(t3),
                child: Text(t3),
                style: TextButton.styleFrom(
                  backgroundColor: darkgray,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(7),
              child: TextButton(
                onPressed: () => Calculate(t4),
                child: Text(t4),
                style: TextButton.styleFrom(
                  backgroundColor: darkgray,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void Calculate(String x) {
    setState(() {
      if (x == "Ü") {
        x = "25";
      }
      List<String> temizlik = ['C', 'DE', '='];

      if (!temizlik.contains(x) && son != '') {
        ara = son;
        son = '';
        ara += x;
      } else if (!temizlik.contains(x)) {
        ara += x;
      } else if (x == 'DE') {
        if (ara.isNotEmpty) {
          ara = ara.substring(0, ara.length - 1);
        }
      } else if (x == 'C') {
        ara = '';
        son = '';
      } else {
        if (ara.isNotEmpty) {
          Parser parser = Parser();
          Expression e = parser.parse(ara.replaceAll('x', '*'));
          ContextModel cm = ContextModel();
          son = e.evaluate(EvaluationType.REAL, cm).toString();
        }
      }
    });
  }
}
