import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'search_field.dart';
import 'dart:convert';
import 'drawer.dart';

const API_KEY = "AIzaSyDq_lAkSFoPCFf-10Oic2COpsNrIKSzZsM";

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MapScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class MapScreen extends StatefulWidget {
  MapScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MapScreenState createState() => new _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool fakulteB  = true, tesisB  = true, idariB  = true, ulasimB = true;
  String markersDatas = "";
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<MarkerId, Marker> fakulteMarkers = <MarkerId, Marker>{};
  bool fakulte = true;
  Map<MarkerId, Marker> tesisMarkers = <MarkerId, Marker>{};
  bool tesis = true;
  Map<MarkerId, Marker> idariMarkers = <MarkerId, Marker>{};
  bool idari = true;
  Map<MarkerId, Marker> ulasimMarkers = <MarkerId, Marker>{};
  bool ulasim = true;
  String searchText = "";
  FocusNode _focus = new FocusNode();

  GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: MDrawer().MainDrawer(context),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onCameraMove: _onTap,
              markers: Set<Marker>.of(markers.values),
              onMapCreated: _onMapCreated,
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(target: LatLng(38.028253, 32.5082645), zoom: 15),
              cameraTargetBounds: CameraTargetBounds(LatLngBounds(southwest: LatLng(38.0106967,32.4955114), northeast: LatLng(38.0438058,32.5222411))),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              alignment: Alignment.topCenter,
              child: SearchField(focusNode: _focus, onToggleFunction: _onTogglePlace, onSelectOne: _onSelect, markers: markers),
              // child: TextField(

              //   decoration: InputDecoration(
              //     hintText: "Aramak istediğiniz yeri yazınız...",
              //     fillColor: Colors.white,
              //     filled: true,

              //   ),
              // ),
            ),
            Positioned(
              bottom: 10,
              child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 5),),
                  Column(
                    children: <Widget>[
                      ClipOval(
                        child: Container(
                          color: (fakulteB) ? Colors.red : Colors.transparent,
                          child: IconButton(icon: Icon(Icons.account_balance), onPressed: () {
                            _onTogglePlace("fakulte");
                            fakulteB = !fakulteB;
                          },),
                        ),
                      ),
                      Text('Fakülteler',style: TextStyle(fontSize: 10),)
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      ClipOval(
                        child: Container(
                          color: (tesisB) ? Colors.green : Colors.transparent,
                          child: IconButton(icon: Icon(Icons.account_balance), onPressed: () {
                            _onTogglePlace("tesis");
                            tesisB = !tesisB;
                          },),
                        ),
                      ),
                      Text('Tesisler',style: TextStyle(fontSize: 10),)
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      ClipOval(
                        child: Container(
                          color: (idariB) ? Colors.yellow : Colors.transparent,
                          child: IconButton(icon: Icon(Icons.account_balance), onPressed: () {
                            _onTogglePlace("idari");
                            idariB = !idariB;
                          },),
                        ),
                      ),
                      Text('İdari Birimler',style: TextStyle(fontSize: 10),)
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      ClipOval(
                        child: Container(
                          color: (ulasimB) ? Colors.blue : Colors.transparent,
                          child: IconButton(icon: Icon(Icons.account_balance), onPressed: () {
                            _onTogglePlace("ulasim");
                            ulasimB = !ulasimB;
                          },),
                        ),
                      ),
                      Text('Duraklar',style: TextStyle(fontSize: 10),)
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(right: 5),),
                ],
              ),
            )
          ],
        )

    );
  }

  void _onSelect(String str){
    print("this /"+str);
    if(str == ""){
      markers.clear();
      fakulteMarkers.forEach((k,v) => setState((){
        markers[k] = v;
      }));
      tesisMarkers.forEach((k,v) => setState((){
        markers[k] = v;
      }));
      idariMarkers.forEach((k,v) => setState((){
        markers[k] = v;
      }));
      ulasimMarkers.forEach((k,v) => setState((){
        markers[k] = v;
      }));
      print("worked--");
      setState(() {});
    }
    else{
      print("corked-- " + str);
      markers.removeWhere((key, value) => value.infoWindow.title != str);
      setState(() {});
    }
  }

  void _onTap(CameraPosition pos){
    _focus.unfocus();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() { mapController = controller; });
    setMarkers();
    print("Create çalıştı ---------------------------");
  }

  void _onTogglePlace(String str){
    if(str == "fakulte"){
      if(fakulte){
        fakulteMarkers.forEach((k,v) => setState((){
          markers.remove(k);
        }));
      }
      else{
        fakulteMarkers.forEach((k,v) => setState((){
          markers[k] = v;
        }));
      }
      fakulte = !fakulte;
    }
    else if(str == "tesis"){
      if(tesis){
        tesisMarkers.forEach((k,v) => setState((){
          markers.remove(k);
        }));
      }
      else{
        tesisMarkers.forEach((k,v) => setState((){
          markers[k] = v;
        }));
      }
      tesis = !tesis;
    }
    else if(str == "idari"){
      if(idari){
        idariMarkers.forEach((k,v) => setState((){
          markers.remove(k);
        }));
      }
      else{
        idariMarkers.forEach((k,v) => setState((){
          markers[k] = v;
        }));
      }
      idari = !idari;
    }
    else if(str == "ulasim"){
      if(ulasim){
        ulasimMarkers.forEach((k,v) => setState((){
          markers.remove(k);
        }));
      }
      else{
        ulasimMarkers.forEach((k,v) => setState((){
          markers[k] = v;
        }));
      }
      ulasim = !ulasim;
    }
  }

  void setMarkers(){
    // fetchCoordinates().then((onValue) {
    //   markersDatas = onValue.body;
    //   var data = json.decode(onValue.body);
    //   data.forEach((data){
    //     setState(() {
    //       var markerData = MarkerPlace.fromJson(data);
    //       if(markerData.type == PlaceType.Fakulte){
    //         markerData.hue = BitmapDescriptor.hueRed;
    //       }
    //       if(markerData.type == PlaceType.Tesis){
    //         markerData.hue = BitmapDescriptor.hueGreen;
    //       }
    //       if(markerData.type == PlaceType.Idari){
    //         markerData.hue = BitmapDescriptor.hueYellow;
    //       }
    //       if(markerData.type == PlaceType.Ulasim){
    //         markerData.hue = BitmapDescriptor.hueAzure;
    //       }
    //       markers[markerData.id] = Marker(
    //         markerId: markerData.id,
    //         position: markerData.position,
    //         infoWindow: new InfoWindow(title: markerData.name, snippet: markerData.description),
    //         icon: BitmapDescriptor.defaultMarkerWithHue(markerData.hue)
    //       );
    //       sortMarkers(markers[markerData.id], markerData);
    //     });
    //   });
    // });
    // var data = json.decode(jObj.body);
    // data.forEach((data){
    //   setState(() {
    //     var markerData = MarkerPlace.fromJson(data);
    //     markers[markerData.id] = Marker(markerId: markerData.id, position: markerData.position, infoWindow: new InfoWindow(title: markerData.name, snippet: markerData.description));
    //   });
    // });

    setState(() {
      markers[MarkerId("fakulte1")] = Marker(markerId: MarkerId("fakulte1"), position: LatLng(38.0286307, 32.5093174), infoWindow: new InfoWindow(title: "Teknoloji Fakültesi", snippet: "snippet"));
      markers[MarkerId("fakulte2")] = Marker(markerId: MarkerId("fakulte2"), position: LatLng(38.0275098, 32.5082539), infoWindow: new InfoWindow(title: "Yabancı Diller Yüksekokulu", snippet: "snippet"));
      markers[MarkerId("fakulte3")] = Marker(markerId: MarkerId("fakulte3"), position: LatLng(38.0262237, 32.5066439), infoWindow: new InfoWindow(title: "Fen Fakültesi", snippet: "snippet"));
      markers[MarkerId("fakulte4")] = Marker(markerId: MarkerId("fakulte4"), position: LatLng(38.0256828, 32.5052089), infoWindow: new InfoWindow(title: "Fen Edebiyat Fakültesi", snippet: "snippet"));
      markers[MarkerId("fakulte5")] = Marker(markerId: MarkerId("fakulte5"), position: LatLng(38.0294932, 32.5064119), infoWindow: new InfoWindow(title: "Teknik Bilimler Meslek Yüksekokulu", snippet: "snippet"));
      markers[MarkerId("fakulte6")] = Marker(markerId: MarkerId("fakulte6"), position: LatLng(38.0241293, 32.5056622), infoWindow: new InfoWindow(title: "Hukuk Fakültesi", snippet: "snippet"));
      markers[MarkerId("tesis1")] = Marker(markerId: MarkerId("tesis1"), position: LatLng(38.0251413, 32.5075565), infoWindow: new InfoWindow(title: "Keykubat Köşkü", snippet: "snippet"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
      markers[MarkerId("tesis2")] = Marker(markerId: MarkerId("tesis2"), position: LatLng(38.0265010, 32.5126105), infoWindow: new InfoWindow(title: "Kampüs Camii", snippet: "snippet"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
      markers[MarkerId("idari1")] = Marker(markerId: MarkerId("idari1"), position: LatLng(38.0253341, 32.5124750), infoWindow: new InfoWindow(title: "Bil-mer", snippet: "snippet"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow));
      markers[MarkerId("tesis3")] = Marker(markerId: MarkerId("tesis3"), position: LatLng(38.0207575, 32.5120137), infoWindow: new InfoWindow(title: "Selçuk Ünv. Tıp Fakültesi Hastanesi", snippet: "snippet"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
      markers[MarkerId("fakulte7")] = Marker(markerId: MarkerId("fakulte7"), position: LatLng(38.0202472, 32.5084993), infoWindow: new InfoWindow(title: "Sağlık Bilimleri Fakültesi", snippet: "snippet"));
      markers[MarkerId("fakulte8")] = Marker(markerId: MarkerId("fakulte8"), position: LatLng(38.0213000, 32.5099477), infoWindow: new InfoWindow(title: "İletişim Fakültesi", snippet: "snippet"));
      markers[MarkerId("fakulte9")] = Marker(markerId: MarkerId("fakulte9"), position: LatLng(38.0226555, 32.5078013), infoWindow: new InfoWindow(title: "Sosyal Bilimer Fakültesi", snippet: "snippet"));
      markers[MarkerId("fakulte10")] = Marker(markerId: MarkerId("fakulte10"), position: LatLng(38.0294605, 32.5110032), infoWindow: new InfoWindow(title: "Ziraat Fakültesi", snippet: "snippet"));
      markers[MarkerId("fakulte11")] = Marker(markerId: MarkerId("fakulte11"), position: LatLng(38.0288293, 32.5125307), infoWindow: new InfoWindow(title: "Veterinerlik Fakültesi", snippet: "snippet"));
      markers[MarkerId("tesis4")] = Marker(markerId: MarkerId("tesis4"), position: LatLng(38.0241356, 32.5119379), infoWindow: new InfoWindow(title: "Prof. Dr. Erol Güngör Kütüphanesi", snippet: "snippet"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
      markers[MarkerId("fakulte11")] = Marker(markerId: MarkerId("fakulte11"), position: LatLng(38.0219756, 32.5093831), infoWindow: new InfoWindow(title: "Diş Hekimliği Fakültesi", snippet: "snippet"));
      markers[MarkerId("fakulte12")] = Marker(markerId: MarkerId("fakulte12"), position: LatLng(38.0136310, 32.5134594), infoWindow: new InfoWindow(title: "Beden Eğitimi Ve Spor Yüksekokulu", snippet: "snippet"));
      markers[MarkerId("fakulte13")] = Marker(markerId: MarkerId("fakulte13"), position: LatLng(38.0124952, 32.5130014), infoWindow: new InfoWindow(title: "Güzel Sanatlar Fakültesi", snippet: "snippet"));
      markers[MarkerId("fakulte14")] = Marker(markerId: MarkerId("fakulte14"), position: LatLng(38.0125802, 32.5146174), infoWindow: new InfoWindow(title: "Dilek Sabancı Devlet Konservatuvarı", snippet: "snippet"));
      markers[MarkerId("tesis5")] = Marker(markerId: MarkerId("tesis5"), position: LatLng(38.0155852, 32.5118581), infoWindow: new InfoWindow(title: "19 Mayıs Spor Salonu", snippet: "snippet"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
      markers[MarkerId("ulasim1")] = Marker(markerId: MarkerId("ulasim1"), position: LatLng(38.0266960, 32.507913), infoWindow: new InfoWindow(title: "Edebiyat Fakültesi Tramvay Durağı", snippet: "snippet"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure));
      markers[MarkerId("ulasim2")] = Marker(markerId: MarkerId("ulasim2"), position: LatLng(38.0269769, 32.5113297), infoWindow: new InfoWindow(title: "Mühendislik Fakültesi Tramvay Durağı", snippet: "snippet"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure));
      markers[MarkerId("ulasim3")] = Marker(markerId: MarkerId("ulasim3"), position: LatLng(38.0246580, 32.506843), infoWindow: new InfoWindow(title: "Hukuk Fakültesi Tramvay Durağı", snippet: "snippet"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure));
      markers[MarkerId("fakulte15")] = Marker(markerId: MarkerId("fakulte15"), position: LatLng(38.0262046, 32.5096024), infoWindow: new InfoWindow(title: "Mühendislik Fakültesi", snippet: "snippet"));
    });
    markers.forEach(sortMarkersMap);
    print(markers);
  }

  void sortMarkers(Marker marker, MarkerPlace data){
    if(data.type == PlaceType.Fakulte){
      fakulteMarkers[data.id] = marker;
    }
    else if(data.type == PlaceType.Tesis){
      tesisMarkers[data.id] = marker;
    }
    else if(data.type == PlaceType.Idari){
      idariMarkers[data.id] = marker;
    }
    else if(data.type == PlaceType.Ulasim){
      ulasimMarkers[data.id] = marker;
    }
  }

  void sortMarkersMap(MarkerId key, Marker value){
    if(key.value.contains("fakulte")){
      fakulteMarkers[key] = value;
    }
    else if(key.value.contains("tesis")){
      tesisMarkers[key] = value;
    }
    else if(key.value.contains("idari")){
      idariMarkers[key] = value;
    }
    else if(key.value.contains("ulasim")){
      ulasimMarkers[key] = value;
    }
  }


  Future<http.Response> fetchCoordinates() async {
    return await http.get('http://localhost:5000/api/coordinates');
  }
}

class MarkerPlace{
  MarkerId id;
  LatLng position;
  String name;
  String description;
  double hue;
  PlaceType type;

  MarkerPlace(MarkerId id, LatLng position, String name, String description, PlaceType type){
    this.id = id;
    this.position = position;
    this.name = name;
    this.description = description;
    this.type = type;
  }

  factory MarkerPlace.fromJson(Map<String, dynamic> parsedJson){
    PlaceType type;
    if(parsedJson['type'] == 'fakulte')
      type = PlaceType.Fakulte;
    else if(parsedJson['type'] == 'tesis')
      type = PlaceType.Tesis;
    else if(parsedJson['type'] == 'idari')
      type = PlaceType.Idari;
    else if(parsedJson['type'] == 'ulasim')
      type = PlaceType.Ulasim;
    var mark = MarkerPlace(
        MarkerId(parsedJson['id'].toString()),
        new LatLng(parsedJson['position']['latitude'], parsedJson['position']['longitude']),
        parsedJson ['name'],
        parsedJson['description'],
        type
    );
    return mark;
  }
}

enum PlaceType{
  Fakulte,
  Tesis,
  Idari,
  Ulasim
}