import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:core';

class SearchField extends StatefulWidget {
  FocusNode focusNode;
  Function onToggle;
  Function onSelect;
  Map<MarkerId, Marker> markers;
  SearchField({Key key, @required this.focusNode, Function onToggleFunction, Function onSelectOne, Map<MarkerId, Marker> markers}): super(key: key){
    onToggle = onToggleFunction;
    onSelect = onSelectOne;
    this.markers = markers;
  }
  @override
  _SearchFieldState createState() => new _SearchFieldState();
}
class _SearchFieldState extends State<SearchField> {
  final _suggestions = <String>["Teknoloji Fakültesi", "Mühendislik Fakültesi"];
  String searchString = "";
  bool searchBox = false;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
    controller.addListener(() {
      print(controller.text);
      var listToShow = widget.markers.values.where((marker) => marker.infoWindow.title.toLowerCase().contains(controller.text.toLowerCase()));
      _suggestions.clear();
      _suggestions.addAll(listToShow.map((marker) {return marker.infoWindow.title;}));
      if(controller.text == "" && widget.focusNode.hasFocus)
        widget.onSelect("");
      setState(() {});
    });
  }

  void _onFocusChange(){
    debugPrint("Focus: "+widget.focusNode.hasFocus.toString());
    if(widget.focusNode.hasFocus)
      setState(() {
              searchBox = true;
            });
    else
      setState(() {
              searchBox = false;
            });
    debugPrint("Focus: "+ searchBox.toString());
  }

  void onTap(String str){
    widget.onToggle(str);
  }

  @override
  Widget build(BuildContext context) {  
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextField(
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            hintText: "Aramak istediğiniz yeri yazınız...",
            fillColor: Colors.white,
            filled: true,
          ),
          controller: controller,
          // onChanged: (text) {
          //   // var listToShow = widget.markers.values.where((marker) => marker.infoWindow.title.contains(text));
          //   // _suggestions.clear();
          //   // _suggestions.addAll(listToShow.map((marker) {return marker.infoWindow.title;}));
          //   controller.text = text;
          //   print(text);
          // },
        ),
        searchBox ? Container(
          color: Colors.white,
            padding: const EdgeInsets.all(0.0),
            alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildSuggestions()
            ],
          )
        )
        : new Container()
      ]
    ); 
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    controller.dispose();
    super.dispose();
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: (_suggestions.length < 5) ? _suggestions.length : 5,
      itemBuilder: (context, i) {
        return _buildRow(_suggestions[i]);
      },
    );
  }

  Widget _buildRow(String str) {
    return new ListTile(
      title: new Text(str),
      onTap: (){widget.onSelect(str); widget.focusNode.unfocus();},
    );
  }
}