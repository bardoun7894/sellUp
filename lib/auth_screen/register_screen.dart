import 'package:flutter/material.dart';
import 'package:sellusedstuff/utils/screen_size.dart';
import 'package:sellusedstuff/utils/shared_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../login_screen.dart';
import '../mainTheme.dart';

class ClientRegisterScreen extends StatefulWidget {
  @override
  _ClientRegisterScreenState createState() => _ClientRegisterScreenState();
}

class _ClientRegisterScreenState extends State<ClientRegisterScreen> {
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
      body: Padding(
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
                    hintText: "email",
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: fontWidgetSize.bodyFontSize),
                  decoration: InputDecoration(
                    hintText: "password",
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: fontWidgetSize.bodyFontSize),
                  decoration: InputDecoration(
                    hintText: "confirm password",
                  ),
                ),
                registerButton(context, 'Sign Up',signUpMethod),
                Center(
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Already Member?',
                        style: TextStyle(
                            color: Color(0xFF8A8A8A),
                            fontSize: fontWidgetSize.bodyFontSize - 2,
                            fontFamily: 'SFPro'),
                      ),
                      Padding(padding: EdgeInsets.only(right: 5)),
                      FlatButton(
                        child: Text(
                          'SignIn',
                          style: TextStyle(
                              color: mainTheme.primaryColorDark,
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
                or(context),

              ],
            )),
      ),
    );
  }
  void signUpMethod(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }



}
