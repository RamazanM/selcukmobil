import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:photo_view/photo_view.dart';

import 'drawer.dart';

void main() => runApp(Yemekhane());

class Yemekhane extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Yemekhane> {

  List<String> list = List();
  List<String> img = List();

  void _getData() async {
    final response =
    await http.get('https://test.selcuk.edu.tr/Bilgi/2019-yemek-listesi-4902');
    dom.Document document = parser.parse(response.body);
    final elements = document.getElementsByClassName('about-text-container');

    setState(() {
      img = elements
          .map((element) =>
      element.getElementsByTagName("p")[0].getElementsByTagName('img')[0].attributes['src'])
          .toList();
    });

  }

  String getImg(){
    if(img.length !=0){
      return img[0];
    }else{
      return "";
    }
  }


  @override
  Widget build(BuildContext context) {

    _getData();
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
            appBar: AppBar(title: Text('Yemekhane')),
            drawer: MDrawer().MainDrawer(context),
            body: new Container(
                child: new PhotoView(
                  imageProvider: NetworkImage(getImg()),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: 4.0,
                )
            )
    ) );
  }
}