import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plushvieassignment/HomeScreen.dart';


// Basic login screen
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.green[400],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(5, 5),
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              // SizedBox(height: 16),
              FlatButton(
                color: Colors.green[700],
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () {
                  FirebaseAuth.instance
                      .signInAnonymously()
                      .then(
                        (value) => {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          ),
                        },
                      )
                      .catchError(
                        (onError) => showDialog(
                          context: context,
                          barrierColor: Colors.grey[400].withOpacity(0.1),
                          builder: (context) => AlertDialog(
                            title: Text('Error'),
                            content: onError,
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('cancel')),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('ok'))
                            ],
                          ),
                        ),
                      );
                },
                child: Text(
                  'Login anonymous',
                  style: TextStyle(
                    // color: Colors.grey,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
