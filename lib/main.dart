import 'package:flutter/material.dart';
import 'menu.dart';
//Uygulamanın main processi, tüm sayfalar tasarlandıktan sonra bu class düzenlenecek.
//İlk etapta herkes kendi üzerine düşen sayfayı tasarlayıp sağ üstteki main.dart yazan yerden
//edit conf. > sol panel > "+" > Flutter > Data Entry point kısmından kendi sayfasını belirtip deneyebilir.


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SU Mobil Uygulaması',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(child: Menu()),
    );
  }
}

