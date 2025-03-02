import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.indigo], // Matching theme
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Dark Mode Toggle
          SwitchListTile(
            title: Text('Dark Mode', style: TextStyle(fontSize: 18)),
            secondary: Icon(Icons.dark_mode, color: Colors.teal),
            value: darkMode,
            onChanged: (bool value) {
              setState(() {
                darkMode = value;
              });
            },
          ),
          Divider(),

          // Payment Methods
          ListTile(
            leading: Icon(Icons.payment, color: Colors.teal),
            title: Text('Manage Payment Methods'),
            onTap: () {},
          ),
          Divider(),

          // Notifications
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.teal),
            title: Text('Notifications'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
