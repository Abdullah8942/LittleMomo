import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'profile.dart';
import 'settings.dart';

class HomeScreen extends StatelessWidget {
  final List<MenuItem> menuItems = [
    MenuItem(title: 'Chicken Momo', price: 'PKR 250', image: 'assets/momo.jpg'),
    MenuItem(title: 'Veg Momo', price: 'PKR 200', image: 'assets/veg.webp'),
    MenuItem(title: 'Spicy Momo', price: 'PKR 270', image: 'assets/spicy.webp'),
    MenuItem(title: 'Fried Momo', price: 'PKR 300', image: 'assets/fried.jpg'),
    MenuItem(title: 'Paneer Momo', price: 'PKR 320', image: 'assets/paneer.webp'),
    MenuItem(title: 'Buff Momo', price: 'PKR 350', image: 'assets/buff.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Little Momo - Home'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.indigo], // New gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return menuItems[index];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
          }
        },
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final String price;
  final String image;

  MenuItem({required this.title, required this.price, required this.image});

  void showToast(BuildContext context) {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal, Colors.indigo], // Same theme as home screen
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25), // Rounded shape
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 12),
          Text(
            'You have successfully ordered $title!',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(image, width: double.infinity, height: 150, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(price, style: TextStyle(fontSize: 16, color: Colors.teal)),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () => showToast(context), // Show toast on button press
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.teal, Colors.indigo], // Button gradient
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text('Order Now', style: TextStyle(fontSize: 13, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
