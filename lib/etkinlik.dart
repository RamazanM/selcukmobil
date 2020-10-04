import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'drawer.dart';
import 'etkinlikv.dart';

void main() => runApp(Etkinlik());

class Etkinlik extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Etkinlik> {

  List<String> list = List();
  List<String> linkedList = List();

  void _getData() async {
    final response =
    await http.get('https://test.selcuk.edu.tr/HaberKulturSpor');
    dom.Document document = parser.parse(response.body);
    final elements = document.getElementsByClassName('single-event-text');

    setState(() {
      list = elements
          .map((element) =>
      element.getElementsByTagName("h3")[0].getElementsByTagName('a')[0].text)
          .toList();
      linkedList = elements
          .map((element) =>
      element.getElementsByTagName("h3")[0].getElementsByTagName('a')[0].attributes['href'])
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {

    _getData();
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
            appBar: AppBar(title: Text('Etkinlikler')),
            drawer: MDrawer().MainDrawer(context),
            body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Card( //                           <-- Card widget
              child: new InkWell(
                onTap: () {
                  if(linkedList.length != 0){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EtkinlikView(linkedList[index])),
                    );
                  }
                },
                child: ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text(list[index]),
                ),
              )
            );
          },
        )

        ));
  }
}