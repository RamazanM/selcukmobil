import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// void main() => runApp(Rehber());

// class Rehber extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Telefon Rehberi'),
//     );
//   }
// }

class Rehber extends StatefulWidget {
  Rehber({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RehberState createState() => _RehberState();
}

class _RehberState extends State<Rehber> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription<double> _onProgressChanged;
  @override
  Widget build(BuildContext context) {
    flutterWebviewPlugin.launch(
      "http://telefonrehber.selcuk.edu.tr/veridene1/WebForm2.aspx",
      rect: new Rect.fromLTWH(
        0.0,
        90.0,
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
    );

    _onProgressChanged =
        flutterWebviewPlugin.onProgressChanged.listen((double progress) {
      // if(progress == 0.2){
      //   flutterWebviewPlugin.evalJavascript("var meta = document.createElement('meta');meta.name = \"viewport\";meta.content = \"width=device-width, initial-scale=1.0\";document.getElementsByTagName('head')[0].appendChild(meta);");
      // }
      if (progress == 1.0) {
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementsByClassName('Object0');elem[0].parentNode.removeChild(elem[0]);");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementsByClassName('Object1');elem[0].parentNode.removeChild(elem[0]);");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementsByClassName('Object3');elem[0].parentNode.removeChild(elem[0]);");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementsByClassName('Object5');elem[0].parentNode.removeChild(elem[0]);");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementsByClassName('Object6');elem[0].parentNode.removeChild(elem[0]);");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementsByClassName('Object7');elem[0].parentNode.removeChild(elem[0]);");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementsByClassName('objectline');elem[0].parentNode.removeChild(elem[0]);");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementsByClassName('objectlineup');elem[0].parentNode.removeChild(elem[0]);");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementsByClassName('Object8');elem[0].style.width='100%';elem[0].style.left=0;elem[0].style.top=0;");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementById('IsimPnl');elem.style.width='100%';elem.style.left=0;");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementById('DataGrid2');elem.style.width='100%';");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementById('IsimdeBtn');elem.parentNode.removeChild(elem);");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementById('Label5');elem.parentNode.removeChild(elem);");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementById('Label6');elem.parentNode.removeChild(elem);");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementById('Label2');elem.parentNode.insertBefore(document.createElement(\"br\"), elem);");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementById('HyperLink1');elem.parentNode.removeChild(elem);");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementById('DataGrid2');elem.style.width='100%';");
        flutterWebviewPlugin.evalJavascript(
            "var elem = document.getElementsByTagName(\"body\")[0]; elem.style.margin = 0");
      }
    });

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        centerTitle: true,
        title: new Container(
          width: 160.0,
          height: 60.0,
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/Selcuklogo.png"),
                  fit: BoxFit.fill)),
        ),
      ),
    );
  }

  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    flutterWebviewPlugin.close();
    flutterWebviewPlugin.dispose();
    _onProgressChanged.cancel();

    super.dispose();
  }
}
