import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plushvieassignment/WIdgets/CustomDIalog.dart';
import 'package:plushvieassignment/WIdgets/TemperatureEntryListTileWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // creating a key for main homescreen scaffold to show snackbars
  final _mainScaffold = GlobalKey<ScaffoldState>();

  // retrieving a collection reference to actively listen to it in streambuilder which
  // actively check for new update to the collection
  CollectionReference listOfBodyTemperature =
      FirebaseFirestore.instance.collection('Body Temperature');

  @override
  Widget build(BuildContext context) {
    // getting size of the screen
    Size size = MediaQuery.of(context).size;
    double height = size.height, width = size.width;

    return Scaffold(
      key: _mainScaffold,
      appBar: AppBar(
        title: Text(
          'Plusive Assignment',
          style: TextStyle(
              // color: Colors.purple[800],
              color: Colors.green[800]),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          // Stream builder which takes the collection reference and using the stream on querysnapshot
          // builds a new list of the temperatues added

          child: StreamBuilder<QuerySnapshot>(
            stream:
                // sorting the data according to the created time and date
                listOfBodyTemperature
                    .orderBy('createdAt', descending: true)
                    .get()
                    .asStream(),
            // actual building on data
            builder: (context, snapshot) {
              // if the snapshot have error a text widget is returned showing error
              if (snapshot.hasError) {
                return Text(snapshot.error);
              }

              // loading circle if the data is still loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: width,
                  height: height * 0.5,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              // if every thing is correct then returns the list of the temperature entries
              return Column(
                children: snapshot.data.docs
                    .map(
                      (doc) => TemperatureEntryListTileWidget(
                        doc: doc,
                        width: width,
                        height: height,
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // backgroundColor: Colors.purple,
        backgroundColor: Colors.green,
        onPressed: () async {
          // calling custom dialog box
          bool result = await showDialog(
            context: context,
            builder: (context) => CustomDialog(height: height),
          );

          // showing snackbar according to the return of custom dialog
          result
              ? _mainScaffold.currentState.showSnackBar(SnackBar(
                  content: Text('Success'),
                ))
              : _mainScaffold.currentState.showSnackBar(SnackBar(
                  content: Text('Error'),
                ));
        },
      ),
    );
  }
}
