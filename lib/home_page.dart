import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      //   key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(accountName: Text("Mohamed Bardouni"), accountEmail: Text("mbardouni44@gmail.com"),
              currentAccountPicture:
              ClipRRect(borderRadius: BorderRadius.circular(40),child: Image.network("https://cdn2.f-cdn.com/ppic/140047602/logo/41720176/nTxdl/profile_logo_.jpeg")),
            ),
            ListTile(
              leading: Icon(Icons.home,color: Colors.blue,),
              title: Text("Start",style: TextStyle(color: Colors.blue),),
            ), ListTile(
              leading: Icon(Icons.search,color: Colors.blue,),
              title: Text("search",style: TextStyle(color: Colors.blue),),
            ), ListTile(
              leading: Icon(Icons.message,color: Colors.blue,),
              title: Text("messages",style: TextStyle(color: Colors.blue),),
            ), ListTile(
              leading: Icon(Icons.star,color: Colors.blue,),
              title: Text("Favourite",style: TextStyle(color: Colors.blue),),
            ), ListTile(
              leading: Icon(Icons.info,color: Colors.blue,),
              title: Text("about",style: TextStyle(color: Colors.blue),),
            ), ListTile(
              leading: Icon(Icons.settings,color: Colors.blue,),
              title: Text("Settings",style: TextStyle(color: Colors.blue),),
            ),
          ],

        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFEDEDED),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Card(
                borderOnForeground: true,
                clipBehavior:  Clip.antiAlias,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)
                  ),

                  height: 200,

                ),
              ),
            )


          ],
        ),
      ),
      appBar: AppBar(
        actionsIconTheme:  IconThemeData(color: Colors.blue[700],size: 35),
        iconTheme:  IconThemeData(color: Color(0xff383840),size: 35),
        title: Icon(FontAwesomeIcons.shoppingBag,color: Colors.blueAccent,),
        backgroundColor:Color(0xFFEDEDED),
        elevation: 0,
        actions: <Widget>[Icon(Icons.notifications,color: Colors.blueAccent,size: 30,)],
        centerTitle: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue[400],
        height: 55.0,
        backgroundColor:Color(0xFFEDEDED),
        onTap:(value){
          setState(() {
            //    currentIndex =value;
            //    print(currentIndex);
          });
        },
        items: <Widget>[
          Icon(Icons.home,color: Colors.white, size: 30,),
          Icon(Icons.directions,color: Colors.white ,size: 25,),
          Icon(FontAwesomeIcons.camera,color: Colors.white ,size: 25,),
          Icon(FontAwesomeIcons.user,color: Colors.white ,size: 25,),
          Icon(Icons.linear_scale,color: Colors.white, size: 30,)
        ],
      ),
    );
  }
}
