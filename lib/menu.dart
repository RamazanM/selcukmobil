import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'duyuru.dart';
import 'ogrenci.dart';
import 'takvim.dart';
import 'map.dart';
import 'katalog.dart';
import 'birimler.dart';
import 'obis.dart';
import 'etkinlik.dart';
import 'rehber.dart';
import 'yemekhane.dart';

// Ana menü

void main(){
  runApp(new MaterialApp(
      title: "Selcuk Mobil",
      home: new Menu(),
  ));
}


class Exit extends StatelessWidget{
  Widget build(BuildContext context) {
    exit(0);
    return null;
  }
}

class Menu extends StatefulWidget {
  @override
  MyMenu createState() {

    return new MyMenu();
  }
}

class MyMenu extends State<Menu> {

  MyMenu(){

  }

  List<String> list = List();
  List<String> linkedList = List();

  int _counter = 0;
  String _url = "";

  void sayiArttir() {
    setState(() {
      if(_counter < list.length-1){
        _counter++;
      }

    });
  }
  void sayiAzalt() {
    setState(() {
      if(_counter > 0){
        _counter--;
      }
    });
  }

  String getURL(){
      if(list.length != 0){
        return list[_counter];
      }
      else{
        return "Yükleniyor..";
      }

  }



  void _getData() async {
    final response =
    await http.get('https://test.selcuk.edu.tr/Duyurular');
    dom.Document document = parser.parse(response.body);
    final elements = document.getElementsByClassName('clamp');

    setState(() {
      list = elements
          .map((element) =>
      element.getElementsByTagName("a")[0].text)
          .toList();
      linkedList = elements
          .map((element) =>
      element.getElementsByTagName("a")[0].attributes['href'])
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    _getData();

    var iconImages = [
      'assets/obis.png',
      'assets/harita.png',
      'assets/yemekhane.png',
      'assets/etkinlikler.png',
      'assets/tanitim.png',
      'assets/birimler.png',
      'assets/akademik-takvim.png',
      'assets/yardim.png',
      'assets/cikis.png'];

    var iconTitles = [
      'OBİS',
      'Harita',
      'Yemekhane',
      'Etkinlikler',
      'Tanıtım',
      'Birimler',
      'Takvim',
      'T. Rehberi',
      'Çıkış'];

    var iconFunctions =[
      ObisView(),
      MapScreen(),
      Yemekhane(),
      Etkinlik(),
      Katalog(),
      Birimler(),
      Takvim(),
      Rehber(),
      Exit()];


    Widget buildButton(int index){

      List<Widget> list = new List<Widget>();

        list.add(new Column(
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(top: 10.0),
              width: 48.0,
              height: 48.0,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage(iconImages[index]),
                  )
              ),
            ),
            new Text(iconTitles[index])
          ],
        ));


      return new Column(
        children: list
      );
    }


    var gridView = new GridView.builder(
        itemCount: 9,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: new Card(
              elevation: 5.0,
              child: new Container(
                alignment: Alignment.center,
                child: buildButton(index)
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => iconFunctions[index]),
              );
            },
          );
        });

    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue[800],
      centerTitle: true,

      title:  new Container(
        width: 160.0,
        height: 60.0,
        decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("assets/Selcuklogo.png"),
                fit: BoxFit.fill)),
      ),
      ),
      body: new Container(
        decoration: new BoxDecoration(image: DecorationImage(image: ExactAssetImage("assets/background.jpg"),fit: BoxFit.cover)),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.white30,
                  width: 330.0,
                  height: 330.0,
                  child: gridView
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 300.0,
                  height: 200.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                    Container(
                      height: 50,
                      width: 20,
                      margin: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        child: Text("<<", style: TextStyle( color: Colors.white)),
                        onTap: () {
                          sayiAzalt();
                        }
                    ),),

                        Column(
                          children: <Widget>[
                            Container(
                                child: Text(
                                  'DUYURULAR',
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(

                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 5.0)
                            ),
                            Container(
                                child: GestureDetector(

                                    child: Text(getURL(),textAlign: TextAlign.center, style: TextStyle(decoration: TextDecoration.underline, color: Colors.amber )),
                                    onTap: () {
                                      if(linkedList.length != 0){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => DuyuruView(linkedList[_counter])),
                                        );
                                      }

                                    }
                                ),
                                margin: EdgeInsets.only(top: 20.0),
                              width: 230.0,
                            )
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 20,
                          margin: EdgeInsets.only(left: 10.0),
                          child: GestureDetector(
                              child: Text(">>", style: TextStyle( color: Colors.white)),
                              onTap: () {
                                sayiArttir();
                              }
                          ),),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white30),
                        top: BorderSide(color: Colors.white30)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }
}
