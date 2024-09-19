import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reflectable/reflectable.dart';

class AtDropdownField extends StatefulWidget {

  final String label;
  List<Paddock>? initialPaddocks;
  Function(Paddock? paddock) onChanged;

  final TextStyle? labelStyle;

  AtDropdownField(
      { this.label="", this.initialPaddocks, required this.onChanged, this.labelStyle})
  ;
  @override
  State<AtDropdownField> createState() => _AtDropdownFieldState( this.label, this.initialPaddocks??[], this.onChanged, this.labelStyle);
}

class _AtDropdownFieldState extends State<AtDropdownField> {

  final String label;
  List<Paddock> initialPaddocks;
  Function(Paddock? paddock) onChanged;
  final TextStyle? labelStyle;
  TextEditingController? controller;

  _AtDropdownFieldState(
      this.label, this.initialPaddocks, this.onChanged, this.labelStyle)
  ;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Paddock>(
      //initialSelection: ColorLabel.green,
      controller: controller,
      // requestFocusOnTap is enabled/disabled by platforms when it is null.
      // On mobile platforms, this is false by default. Setting this to true will
      // trigger focus request on the text field and virtual keyboard will appear
      // afterward. On desktop platforms however, this defaults to true.
      requestFocusOnTap: true,
      label:  Text(this.label),
      onSelected: onChanged,
      dropdownMenuEntries: initialPaddocks
          .map<DropdownMenuEntry<Paddock>>(
              (Paddock item) {
            return DropdownMenuEntry<Paddock>(
              value: item,
              label: item.name,
              enabled: true,

            );
          }).toList(),
    );

  }
}