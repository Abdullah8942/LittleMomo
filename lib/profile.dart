import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.indigo], // Matching the theme
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/ai.jpg'), // Change to network image if needed
                backgroundColor: Colors.grey.shade300,
              ),
            ),
            SizedBox(height: 10),
            Text('Mr John', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('john.mr@email.com', style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 20),

            // Profile Details
            ListTile(
              leading: Icon(Icons.person, color: Colors.teal),
              title: Text('Mr John'),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.teal),
              title: Text('john.mr@email.com'),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.teal),
              title: Text('Gujranwala, Pakistan'),
            ),
            SizedBox(height: 20),

            // Edit Profile Button
            Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.indigo], // New gradient
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25), // Intermediate rounded
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
