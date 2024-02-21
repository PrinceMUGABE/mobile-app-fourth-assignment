import 'package:flutter/material.dart';
import 'path_to_theme_notifier.dart'; // Import the file where ThemeNotifier is defined
import 'package:provider/provider.dart';
import 'package:calculator/main.dart'; // Import the MyApp class
import 'calculator_screen.dart'; // Import the CalculatorScreen class
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String _username;
  late String _email;
  late String _password;
  late String _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
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
                if (!(ModalRoute.of(context)!.settings.name == '/')) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                }
              },
            ),
            ListTile(
              title: Text('Calculator'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                if (!(ModalRoute.of(context)!.settings.name == '/calculator')) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CalculatorScreen()),
                  );
                }
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Implement navigation to settings page
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _username = value;
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _password = value;
                },
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _confirmPassword = value;
                },
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Implement sign-up logic
                },
                child: Text('Sign Up'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Navigate to login page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            if (!(ModalRoute.of(context)!.settings.name == '/')) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            }
          } else if (index == 1) {
            if (!(ModalRoute.of(context)!.settings.name == '/calculator')) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CalculatorScreen()),
              );
            }
          } else if (index == 2) {
            // Implement navigation to settings page
          }
        },
      ),
    );
  }
}
