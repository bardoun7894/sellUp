import 'package:flutter/material.dart';
import 'package:sellusedstuff/utils/screen_size.dart';


import '../mainTheme.dart';
WidgetSize fontWidgetSize ;
SizeConfig sizeConfig;

Widget appBar(BuildContext context, title){

  sizeConfig=SizeConfig(context);
  fontWidgetSize=WidgetSize(sizeConfig);
  return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title:  Text(title, style: Theme.of(context)
            .textTheme
            .title
            .copyWith(color: Color(0xFF636363),fontSize: fontWidgetSize.titleFontSize),
        ),

  );
}
Widget divider(BuildContext context){

  return  Container(
    height: 1,
    color: Colors.grey.shade400,
  );
}

Widget registerButton(BuildContext context,title,onPressed) {
  return  Container(
    width: double.infinity,
    height: sizeConfig.screenHeight*.065,
    child: FlatButton(
        onPressed:onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        color: mainTheme.primaryColorDark,
        child: Text(title,
          style: TextStyle(
              fontFamily: 'SFPro',
              fontWeight: FontWeight.bold,
              fontSize: fontWidgetSize.bodyFontSize - 1,
              color: Colors.white),
        )),
  ) ;
}
Widget or(BuildContext context) {
  return Row(
    children: <Widget>[
      Flexible(child: divider(context)),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'OR',
          style: TextStyle( fontSize:fontWidgetSize.bodyFontSize-3,  fontFamily: 'SFPro',color: Color(0xFF8A8A8A)),
        ),
      ),
      Flexible(child: divider(context)),
    ],
  );
}