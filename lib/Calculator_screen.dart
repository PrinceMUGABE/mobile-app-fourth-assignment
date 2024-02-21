import 'package:calculator/Calculator_screen.dart';
import 'package:calculator/button_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'path_to_theme_notifier.dart'; // Import the file where ThemeNotifier is defined

// assuming you have the Btn class in button_values.dart

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = "";
  String operand = "";
  String number2 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        actions: [
          IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: () {
              ThemeMode currentMode =
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? ThemeMode.dark
                      : ThemeMode.light;
              ThemeMode newMode = currentMode == ThemeMode.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;
              Provider.of<ThemeNotifier>(context, listen: false)
                  .setTheme(newMode as ThemeData);
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "$number1$operand$number2".isEmpty
                        ? "0"
                        : "$number1$operand$number2",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            Wrap(
              children: Btn.buttonValues
                  .map(
                    (value) => SizedBox(
                      width: value == Btn.n0
                          ? MediaQuery.of(context).size.width / 2
                          : MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.width / 5,
                      child: buildButton(value),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onBtnTap(String value) {
    // Handle button taps
  }

  Color getBtnColor(value) {
    switch (value) {
      case Btn.del:
      case Btn.clr:
        return Colors.blueGrey;
      case Btn.per:
      case Btn.multiply:
      case Btn.add:
      case Btn.substract:
      case Btn.devide:
      case Btn.calculate:
        return Colors.orange;
      default:
        return Colors.black87;
    }
  }
}
