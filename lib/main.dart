// Import necessary dependencies
import 'package:calculator/login.dart';
import 'package:calculator/network.dart';
import 'package:flutter/material.dart';
import 'package:calculator/Calculator_screen.dart';

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

  static List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Contact Page'),
    CalculatorScreen(), // Include CalculatorScreen widget
    LoginPage(), // Include your login page
    NetworkPage(), // Include your network page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 3) {
      // If login option is clicked
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void _onDrawerItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context); // Close the drawer after item selection
    });
    if (index == 3) {
      // If login option is clicked
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else if (index == 4) {
      // If network option is clicked
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NetworkPage()),
      );
    }
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  'Options',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black : Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Home'),
                onTap: () {
                  _onDrawerItemTapped(0);
                },
                selected: _selectedIndex == 0,
                tileColor: _selectedIndex == 0 ? Colors.blue : null,
                selectedTileColor: Colors.blue,
                leading: Icon(Icons.home,
                    color: _selectedIndex == 0 ? Colors.blue : _getIconColor()),
              ),
              ListTile(
                title: Text('Contact'),
                onTap: () {
                  _onDrawerItemTapped(1);
                },
                selected: _selectedIndex == 1,
                tileColor: _selectedIndex == 1 ? Colors.blue : null,
                selectedTileColor: Colors.blue,
                leading: Icon(Icons.contact_phone,
                    color: _selectedIndex == 1 ? Colors.blue : _getIconColor()),
              ),
              ListTile(
                title: Text('Calculator'),
                onTap: () {
                  _onDrawerItemTapped(2);
                },
                selected: _selectedIndex == 2,
                tileColor: _selectedIndex == 2 ? Colors.blue : null,
                selectedTileColor: Colors.blue,
                leading: Icon(Icons.calculate,
                    color: _selectedIndex == 2 ? Colors.blue : _getIconColor()),
              ),
              ListTile(
                title: Text('Login'),
                onTap: () {
                  _onDrawerItemTapped(3);
                },
                selected: _selectedIndex == 3,
                tileColor: _selectedIndex == 3 ? Colors.blue : null,
                selectedTileColor: Colors.blue,
                leading: Icon(Icons.login,
                    color: _selectedIndex == 3 ? Colors.blue : _getIconColor()),
              ),
              ListTile(
                title: Text('Network'),
                onTap: () {
                  _onDrawerItemTapped(4);
                },
                selected: _selectedIndex == 4,
                tileColor: _selectedIndex == 4 ? Colors.blue : null,
                selectedTileColor: Colors.blue,
                leading: Icon(Icons.network_cell,
                    color: _selectedIndex == 4 ? Colors.blue : _getIconColor()),
              ),
            ],
          ),
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
