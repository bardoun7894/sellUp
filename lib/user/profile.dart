import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sellusedstuff/auth_screen/login_screen.dart';
import 'package:sellusedstuff/constant.dart';
import 'package:sellusedstuff/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
String userID;
bool isReady=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 SharedPreferences.getInstance().then((value){
  setState(() {
    userID = value.get(Constant.Kuser_id);
    isReady=true;
     });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body:isReady? StreamBuilder(
        stream: Firestore.instance.collection("profiles").where(Constant.Kuser_id,isEqualTo:userID).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
         return   error("no Connection is made ");
              break;
            case ConnectionState.waiting:
              return loading();
              break;
            case ConnectionState.active:
            case ConnectionState.done:
                if(snapshot.hasError){
                return  error(snapshot.error.toString());
                   }
                if(!snapshot.hasData){
                  return error("no has data");
                }
               return profileForm(snapshot);
                 break;
            default:
            return error("Nothing is Here ");
              break;
          }
        },
      ):loading(),
    );
  }
  Widget loading(){
    return Center(child: CircularProgressIndicator());
  }

  Widget error(String message){
    return Center(child: Text(message,style: TextStyle(color: Colors.red),));
  }
  Widget profileForm(AsyncSnapshot<QuerySnapshot> data) {
    if (data.data.documents.length == 0 || data.data.documents == null) {
      return error("no Data");
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: ListView(
        children: <Widget>[
               ListTile(
                 title: Text(data.data.documents[0]['name']),
                 trailing: Icon(Icons.arrow_forward_ios),
                 leading:Icon(Icons.person),
               ),
            ListTile(
                 title: Text(data.data.documents[0][Constant.Kuser_id]),
                 trailing: Icon(Icons.arrow_forward_ios),
                 leading:Icon(Icons.email),
                      ),
               ListTile(
                 title: Text("***********"),
                 trailing: Icon(Icons.arrow_forward_ios),
                 leading:Icon(Icons.lock),
                    ) ,
                 FlatButton(onPressed: () async{
                   SharedPreferences shared =await SharedPreferences.getInstance();
                   setState(() {
                     shared.setString(Constant.Kuser_id, "");
                     FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) {   return HomePage();  }));
                     userID="";
                   });
                 },child: Text("LOGOUT"),)

],
            )
        ),
      );
    }
  }
}
