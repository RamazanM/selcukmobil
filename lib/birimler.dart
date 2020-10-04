import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'drawer.dart';


class Entry{
  ExpansionTile own;
  List<ListTile> children;
  Entry(this.own,this.children);
}


class Birimler extends StatefulWidget{
  @override
  State<Birimler> createState() {
    return new BirimlerState();
  }
}
class BirimlerState extends State<Birimler>{
  List<Entry> listItems=new List<Entry>();



 void getCategories() {
    String soap='''<?xml version="1.0" encoding="utf-8"?>
      <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
        <soap:Header>
          <USERS xmlns="http://193.140.140.38/testwebbirim/">
            <name>wsMobilOgr</name>
            <password>5rPRHWs8Dx</password>
          </USERS>
        </soap:Header>
        <soap:Body>
          <birimTurleriListelebyTurTipAdi xmlns="http://193.140.140.38/testwebbirim/">
            <turtipadi>Akademik</turtipadi>
            <lang>tr</lang>
          </birimTurleriListelebyTurTipAdi>
        </soap:Body>
      </soap:Envelope>''';

    http.post("http://193.140.140.133/testwebbirim/service.asmx",
        headers: {
          "Content-Type":"text/xml",
          "SOAPAction": "http://193.140.140.38/testwebbirim/birimTurleriListelebyTurTipAdi"
        },
        body: utf8.encode(soap)
    ).then((resp){
      var doc=xml.parse(resp.body);
      List<Widget> items=new List();
      doc.children[1].firstChild.firstChild.firstChild.children.forEach((child){

        setState(() {
          var parent=new Entry(ExpansionTile(title: Text(child.children[3].text,style: TextStyle(fontWeight: FontWeight.bold),)),null);
          listItems.add(parent);
          getSubContents(child.children[2].text,parent);
        });

      });

    });


  }


  List<Widget> getSubContents(String birimTur,Entry parent){
    List<Widget> items=new List();
    String soap='''<?xml version="1.0" encoding="utf-8"?>
      <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.orhema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Header>
          <USERS xmlns="http://193.140.140.38/testwebbirim/">
            <name>wsMobilOgr</name>
            <password>5rPRHWs8Dx</password>
          </USERS>
        </soap:Header>
        <soap:Body>
          <birimListelebyBirimTur  xmlns="http://193.140.140.38/testwebbirim/">
            <otomasyonlink>web</otomasyonlink>
            <birimturlink>$birimTur</birimturlink>
            <lang>tr</lang>
          </birimListelebyBirimTur>
        </soap:Body>
      </soap:Envelope>''';
        http.post("http://193.140.140.133/testwebbirim/service.asmx",
        headers: {
          "Content-Type":"text/xml",
          "SOAPAction": "http://193.140.140.38/testwebbirim/birimListelebyBirimTur"
        },
        body: utf8.encode(soap)
    ).then((resp){
          var doc=xml.parse(resp.body);
          parent.children=new List();
          doc.children[1].children[0].children[0].children[0].children.forEach((c){
            setState(() {
              parent.children.add(listItem(c.children[3].text, c.children[1].text) );
            });
          });
        });

  }

  Widget listItem(String text,String url){
    return ListTile(
      title: Padding(padding: EdgeInsets.only(left: 10.0),child: Text(text)),
      onTap:(){
        print( "http://www.selcuk.edu.tr/"+url);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>new WebviewScaffold(url: "http://www.selcuk.edu.tr/"+url+"/tr")));},
    );
  }

  @override
  Widget build(BuildContext context) {
    //setListItems();

    return Scaffold(
        appBar: AppBar(title: Text("Birimler")),
        drawer: MDrawer().MainDrawer(context),
        body: ListView.builder(itemBuilder: (BuildContext ctx,int index){
        var myItem=listItems[index];
        myItem.children;
          return ExpansionTile(title:myItem.own.title ,children: myItem.children,);
        },itemCount: listItems.length),
    );
  }

  @override
  void initState() {
    getCategories();
  }

}