import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ATCheckboxField extends StatefulWidget {

  final String label;
  final bool value;
  Function(bool value) onChanged;

  final TextStyle? labelStyle;

  ATCheckboxField(
      { this.label="", this.value=false, required this.onChanged, this.labelStyle})
  ;
  @override
  State<ATCheckboxField> createState() => _ATCheckboxFieldState( this.label, this.value, this.onChanged, this.labelStyle);
}

class _ATCheckboxFieldState extends State<ATCheckboxField> {

  final String label;
   bool value;

  Function(bool value) onChanged;
  final TextStyle? labelStyle;

  _ATCheckboxFieldState(
      this.label, this.value, this.onChanged, this.labelStyle)
      ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
       child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: this.value,
                onChanged: (bool? newValue) {
                  setState(() {
                    this.value = newValue??false ;
                    this.onChanged(this.value);
                  });

                },
            ),//activeColor: Colors.lightGreenAccent),
            Text(label, style: labelStyle),
          ],
        ),
      ),
    );
  }
}