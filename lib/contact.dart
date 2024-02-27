import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Map<String, String>> _contacts = [
    {'name': 'John Doe', 'phone': '+250123456789'},
    {'name': 'Jane Smith', 'phone': '+250987654321'},
    {'name': 'Alice Johnson', 'phone': '+250111223344'},
    {'name': 'Bob Brown', 'phone': '+250555666777'},
    {'name': 'Mary Lee', 'phone': '+250888999000'},
    {'name': 'David Clark', 'phone': '+250333444555'},
    {'name': 'Sarah White', 'phone': '+250666777888'},
    {'name': 'Michael Davis', 'phone': '+250999000111'},
    {'name': 'Lisa Harris', 'phone': '+250222333444'},
    {'name': 'Paul Martinez', 'phone': '+250777888999'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          return ListTile(
            title: Text(contact['name'] ?? ''),
            subtitle: Text(contact['phone'] ?? ''),
          );
        },
      ),
    );
  }
}
