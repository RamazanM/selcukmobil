import 'package:flutter/material.dart';
import 'takvim.dart';
import 'ogrenci.dart';
import 'menu.dart';
import 'map.dart';

class MDrawer {
  Widget MainDrawer(BuildContext ctx) {
    return Drawer(
      child: Container(
        color: Colors.blue[800],
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(padding: EdgeInsets.all(0.0),child: Image.asset("assets/Selcuklogo.png"),),
            RaisedButton(onPressed: (){Navigator.pushAndRemoveUntil(
              ctx,
              MaterialPageRoute(builder: (context) => Menu()),
              ModalRoute.withName("/")
            );}, child: Text("Anasayfa"),),
            RaisedButton(onPressed: (){Navigator.push(
              ctx,
              MaterialPageRoute(builder: (context) => Obis()),
            );}, child: Text("Obis"),),
            RaisedButton(onPressed: (){Navigator.push(
              ctx,
              MaterialPageRoute(builder: (context) => MapScreen()),
            );}, child: Text("Harita"),),
            RaisedButton(onPressed: (){Navigator.push(
                ctx,
                MaterialPageRoute(builder: (context) => Takvim()),
            );}, child: Text("Takvim"),),
            RaisedButton(onPressed: (){Navigator.push(
                ctx,
                MaterialPageRoute(builder: (context) => Menu()),
            );}, child: Text("Birimler"),),
            RaisedButton(onPressed: (){Navigator.push(
                ctx,
                MaterialPageRoute(builder: (context) => Menu()),
            );}, child: Text("Duyurular"),),

          ],
        ),
      ),
    );
  }
}
