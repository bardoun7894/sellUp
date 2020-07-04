import 'package:flutter/material.dart';
import 'package:sellusedstuff/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_page.dart';
import 'auth_screen/login_screen.dart';
import 'utils/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool seen = sharedPreferences.getBool("seen");
  print(seen);
  Widget homeScreen = HomeScreen();
  if(seen == null || !seen){
    homeScreen = WelcomePage();
  }else{
    homeScreen = HomeScreen();
  }
  runApp(UseSell(homeScreen));
}
class UseSell extends StatelessWidget {
  Widget homeScreen;
  UseSell(this.homeScreen);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: this.homeScreen,
    );
  }
}
