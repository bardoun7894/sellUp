import 'package:flutter/material.dart';
import 'package:sellusedstuff/utils/screen_size.dart';
import 'package:sellusedstuff/utils/shared_widget.dart';
import 'package:sellusedstuff/utils/welcome.dart';

import 'auth_screen/register_screen.dart';
import 'mainTheme.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  WidgetSize fontWidgetSize ;
  SizeConfig sizeConfig;
  final _formKey =GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {

    sizeConfig=SizeConfig(context);
    fontWidgetSize=WidgetSize(sizeConfig);
    print(sizeConfig.screenHeight);

    print(sizeConfig.screenWidth);
    return Scaffold(

      appBar: appBar(context,'Sign In'),

      body: Padding(
        padding:   EdgeInsets.only(right: sizeConfig.screenWidth*0.03,left:sizeConfig.screenWidth*0.03,bottom:sizeConfig.screenHeight*0.18,top:sizeConfig.screenHeight*0.15),
        child: Form(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              TextFormField(
                style: TextStyle(fontFamily:'SFPro',fontSize: fontWidgetSize.bodyFontSize ),
                decoration: InputDecoration(
                  hintText: "email",
                ),
              ),
              TextFormField(
                style:TextStyle(fontFamily:'SFPro',fontSize: fontWidgetSize.bodyFontSize ),
                decoration: InputDecoration(
                  hintText: "password",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                      padding:EdgeInsets.zero,
                      onPressed: (){
                      }, child: Text("Forget Password",  style: TextStyle(color: Colors.white,fontSize: fontWidgetSize.bodyFontSize-2,fontFamily: 'SFPro'),
                  ))
                ],
              )
              , registerButton(context, 'Sign In',signInMethod),
              or(context),
              Text("Sign in with",style: TextStyle(fontWeight: FontWeight.bold),),

              registerButton(context, 'Sign Up',signUpMethod)
            ],),
          key: _formKey,
        ),
      ),
    );
  }
  void signInMethod(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return WelcomePage();
    }));
  }
  void signUpMethod(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return ClientRegisterScreen();
    }));
  }
}