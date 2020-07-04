

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sellusedstuff/home_screen.dart';
import 'file:///D:/n/sell_used_stuff/lib/pages/home_page.dart';
import 'package:sellusedstuff/utils/screen_size.dart';
import 'package:sellusedstuff/utils/shared_widget.dart';
import 'package:sellusedstuff/utils/show_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../constant.dart';
import 'login_screen.dart';
import '../utils/mainTheme.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _ClientRegisterScreenState createState() => _ClientRegisterScreenState();
}

class _ClientRegisterScreenState extends State<RegisterScreen> {
  String email;
  String password;
  String passwordConfirm;
  TextEditingController _emailController = TextEditingController();
  FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  TextEditingController _passwordController = TextEditingController();

  TextEditingController _passwordConfirmController = TextEditingController();
  WidgetSize fontWidgetSize;
  SizeConfig sizeConfig;
  final _formKey = GlobalKey<FormState>();
  bool isEnabled =true;
  bool autoFormatValidator = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((sharedPref) {
      sharedPref.setBool('seen', true);
    });
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig = SizeConfig(context);
    fontWidgetSize = WidgetSize(sizeConfig);
    return Scaffold(
      appBar: appBar(context, 'Sign Up'),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color:Colors.blueAccent,
          child: Padding(
            padding: EdgeInsets.only(right: sizeConfig.screenWidth*0.03,left:sizeConfig.screenWidth*0.03,bottom:sizeConfig.screenHeight*0.05),
            child: Form(
              autovalidate: autoFormatValidator,
                key: _formKey,
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 75,
                    ),
                    TextFormField(
                      controller: _emailController,
                      enabled: isEnabled,
                      validator: (value){
                        if(value.isEmpty){
                            return "email is required ";
                        }
                        return null;
                      },
                      style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: fontWidgetSize.bodyFontSize),
                      decoration: InputDecoration(
                        icon: Icon(Icons.email,color: Colors.white,),
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: "Email",  ),
                    ),
                    TextFormField(
                      enabled: isEnabled,
                      controller: _passwordController,
                      validator: (value){
                        if(value.isEmpty){
                          return "password is required ";
                        }
                        return null;
                      },
                      obscureText: true,
                      style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: fontWidgetSize.bodyFontSize),
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock,color: Colors.white,),
                        hintText: "password", hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      enabled: isEnabled,
                      controller: _passwordConfirmController,
                      validator: (value){

                        if(value.isEmpty){
                          return "password confirm is required ";
                        }
                        else if (value != _passwordController.text){
                          return "password confirm not match ";
                        }
                        return null;

                      }


                      ,
                      style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: fontWidgetSize.bodyFontSize),
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock,color: Colors.white,),
                        hintText: "confirm password",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    registerButton(context, 'Sign Up',signUpMethod,isEnabled),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already Member?',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: fontWidgetSize.bodyFontSize - 2,
                                fontFamily: 'SFPro'),
                          ),
                          Padding(padding: EdgeInsets.only(right: 5)),
                          FlatButton(
                            child: Text(
                              'SignIn',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontWidgetSize.bodyFontSize,
                                  fontFamily: 'SFPro'),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(    MaterialPageRoute(builder: (context) {
                                    return LoginScreen();
                                  }));
                            },
                          )
                        ],
                      ),
                    ),

                  ],
                )),
          ),
        ),
      ),
    );
  }
  void signUpMethod()async{
    userAccountDetails();
        if(isEnabled){
          if(_formKey.currentState.validate()){
            setState(() {
              autoFormatValidator=true;
              isEnabled=false;
              callFirebaseToSignUp();
            });
          }
        }
  }
  void callFirebaseToSignUp()async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
      _firebaseAuth.createUserWithEmailAndPassword(email: email , password:password).then((value) {
        if(value.user!=null){
          sharedPreferences.setString(Constant.Kuser_id ,value.user.uid);

          Firestore.instance.collection("profiles").document().setData(
              {
                Constant.Kuser_id : value.user.uid,
                "email":email,
                "name":email.substring(0,4)

              }).then((value) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
              return HomeScreen();
            }   ));
          }
          ).catchError((onError){    print(onError.toString());});  }
      }
      ).catchError((onError){
        String l =onError.toString().split(",")[1];
        showMyDialog('Register Failed !',l,context);
        setState(() {
          isEnabled=true;
        });
      });
  }
  void userAccountDetails(){
    email=_emailController.text.trim();
    password=_passwordController.text.trim();
    passwordConfirm = _passwordConfirmController.text.trim();
  }



}
