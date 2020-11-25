import 'package:flutter/material.dart';

class CustomTextInputFieldWidget extends StatelessWidget {
  CustomTextInputFieldWidget({
    Key key,
    @required TextEditingController tempInputTextFieldController,
    @required this.isTemperatureTextFieldEmpty,
    @required this.isNotANumber,
  })  : _tempInputTextFieldController = tempInputTextFieldController,
        super(key: key);

  final TextEditingController _tempInputTextFieldController;
  final bool isTemperatureTextFieldEmpty;
  final bool isNotANumber;

  final OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(4),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: _tempInputTextFieldController,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          errorText: isTemperatureTextFieldEmpty
              ? 'Cant be empty'
              : isNotANumber
                  ? 'Should be a number'
                  : null,
          // fillColor: Colors.purple[200],
          fillColor: Colors.green[200],
          isDense: true,
          filled: true,
          hintText: '37 °C',
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          border: textFieldBorder,
          focusedBorder: textFieldBorder,
        ),
      ),
    );
  }
}
