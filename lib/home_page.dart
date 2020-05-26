import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sellusedstuff/auth_screen/login_screen.dart';
import 'package:sellusedstuff/utils/mainTheme.dart';
import 'package:sellusedstuff/utils/screen_size.dart';
import 'package:sellusedstuff/utils/shared_widget.dart';

import 'model/Product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 // TabController tabController = TabController(length: null, vsync: null);
  PageController _pageController;




List<Product> pr =[
 Product("https://sslimages.shoppersstop.com/sys-master/root/h19/h80/14520642863134/0020_SS_High_waisted_fashion_How_can_men_style_this_trend_Featured-image.jpg","firstImage"),
 Product("https://i.pinimg.com/originals/0e/fe/64/0efe64037fecefddb409d338f9d2f0bc.jpg","secondImage"),
 Product("https://sslimages.shoppersstop.com/sys-master/root/h19/h80/14520642863134/0020_SS_High_waisted_fashion_How_can_men_style_this_trend_Featured-image.jpg","firstImage"),
 Product("https://i.pinimg.com/originals/0e/fe/64/0efe64037fecefddb409d338f9d2f0bc.jpg","secondImage"),
];
int currentIndex=1;


@override
void initState(){
  super.initState();
  _pageController=PageController(initialPage: 1,viewportFraction:.65);
}
//hada howa lmachro3 illi ba3ml 3alih


//todo String Tag  must change to Products Model
List<Product> _randomTopProducts(List<Product> products){
List<int> indexes =[];
Random random=Random();
int counter =3;
//todo String Tag  must change to Products Model
List<Product> newProducts =[];
do{
  int rnd =random.nextInt(products.length);
  if(!indexes.contains(rnd)){
    indexes.add(rnd);
  }
  counter--;
}while(counter!=0);
for (int index in indexes){
  newProducts.add(products[index]);
}
return newProducts;
}
  Widget _drawProducts(BuildContext context,List<Product> products){
  //todo  make random carousel images products
 List<Product> _products=_randomTopProducts(products);
    return Container(

      child: Column(
        children: <Widget>[
         Flexible(
         child:SizedBox(
           height: sizeConfig.screenHeight*.3,
           child: PageView.builder(
             onPageChanged: (int index){
               setState(() {
                 currentIndex =index;
               });
             },
             controller: _pageController,
             itemCount: products.length,
           scrollDirection: Axis.horizontal,
           itemBuilder: (context,position){
          return Card(
         clipBehavior: Clip.hardEdge,
         shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
           child: Container(
             child: Image(
               fit: BoxFit.cover,
               image: NetworkImage(products[position].imagePath)
             ),

           ),
       );

     }),
         )
   ),
          Container(
            child:Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.center,children:  _pageViewDots(products.length,context),),
            )
          )
        ],
      ),
    );
  }
  WidgetSize fontWidgetSize ;
  SizeConfig sizeConfig;
  @override
  Widget build(BuildContext context) {
    sizeConfig=SizeConfig(context);
    fontWidgetSize=WidgetSize(sizeConfig);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Mohamed Bardouni"),
              accountEmail: Text("mbardouni44@gmail.com"),
              currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                      "https://cdn2.f-cdn.com/ppic/140047602/logo/41720176/nTxdl/profile_logo_.jpeg")),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return LoginScreen();
                }));
              },
              leading: Icon(
                Icons.supervised_user_circle,
                color: Colors.blue,
              ),
              title: Text(
                "Account",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return LoginScreen();
                }));
              },
              leading: Icon(
                Icons.search,
                color: Colors.blue,
              ),
              title: Text(
                "search",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.message,
                color: Colors.blue,
              ),
              title: Text(
                "messages",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.star,
                color: Colors.blue,
              ),
              title: Text(
                "Favourite",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.blue,
              ),
              title: Text(
                "about",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.blue,
              ),
              title: Text(
                "Settings",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: sizeConfig.screenHeight,
        color: Color(0xFFEDEDED),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _drawProducts(context,pr),
            )
          ],
        ),
      ),
      appBar: AppBar(
        actionsIconTheme: IconThemeData(color:  mainTheme.primaryColorDark,size: 35),
        iconTheme: IconThemeData(color:   mainTheme.primaryColorDark, size: 35),

        title:Text("Home",style: TextStyle( color: mainTheme.primaryColorDark,fontWeight: FontWeight.bold)),
        backgroundColor:mainTheme.primaryColorLight,
        elevation: 0,
        actions: <Widget>[
          Icon(
            Icons.search,
            color: mainTheme.primaryColorDark,
            size: 30,
          ),
          Icon(
            Icons.notifications,
            color: mainTheme.primaryColorDark,
            size: 30,
          ),
        ],
        centerTitle: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: mainTheme.primaryColorDark,
        height:sizeConfig.screenHeight*.085,
        backgroundColor:mainTheme.primaryColorLight,
        onTap: (value) {
          setState(() {
            //    currentIndex =value;
            //    print(currentIndex);
          });
        },
        items: <Widget>[
          Icon(
            Icons.home,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.directions,
            color: Colors.white,
            size: 25,
          ),
          Icon(
            FontAwesomeIcons.camera,
            color: Colors.white,
            size: 25,
          ),
          Icon(
            FontAwesomeIcons.user,
            color: Colors.white,
            size: 25,
          ),
          Icon(
            Icons.linear_scale,
            color: Colors.white,
            size: 30,
          )
        ],
      ),
    );
  }

  List<Widget> _pageViewDots(int qty, BuildContext context) {
 List<Widget> widgets =[];
 for(int i =0;i<qty;i++){
   widgets.add(
     Container(
     decoration: BoxDecoration(
       color:( i==currentIndex)?
         mainTheme.primaryColorDark:
           Colors.grey[400] ,
       borderRadius: BorderRadius.circular(5)
     ),
       width: 10,height: 10,
       margin: (i==qty-1)?EdgeInsets.only(right: 0):EdgeInsets.only(right: 24)
     )
   );
 }
return widgets;
  }
}
