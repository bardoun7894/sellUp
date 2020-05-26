import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'auth_screen/login_screen.dart';
import 'utils/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool seen = sharedPreferences.getBool("seen");
  Widget homeScreen = HomePage();
  if(seen ==null || !seen){
    homeScreen=WelcomePage();
  }else{
    String userId=sharedPreferences.getString('user_id');
    if(userId == null|| userId ==''){
      homeScreen=HomePage();

    }

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
