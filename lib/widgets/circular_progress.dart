import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(
        //valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        backgroundColor: Colors.red,
        strokeWidth: 8,
      ),
    );
  }
}
