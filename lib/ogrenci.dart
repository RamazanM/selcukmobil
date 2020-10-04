import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'menu.dart';
import 'drawer.dart';

void main() {
  runApp(new Obis());
}

class Obis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'OBIS Giriş';
    return new MaterialApp(
      title: title,
      routes: {
        '/ogrenci': (context) => new WebviewScaffold(
          url: 'https://obis.selcuk.edu.tr',
          appBar: new AppBar(

          ),
          withZoom: false,
          withLocalStorage: true,

        ),
        '/ogretmen': (context) => new WebviewScaffold(
          url: 'https://obis.selcuk.edu.tr/home/perindex',
          appBar: new AppBar(
          ),
          withZoom: false,
          withLocalStorage: true,
        )
      },
      home: new GirisEkrani(),
        onUnknownRoute: (RouteSettings setting) {
          return new MaterialPageRoute(
              builder: (context) => new Menu()
          );
        }
      );

  }
}

class GirisEkrani extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<GirisEkrani> {
  void _ogrenciLink() {
    Navigator.of(context).pushNamed('/ogrenci');
  }

  void _ogretmenLink() {
    Navigator.of(context).pushNamed('/ogretmen');
  }

  @override
  Widget build(BuildContext context) {
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
      drawer: MDrawer().MainDrawer(context),
      body: Builder(
        builder: (context) =>
            Container(
                decoration: BoxDecoration(image: DecorationImage(
                    image: ExactAssetImage("assets/background.jpg"),fit: BoxFit.cover)),
                child:Center(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.pink,
                        textColor: Colors.white,
                        onPressed: () => _ogrenciLink(),
                        child: Text('Öğrenci Girişi'),
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () => _ogretmenLink(),
                        child: Text('Öğretim Elemanı Girişi'),
                      ),
                    ],
                  ),
                )
            ),
      ),
    );
  }

}