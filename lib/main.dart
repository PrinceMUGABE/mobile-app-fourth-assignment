import 'package:flutter/material.dart';
import 'package:calculator/login.dart';
import 'package:calculator/network.dart';
import 'package:calculator/camera.dart'; // Import your camera page
import 'package:calculator/Calculator_screen.dart';
import 'package:calculator/contact.dart'; // Import your contact page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool isDarkMode = false;

  // Define widget options for the bottom navigation bar
  static List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    ContactPage(),
    // Updated to navigate to ContactPage
    CalculatorScreen(),
    LoginPage(),
    NetworkPage(),
    CameraPage(), // Include your camera page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDarkMode ? darkTheme : lightTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Navigation Demo'),
          actions: [
            IconButton(
              icon: Icon(Icons.brightness_6),
              onPressed: () {
                toggleTheme();
              },
            ),
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_phone),
              label: 'Contact',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Calculator',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.login),
              label: 'Login',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.network_cell),
              label: 'Network',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera), // Camera icon
              label: 'Camera', // Camera label
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: isDarkMode ? Colors.white : Colors.black,
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Color _getIconColor() {
    return isDarkMode ? Colors.white : Colors.black;
  }
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.indigo,
);
