import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'drawer.dart';
class DuyuruView extends StatelessWidget{


  String homepage="https://test.selcuk.edu.tr";



  final webview=new FlutterWebviewPlugin();


  DuyuruView(String link){
    homepage = homepage + link;
  }



  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(backgroundColor: Colors.blue[800],
        centerTitle: true,
        title:  new Column(
          children: <Widget>[
            new Container(
              width: 160.0,
              height: 60.0,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new AssetImage("assets/Selcuklogo.png"),
                      fit: BoxFit.fill)),
            ),
            new MDrawer().MainDrawer(context)
          ],
        )
      ),
      appCacheEnabled: true,
      url:homepage,
      withLocalStorage: true,
      clearCookies: false,

      clearCache: false,
    );

  }



}