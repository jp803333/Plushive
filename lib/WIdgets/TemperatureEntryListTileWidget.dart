
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TemperatureEntryListTileWidget extends StatelessWidget {
  const TemperatureEntryListTileWidget({
    Key key,
    @required this.width,
    @required this.height,
    @required this.doc,
  }) : super(key: key);

  final double width;
  final double height;
  final QueryDocumentSnapshot doc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        width: width,
        height: height * 0.1,
        // color: Colors.purple[50],
        color: Colors.green[50],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: height * 0.05,
              // backgroundColor: Colors.purple,
              backgroundColor: Colors.green,
              child: Container(
                height: height * 0.05,
                width: height * 0.05,
                child: Center(
                  child: Text(
                    doc['temperature'].toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            CircleAvatar(
              radius: 12,
              // backgroundColor: Colors.purple[700],
              backgroundColor: Colors.green[700],
              child: Center(
                child: Text(
                  '°C',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Created on: ",
                    style: TextStyle(
                        // color: Colors.purple,
                        color: Colors.green),
                    children: [
                      TextSpan(
                        text: DateFormat('jm')
                            .format(DateTime.fromMillisecondsSinceEpoch(
                              doc['createdAt'].millisecondsSinceEpoch,
                            ).toLocal())
                            .toString(),
                        style: TextStyle(
                            fontSize: 24,
                            // color: Colors.purple[600],
                            color: Colors.green[800]),
                      )
                    ],
                  ),
                ),
                Text(
                  DateFormat('d EEEE, MMMM y')
                      .format(DateTime.fromMillisecondsSinceEpoch(
                        doc['createdAt'].millisecondsSinceEpoch,
                      ).toLocal())
                      .toString(),
                  style: TextStyle(
                    // color: Colors.purple[600],
                    color: Colors.green[800],
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
