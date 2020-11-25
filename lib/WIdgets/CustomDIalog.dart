// Custom entery dialog box
import 'package:flutter/material.dart';
import 'package:plushvieassignment/AddTemp.dart';
import 'package:plushvieassignment/WIdgets/CustomTextInputFieldWidget.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog({
    Key key,
    @required this.height,
  }) : super(key: key);

  final double height;

  final TextEditingController _tempInputTextFieldController =
      TextEditingController();

  bool isTemperatureTextFieldEmpty = false;
  bool isNotANumber = false;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return SimpleDialog(
          title: Text('Add a new entry'),
          children: [
            CustomTextInputFieldWidget(
              tempInputTextFieldController: _tempInputTextFieldController,
              isTemperatureTextFieldEmpty: isTemperatureTextFieldEmpty,
              isNotANumber: isNotANumber,
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    height: height * 0.055,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  FlatButton(
                    height: height * 0.055,
                    onPressed: () {
                      // Main logic

                      // Validation on entry
                      if (_tempInputTextFieldController.text == '') {
                        setState(() {
                          isTemperatureTextFieldEmpty = true;
                        });
                      } else {
                        setState(() {
                          isTemperatureTextFieldEmpty = false;
                        });
                        try {
                          // to remove error label from textfield
                          setState(() {
                            isNotANumber = false;
                          });
                          // to check if the entered value is a number or not (throws error if not)
                          double temperature =
                              double.parse(_tempInputTextFieldController.text);

                          // Creating TemperatureEntry object
                          TemperatureEntry temperatureEntry =
                              TemperatureEntry(temperature);

                          //calling add to db function and performing task according to
                          // it return
                          temperatureEntry.addToDB().then((value) {
                            Navigator.of(context).pop(true);
                          }).catchError((err) {
                            Navigator.of(context).pop(false);
                          });
                        } catch (e) {
                          // to set error label to text field
                          setState(() {
                            isNotANumber = true;
                          });
                        }
                      }
                    },
                    // color: Colors.purple,
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
      },
    );
  }
}
