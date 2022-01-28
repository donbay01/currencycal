// ignore_for_file: use_function_type_syntax_for_parameters, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, avoid_types_as_parameter_names


import 'package:flutter/material.dart';

Widget customDropDown (List<String>? items, String? value, void onChange(val)){

  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text('Select a currency'),
          isExpanded: true,
          value: value,
          onChanged: (String? val){
            onChange(val);
          },
          items: items?.map(buildMenuItem).toList(),
        ),
      ),
  );
}
DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
      child: Text(
        item,
      ));