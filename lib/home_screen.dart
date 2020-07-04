import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sellusedstuff/pages/add_product.dart';
import 'package:sellusedstuff/utils/mainTheme.dart';
import 'package:sellusedstuff/utils/screen_size.dart';

import 'pages/home_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  WidgetSize fontWidgetSize;
  SizeConfig sizeConfig;
  List _childreens=[
    HomePage(),
    AddProduct(),
  ];
  @override
  Widget build(BuildContext context) {
    sizeConfig = SizeConfig(context);
    fontWidgetSize = WidgetSize(sizeConfig);
    return Scaffold(
      body: _childreens[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: mainTheme.primaryColorDark,
        height: sizeConfig.screenHeight * .07,
        backgroundColor: mainTheme.primaryColorLight,
        onTap: (value) {
          setState((){
            currentIndex = value ;

            print(currentIndex);
                      });
                       },
        items: <Widget>[
          Icon(
            Icons.home,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.directions,
            color: Colors.white,
            size: 25,
          ),
//          Icon(
//            FontAwesomeIcons.camera,
//            color: Colors.white,
//            size: 25,
//          ),
//          Icon(
//            FontAwesomeIcons.user,
//            color: Colors.white,
//            size: 25,
//          ),
//          Icon(
//            Icons.linear_scale,
//            color: Colors.white,
//            size: 30,
//          )
        ],
      ),
    );
  }
}
