import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import  'login.dart';
import 'admin_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDNkshRcutVaC2QppI9Fhxrbnxnyw6Hcxc",
      authDomain: "little-momo-9fbc2.firebaseapp.com",
      projectId: "little-momo-9fbc2",
      storageBucket: "little-momo-9fbc2.firebasestorage.app",
      messagingSenderId: "774889290546",
      appId: "1:774889290546:web:6eec31c312a23a223f352b",
        measurementId: "G-HPK766EVR9"
    ),
  );

  runApp(const AdminPanelApp());
}

class AdminPanelApp extends StatelessWidget {
  const AdminPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/dashboard': (context) => AdminDashboard(),
      },
    );

  }
}
