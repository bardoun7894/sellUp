import 'package:flutter/material.dart';
import 'package:sellusedstuff/utils/mainTheme.dart';

class AutoScreenCategories extends StatefulWidget {
  @override
  _AutoState createState() => _AutoState();
}

class _AutoState extends State<AutoScreenCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(" Auto") ,
      ),
      body: Container(
        color: mainTheme.primaryColorLight,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      child:  ListView(
          children: <Widget>[
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Card(
                   elevation: 1,
                  child: ListTile(title: Center(child: Text("All in Auto,Wheel & Boot"))),
              ),
               ),
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Card(
                child:Column(
                  children:  ListTile.divideTiles(
                    color: Colors.grey,
                      context: context,
                      tiles: [
                        ListTile(
                          title: Text("All in Auto,Wheel & Boot"),
                        ), ListTile(
                          title: Text("All in Auto,Wheel & Boot"),
                        ), ListTile(
                          title: Text("All in Auto,Wheel & Boot"),
                        ), ListTile(
                          title: Text("All in Auto,Wheel & Boot"),
                        ), ListTile(
                          title: Text("All in Auto,Wheel & Boot"),
                        ),
                      ]

                  ).toList()
                )
              ),
            ),


          ],
        )
      ),
    );
  }
}
