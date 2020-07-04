import 'package:flutter/material.dart';

Widget error(String message){
  return Center(child: Text(message,style: TextStyle(color: Colors.red),));
}
Widget loading(){
  return Center(child: CircularProgressIndicator());
}