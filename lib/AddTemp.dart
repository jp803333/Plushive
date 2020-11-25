import 'package:cloud_firestore/cloud_firestore.dart';

// class to enter the temperature in to cloud firestore
class TemperatureEntry {
  final double temperature;
  final Timestamp createdAt = Timestamp.fromDate(DateTime.now());

  TemperatureEntry(this.temperature);

  // function handling data entery to firestore
  Future<void> addToDB() {
    // retrieving the collection
    CollectionReference bodyTemperature =
        FirebaseFirestore.instance.collection('Body Temperature');

    // adding to the collection and throw error if any occurs
    return bodyTemperature.add({
      'temperature': temperature,
      'createdAt': createdAt,
    }).then((value) {
      print('success');
    }).catchError((onError) {
      throw onError;
    });
  }
}
