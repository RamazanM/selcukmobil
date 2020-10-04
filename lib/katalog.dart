import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

void main() => runApp(Katalog());

class Katalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final children = <ExactAssetImage>[];
    for (var i = 101; i < 225; i++) {
      children.add( new ExactAssetImage("assets/tanitim/"+ i.toString() +".jpg"));
    }

    return Container(
      child: new SizedBox(
          child: new Carousel(
            images: children,
            autoplay: false,
            boxFit: BoxFit.contain,
            dotSize: 1.0,
            dotSpacing: 2.0,
          )
      ),
    );
  }
}