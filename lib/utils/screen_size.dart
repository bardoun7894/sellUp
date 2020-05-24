
import 'package:flutter/cupertino.dart';

enum  ScreenType {
  SMALL ,MEDUIM,LARGE,XLARGE
}

class SizeConfig{
  ScreenType screenType;
  BuildContext context;
  double screenWidth;
  double screenHeight;

  SizeConfig(BuildContext context){

    this.screenHeight=MediaQuery.of(context).size.height;
    this.screenWidth=MediaQuery.of(context).size.width;
  }

  void _setScreen(){

    if(this.screenWidth >= 320 && this.screenWidth <375){
      this.screenType =ScreenType.SMALL;
    }
    if(this.screenWidth >= 375 && this.screenWidth <414){
      this.screenType =ScreenType.MEDUIM;
    }
    if(this.screenWidth >=414 ){
      this.screenType =ScreenType.LARGE;
    }
  }

}
class WidgetSize{

  double titleFontSize;
  double bodyFontSize;
  SizeConfig sizeConfig;
  WidgetSize(SizeConfig sizeConfig){
    this.sizeConfig=sizeConfig;
    _init();
  }

  void _init() {
    switch(this.sizeConfig.screenType){
      case ScreenType.LARGE:
        titleFontSize = 16;
        bodyFontSize = 14;
        break;
      case ScreenType.SMALL:
        titleFontSize = 28;
        bodyFontSize = 20;
        break;
      case ScreenType.MEDUIM:
        titleFontSize = 28;
        bodyFontSize = 20;
        break;
      case ScreenType.XLARGE:
        titleFontSize = 28;
        bodyFontSize = 20;
        break;
      default:
        titleFontSize = 24;
        bodyFontSize = 17;
        break;
    }
  }
}