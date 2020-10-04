import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
class EtkinlikView extends StatelessWidget{


  String homepage="https://test.selcuk.edu.tr";



  final webview=new FlutterWebviewPlugin();


  EtkinlikView(String link){
    homepage = homepage + link;
  }



  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
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
      appCacheEnabled: true,
      url:homepage,
      withLocalStorage: true,
      clearCookies: false,
      clearCache: false,
    );

  }



}