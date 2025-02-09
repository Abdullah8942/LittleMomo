import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState(); // Make the state class public
}

class LoginScreenState extends State<LoginScreen> {
  // Renamed to public
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login() async {
    try {
      print("Login attempt started...");
      print("Email entered: ${emailController.text}");
      print("Password entered: ${passwordController.text}");

      // Sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      print("Firebase sign-in successful!");

      User? user = userCredential.user;
      if (user != null) {
        print("User UID: ${user.uid}");
        print("User email from Auth: ${user.email}");

        // Normalize email to lowercase for Firestore document ID
        String normalizedEmail = user.email!.toLowerCase();
        print("Normalized email for Firestore query: $normalizedEmail");

        // Check Firestore for admin role
        print("Checking Firestore for admin document...");
        DocumentSnapshot adminDoc = await FirebaseFirestore.instance
            .collection('admins')
            .doc(normalizedEmail)
            .get();

        if (adminDoc.exists) {
          print("Admin document found! Proceeding to dashboard...");
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          print("Admin document NOT found. Signing out...");
          try {
            await _auth.signOut();
            print("User signed out successfully");
          } catch (signOutError) {
            print("Sign-out error: $signOutError");
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Access Denied: Not an Admin")),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: Code=${e.code}, Message=${e.message}");
      String message = "Login Failed";
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        message = "Invalid credentials";
      } else if (e.code == 'user-disabled') {
        message = "Account disabled";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      print("Unexpected Error: ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Failed: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Login")),

      backgroundColor: Color(0xffffd66a), // Set background color here
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}