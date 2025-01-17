import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class _InputRegisterState extends State<InputRegister> {
class InputRegister extends StatelessWidget {
  final String placeholder;
  final double placeholderSize;
  final controllerFunct;
  final onchangeInput;
  final String defaultValue;
  final bool enabled;

  const InputRegister({
    @required this.placeholder,
    @required this.placeholderSize,
    this.controllerFunct,
    this.onchangeInput,
    this.defaultValue,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      // height: 46,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(5, 5),
          )
        ],
      ),
      child: TextFormField(
        initialValue: defaultValue ?? '',
        style: TextStyle(
          fontSize: placeholderSize,
          color: Colors.black,
        ),
        // controller: controllerFunct,
        enabled: enabled ?? true,
        // autofocus: true,
        onChanged: onchangeInput,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: placeholder,
        ),
      ),
    );
  }
}
