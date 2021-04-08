import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonDrawer extends StatelessWidget {
  final Icon iconButton;
  final Color buttonColor, labelColor;
  final String labelButton;
  final VoidCallback onPressed;

  const ButtonDrawer({
    Key key,
    @required this.iconButton,
    @required this.labelButton,
    @required this.onPressed,
    @required this.buttonColor,
    @required this.labelColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoButton(
        color: buttonColor,
        padding: EdgeInsets.all(4),
        onPressed: onPressed,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              iconButton,
              (labelButton != '')
                  ? Container(
                      padding: EdgeInsets.all(13),
                      child: Text(
                        labelButton,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: labelColor,
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
