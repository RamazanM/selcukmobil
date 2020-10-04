import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'drawer.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
class ObisView extends StatelessWidget{

  //final Completer<WebViewController> _controller=new Completer<WebViewController>();

  String homepage="https://obis.selcuk.edu.tr/";
  String redirectedHomepage="";
  String paramPath="Ogrenci/Anasayfa";


  RegExp regex=new RegExp(r"^https\:\/\/obis[1-9]?\.selcuk\.edu\.tr\/Ogrenci\/Anasayfa$");
  RegExp numberedURL=new RegExp(r"^https\:\/\/obis[1-9]\.selcuk\.edu\.tr\/$");
 // RegExp numberedURLwDash=new RegExp(r"^https\:\/\/obis[1-9]\.selcuk\.edu\.tr\/$");


  final webview=new FlutterWebviewPlugin();


  ObisView(){
    webview.onUrlChanged.listen((url){
      print("url is:"+url);
      if(numberedURL.hasMatch(url)){
        redirectedHomepage=url;
         print(redirectedHomepage + paramPath + " is redirecting");
          webview.reloadUrl(redirectedHomepage + paramPath);
        }
    });
    webview.onHttpError.listen((err){
      print(err.code+" "+err.url);
      if((err.code=="404" || err.code=="500") && regex.hasMatch(err.url)){
        print(redirectedHomepage.substring(0,redirectedHomepage.length-1)+" is redirecting(404)");

        webview.reloadUrl(redirectedHomepage.substring(0,redirectedHomepage.length-1)+"#");
      }
    });

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