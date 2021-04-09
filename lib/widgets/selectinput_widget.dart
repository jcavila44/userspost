import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectWidget extends StatefulWidget {
  final onchangeInput;
  final selectedLocation;
  SelectWidget({Key key, @required this.onchangeInput, this.selectedLocation})
      : super(key: key);

  @override
  _SelectWidgetState createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  final List<String> _locations = ['Female', 'Male'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        alignment: Alignment.topLeft,
        width: MediaQuery.of(context).size.width * 0.9,
        height: 70,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(5, 5),
            )
          ],
        ),
        // dropdown below..
        child: DropdownButton(
          hint: Text(
            'Genero',
            style: TextStyle(fontSize: 25),
          ),
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 42,
          underline: SizedBox(),
          value: widget.selectedLocation,
          onChanged: widget.onchangeInput,
          // onChanged: (newValue) {
          //   setState(() {
          //     _selectedLocation = newValue;
          //   });
          // },
          items: _locations.map((location) {
            return DropdownMenuItem(
              value: location,
              child: Text(
                location,
                style: TextStyle(fontSize: 25),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
