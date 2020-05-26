import 'package:flutter/material.dart';
import 'package:sellusedstuff/utils/screen_size.dart';
import 'package:sellusedstuff/utils/shared_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _passwordConfirmController = TextEditingController();
  WidgetSize fontWidgetSize;
  SizeConfig sizeConfig;
  final _formKey = GlobalKey<FormState>();

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
                key: _formKey,
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 75,
                    ),
                    TextFormField(
                      style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: fontWidgetSize.bodyFontSize),
                      decoration: InputDecoration(
                        icon: Icon(Icons.email,color: Colors.white,),
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: "Email",  ),
                    ),
                    TextFormField(
                      style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: fontWidgetSize.bodyFontSize),
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock,color: Colors.white,),
                        hintText: "password", hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: fontWidgetSize.bodyFontSize),
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock,color: Colors.white,),
                        hintText: "confirm password",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    registerButton(context, 'Sign Up',signUpMethod),
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
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
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
  void signUpMethod(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }



}
