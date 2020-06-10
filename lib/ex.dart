import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sellusedstuff/auth_screen/login_screen.dart';
import 'package:sellusedstuff/constant.dart';
import 'package:sellusedstuff/user/profile.dart';
import 'package:sellusedstuff/utils/mainTheme.dart';
import 'package:sellusedstuff/utils/screen_size.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Categories/AutoWheel&Boot.dart';
import 'model/Product.dart';
import 'model/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TabController tabController = TabController(length: null, vsync: null);
  PageController _pageController;

  List<IconData> _icons = [
    FontAwesomeIcons.car,
    FontAwesomeIcons.home,
    FontAwesomeIcons.toolbox,
    FontAwesomeIcons.warehouse,
    FontAwesomeIcons.random,
    FontAwesomeIcons.car,
  ];
  List<Product> pr = [
    Product(
        imagePath: "https://sslimages.shoppersstop.com/sys-master/root/h19/h80/14520642863134/0020_SS_High_waisted_fashion_How_can_men_style_this_trend_Featured-image.jpg",
        nameProduct:"firstImage",
        priceProduct: 10.0
    ),
    Product(
        imagePath:"https://i.pinimg.com/originals/0e/fe/64/0efe64037fecefddb409d338f9d2f0bc.jpg",
        nameProduct: "secondImage",
        priceProduct: 20.0
    ),
    Product(
        imagePath: "https://sslimages.shoppersstop.com/sys-master/root/h19/h80/14520642863134/0020_SS_High_waisted_fashion_How_can_men_style_this_trend_Featured-image.jpg",
        nameProduct:"firstImage",
        priceProduct: 30.0),
    Product(
        imagePath:"https://i.pinimg.com/originals/0e/fe/64/0efe64037fecefddb409d338f9d2f0bc.jpg",
        nameProduct: "secondImage",
        priceProduct: 40.0
    ),
    Product(
        imagePath: "https://sslimages.shoppersstop.com/sys-master/root/h19/h80/14520642863134/0020_SS_High_waisted_fashion_How_can_men_style_this_trend_Featured-image.jpg",
        nameProduct:"firstImage",
        priceProduct: 10.0),
    Product(
        imagePath:"https://i.pinimg.com/originals/0e/fe/64/0efe64037fecefddb409d338f9d2f0bc.jpg",
        nameProduct: "secondImage",
        priceProduct: 10.0),

  ];
  int currentIndex = 1;
  String userID ="";

  bool isReady  =false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: .65);
    SharedPreferences.getInstance().then((value) {
      setState(() {
        isReady = true;
        userID = value.getString(Constant.Kuser_id);
        print("userID HOME"+userID);
      });

    });

  }

//todo String Tag  must change to Products Model
  List<Product> _randomTopProducts(List<Product> products) {
    List<int> indexes = [];
    Random random = Random();
    int counter = 5;
//todo String Tag  must change to Products Model
    List<Product> newProducts = [];
    do {
      int rnd = random.nextInt(products.length);
      if (!indexes.contains(rnd)) {
        indexes.add(rnd);
      }
      counter--;
    } while (counter != 0);
    for (int index in indexes) {
      newProducts.add(products[index]);
    }
    return newProducts;
  }

  Widget _drawCarousselProducts(BuildContext context, List<Product> products) {
    //todo  make random carousel images products
    List<Product> _products = _randomTopProducts(products);
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: sizeConfig.screenHeight * .20,
            child: PageView.builder(
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                controller: _pageController,
                itemCount: _products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, position) {
                  return Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Container(
                      child: Image(
                          fit: BoxFit.cover,
                          image:
                          NetworkImage(_products[position].imagePath)),
                    ),
                  );
                }),
          ),
          Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _pageViewDots(6 , context),
                ),
              )),
        ],
      ),
    );
  }

  Widget gridListProducts() {


    return GridView.builder(
        itemCount: pr.length,
        itemBuilder: (BuildContext context,int index){
          return Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Image(
                    height: 150,
                    width: 180,
                    fit: BoxFit.cover,
                    image: NetworkImage(pr[index].imagePath)

                ),
                Text(pr[index].nameProduct),
                Text("\$ ${pr[index].priceProduct} ",style: TextStyle(color: Colors.red)),

              ],
            ),);
        },
        physics: FixedExtentScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  crossAxisCount:  2 ));

