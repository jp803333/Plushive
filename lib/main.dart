import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plushvieassignment/HomeScreen.dart';
import 'package:plushvieassignment/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plusive Assignment',
      home:

          // Checks if user is logged in or not
          FirebaseAuth.instance.currentUser == null
              ?
              // if user is not logged in then redirects to login screen
              LoginScreen()
              :
              // if user is logged in then redirects to Home screen
              HomeScreen(),
    );
  }
}
