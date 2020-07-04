import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sellusedstuff/constant.dart';
import 'package:sellusedstuff/home_screen.dart';
import 'package:sellusedstuff/utils/screen_size.dart';
import 'package:sellusedstuff/utils/shared_widget.dart';
import 'package:sellusedstuff/utils/show_dialog.dart';
import 'package:sellusedstuff/utils/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/home_page.dart';
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
  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isEnabled= true;

  bool autoFormatValidator =false;
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
            padding : EdgeInsets.only(right: sizeConfig.screenWidth*0.03,left:sizeConfig.screenWidth*0.03,bottom:sizeConfig.screenHeight*0.18,top:sizeConfig.screenHeight*0.15),
            child: Form(
                autovalidate: autoFormatValidator,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    enabled: isEnabled,
                    validator: (value){
                      if(value.isEmpty){
                        return "email is required ";
                      }
                      return null;
                    },
                    style: TextStyle(fontFamily:'SFPro',fontSize: fontWidgetSize.bodyFontSize,color:Colors.white ),
                    decoration: InputDecoration(
                        icon: Icon(Icons.email,color: Colors.white,),
                      hintText: "email",
                      hintStyle: TextStyle(color: Colors.white)
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    enabled: isEnabled,
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value){
                      if(value.isEmpty){
                        return "password is required ";
                      }
                      return null;
                    },
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
                  )     ,
                  registerButton(context, 'Sign In',signInMethod,isEnabled),
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


  void signInMethod() {
    userAccountDetails();
    if(isEnabled){
      if(_formKey.currentState.validate()){
        setState(() {
          autoFormatValidator=true;
          isEnabled=false;
          callFirebaseToSignIn();
        });
      }
    }
  }

  void callFirebaseToSignIn()async {
SharedPreferences shared =await SharedPreferences.getInstance();

   _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value) {
     String userId = value.user.uid;
     shared.setString(Constant.Kuser_id,userId);
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
       return HomeScreen();
     }));
   }).catchError((onError){
     String l =onError.toString().split(",")[1];
     showMyDialog('Login Failed !',"login faild please cheak again! ${l}", context);
     setState(() {
       isEnabled=true;
     });
   });
       }

  void userAccountDetails(){
    email=_emailController.text.trim();
    password=_passwordController.text.trim();
  }




  void signUpMethod(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return RegisterScreen();
    }));
  }
}