//    return GridView.count(
//
//      physics: NeverScrollableScrollPhysics(),
//      shrinkWrap: true,
//     padding: EdgeInsets.only(top: 10) ,
//    crossAxisCount: 2 ,
//    children: List.generate(pr.length, (index) {
//      return Container(
//        child: Column(
//          children: <Widget>[
//            SizedBox(
//              height: 5,
//            ),
//            Image(
//                height: 150,
//                width: 180,
//                fit: BoxFit.cover,
//                image: NetworkImage(pr[index].imagePath)
//
//            ),
//            Text(pr[index].nameProduct),
//            Text("\$ ${pr[index].priceProduct} ",style: TextStyle(color: Colors.red)),
//
//          ],
//        ),
//      );
//    }),
//    );

  }

  WidgetSize fontWidgetSize;
  SizeConfig sizeConfig;


  Widget buildIcon(int index) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: mainTheme.accentColor),
      child: Icon(_icons[index], color: Colors.blue, size: 20),
    );
  }
  @override
  Widget build(BuildContext context) {

    sizeConfig = SizeConfig(context);
    fontWidgetSize = WidgetSize(sizeConfig);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            isReady==true ? StreamBuilder(
                stream:  Firestore.instance.collection("profiles").where( Constant.Kuser_id,isEqualTo:userID ).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                      profileFormInfo(snapshot);
                      break;
                    case ConnectionState.waiting:
                      return UserAccountsDrawerHeader(
                        accountName: Text(" No Account "),
                        accountEmail: Text("   "),
                        currentAccountPicture:
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person),
                        ),
                      );
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if(!snapshot.hasData){
                        return error("has no data");
                      }
                      if(snapshot.hasError){
                        return Text("erro");
                      }
                      break;
                  }
                  return profileFormInfo(snapshot);
                } ):Container(),
            ListTile(
              onTap: () async{

                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                String userId = sharedPreferences.getString(Constant.Kuser_id);
                print(userId);
                if(userId == null|| userId =='') {
                  Navigator.of(context) .push(MaterialPageRoute(builder: (BuildContext context) {
                    return LoginScreen();
                  }));
                }else{
                  Navigator.of(context) .push(MaterialPageRoute(builder: (BuildContext context) {
                    return Profile();
                  }));
                }




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
            ListTile(
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();

              },
              leading: Icon(
                FontAwesomeIcons.outdent,
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: sizeConfig.screenHeight,
              color: Color(0xFFEDEDED),
              child: Column(
                children: <Widget>[
                  _drawCarousselProducts(context, pr),
                  Padding(
                    padding:EdgeInsets.only(top: 5,left: 10,right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Categories",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                                    return AutoScreenCategories();
                                  }));
                                },
                                child:  buildIcon(0)   ),
                            buildIcon(1),
                            buildIcon(2),
                            buildIcon(3),
                            buildIcon(4),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text("recent Products",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                              height: sizeConfig.screenHeight*.3,
                              child: ListView.builder(
                                itemCount: pr.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Image(
                                            height: 150,
                                            width: 180,
                                            fit: BoxFit.cover,
                                            image: NetworkImage(pr[index].imagePath)

                                        ),
                                        Text(pr[index].nameProduct),
                                        Text("\$ ${pr[index].priceProduct} ",style: TextStyle(color: Colors.red)),

                                      ],
                                    ),
                                  );
                                },

                              )
                          ),
                        ),

                      ],
                    ),
                  ),
                  Text("recent Products",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                  Flexible(

                    child: Container(
                        height:1000,
                        child: gridListProducts()),
                  ),


                ],
              ),
            ),

          ],
        ),
      ),
      appBar: AppBar(
        actionsIconTheme:
        IconThemeData(color: mainTheme.primaryColorDark, size: 35),
        iconTheme: IconThemeData(color: mainTheme.primaryColorDark, size: 35),
        title: Text("Home",
            style: TextStyle(
                color: mainTheme.primaryColorDark,
                fontWeight: FontWeight.bold)),
        backgroundColor: mainTheme.primaryColorLight,
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
        height: sizeConfig.screenHeight * .07,
        backgroundColor: mainTheme.primaryColorLight,
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
    List<Widget> widgets = [];
    for (int i = 0; i < qty; i++) {
      widgets.add(Container(
          decoration: BoxDecoration(
              color: (i == currentIndex)
                  ? mainTheme.primaryColorDark
                  : Colors.grey[400],
              borderRadius: BorderRadius.circular(5)),
          width: 10,
          height: 10,
          margin: (i == qty - 1)
              ? EdgeInsets.only(right: 0)
              : EdgeInsets.only(right: 24)));
    }
    return widgets;
  }

  Widget profileFormInfo(AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.data.documents.length == 0 || snapshot.data.documents == null) {
      return UserAccountsDrawerHeader(
        accountName: Text("  No Account "),
        accountEmail: Text("   "),
        currentAccountPicture:
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(FontAwesomeIcons.userCheck ,size: 32,color: mainTheme.primaryColorDark,),
        ),
      );
    }
    return UserAccountsDrawerHeader
      (
      accountName: Text(snapshot.data.documents[0]['name']),
      accountEmail: Text("mbardouni44@gmail.com"),
      currentAccountPicture:
      ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.network("https://cdn2.f-cdn.com/ppic/140047602/logo/41720176/nTxdl/profile_logo_.jpeg")),
    );


  }

  Widget error(String s) {
    return Text(s);
  }
}
