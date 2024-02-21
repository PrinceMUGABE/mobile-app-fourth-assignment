import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'button_values.dart'; // Import the Btn class
import 'path_to_theme_notifier.dart'; // Import the file where ThemeNotifier is defined
import 'package:calculator/main.dart'; // Import the MyApp class
import 'login.dart'; // Import the login page

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Drawer Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to Settings page
                // Example: Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
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
                          ? MediaQuery.of(context).size.width / 4
                          : MediaQuery.of(context).size.width / 8,
                      height: MediaQuery.of(context).size.width / 8,
                      child: buildButton(value),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.pop(context); // Close the drawer
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          } else if (index == 1) {
            // Navigate to Settings page
            // Example: Navigator.pushNamed(context, '/settings');
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        },
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
    setState(() {
      switch (value) {
        case Btn.clr:
          number1 = "";
          operand = "";
          number2 = "";
          break;
        case Btn.del:
          if (operand.isEmpty) {
            if (number1.isNotEmpty) {
              number1 = number1.substring(0, number1.length - 1);
            }
          } else {
            if (number2.isNotEmpty) {
              number2 = number2.substring(0, number2.length - 1);
            } else {
              operand = "";
            }
          }
          break;
        case Btn.calculate:
          calculateResult();
          break;
        case Btn.add:
        case Btn.substract:
        case Btn.multiply:
        case Btn.devide:
          if (number1.isNotEmpty && operand.isEmpty) {
            operand = value;
          } else if (number1.isNotEmpty &&
              operand.isNotEmpty &&
              number2.isEmpty) {
            operand = value;
          }
          break;
        default:
          if (operand.isEmpty) {
            number1 += value;
          } else {
            number2 += value;
          }
      }
    });
  }

  void calculateResult() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      double num1 = double.parse(number1);
      double num2 = double.parse(number2);
      double result = 0;
      switch (operand) {
        case Btn.add:
          result = num1 + num2;
          break;
        case Btn.substract:
          result = num1 - num2;
          break;
        case Btn.multiply:
          result = num1 * num2;
          break;
        case Btn.devide:
          if (num2 != 0) {
            result = num1 / num2;
          } else {
            // Handle division by zero
            // For now, just reset the calculator
            number1 = "";
            operand = "";
            number2 = "";
            return;
          }
          break;
      }
      // Display the result
      number1 = result.toString();
      operand = "";
      number2 = "";
    }
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
