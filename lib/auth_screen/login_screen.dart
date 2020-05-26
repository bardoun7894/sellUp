import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sellusedstuff/utils/screen_size.dart';
import 'package:sellusedstuff/utils/shared_widget.dart';
import 'package:sellusedstuff/utils/welcome.dart';

import 'register_screen.dart';
import '../utils/mainTheme.dart';

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

    return Scaffold(

      appBar: appBar(context,'Sign In'),

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.blueAccent,
          child: Padding(
            padding:   EdgeInsets.only(right: sizeConfig.screenWidth*0.03,left:sizeConfig.screenWidth*0.03,bottom:sizeConfig.screenHeight*0.18,top:sizeConfig.screenHeight*0.15),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    style: TextStyle(fontFamily:'SFPro',fontSize: fontWidgetSize.bodyFontSize,color:Colors.white ),
                    decoration: InputDecoration(
                        icon: Icon(Icons.email,color: Colors.white,),
                      hintText: "email",
                      hintStyle: TextStyle(color: Colors.white)
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    style:TextStyle(fontFamily:'SFPro',fontSize: fontWidgetSize.bodyFontSize,color: Colors.white ),
                    decoration: InputDecoration(   icon: Icon(Icons.lock,color: Colors.white,),

                      hintText: "password",  hintStyle: TextStyle(color: Colors.white)
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                          padding:EdgeInsets.zero,
                          onPressed: (){
                          }, child: Text("Forget Password",
                        style: TextStyle(color: Colors.white,fontSize:
                        fontWidgetSize.bodyFontSize-2,fontFamily: 'SFPro'),
                      ))
                    ],
                  )
                  , registerButton(context, 'Sign In',signInMethod),
                  SizedBox(height: 10,),
                  or(context),
                  SizedBox(height: 10,),
                  Text("Sign in with",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                  SizedBox(height: 10,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[

                       CircleAvatar(child: Icon(FontAwesomeIcons.facebookF,color: Colors.blueAccent,),backgroundColor: Colors.white,),
                       SizedBox(width: 10,),
                       CircleAvatar(child:Image.asset("assets/google_96px.png",width: 30)
                         ,backgroundColor: Colors.white,)
                     ],
                   ),
                  Padding(
                    padding: EdgeInsets.only(top: 70),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
            Text("Don't have an Account ?",style:TextStyle(color: Colors.white,
                fontWeight: FontWeight.normal)),
                     FlatButton(

                       padding:EdgeInsets.zero,child:
                     Text("SignUp",style:
                     TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:16),),
                       onPressed: () {
                        signUpMethod();
                       },),
                   ],
                  )
                ],),
              key: _formKey,
            ),
          ),
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
      return RegisterScreen();
    }));
  }
}