import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main()=>runApp(App());

enum SelectStatus{none,ogrenci,akademisyen,misafir}



class App extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Selçuk",
      home: LoginSelect(),
    );
  }
}



class LoginSelect extends StatelessWidget {

  final SelectStatus selectStatus=SelectStatus.none;


  Widget selectButton(String mText,IconData mIcon, Function mOnPressed){
    return
      Container(
        width: 150.0,
        height: 150.0,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black,blurRadius: 2.0,offset: Offset(1.0, 1.0),spreadRadius: 3.0)
          ]),
        child:
          RaisedButton.icon(
            onPressed:mOnPressed,
            icon: Icon(mIcon),
            label: Text(mText),
          )
      );
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]); //Widgeti landscape modda açmayı engeller.

    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/login-background.jpg"),
                    fit: BoxFit.fitHeight)
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                            children: [
                              selectButton("Öğrenci", Icons.person, () {
                                Navigator.push(context,SlideLeftRoute(widget: Login(SelectStatus.ogrenci)));
                              }),
                              selectButton("Personel", Icons.person, () {
                                Navigator.push(context, SlideLeftRoute(widget: Login(SelectStatus.akademisyen)));
                              }),
                            ]),
                        selectButton("Misafir", Icons.person, () {}),
                      ])
                ])
        )
    );
  }
}
class Login extends StatefulWidget{

  SelectStatus status;
  Login(SelectStatus status){this.status=status;}

  @override
  _LoginState createState() {return new _LoginState(status);}


}

class _LoginState extends State<Login>{

  final loginForm=GlobalKey<FormState>();
  SelectStatus status;

  _LoginState(SelectStatus status){this.status=status;}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/login-background.jpg"),
                        fit: BoxFit.fitHeight)
                ),
                child: Form(
                    key: loginForm,
                    child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  color: Color.fromARGB(155, 255, 255, 255)
                          ),
                            width: 300.0,
                            height: 420.0,
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 200.0,
                                      height: 200.0,
                                    child: DecoratedBox(
                                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/Selcuklogo-login.png"))),
                                  )),
                                  Text(
                                    status==SelectStatus.ogrenci?"Öğrenci Girişi":"Personel Girişi",
                                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.person)),
                                    validator: (text) {
                                      if (text.isEmpty)
                                        return "Lütfen gerekli alanları doldurunuz.";
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.vpn_key)),
                                    obscureText: true,
                                    validator: (text) {
                                      if (text.isEmpty)
                                        return "Lütfen gerekli alanları doldurunuz.";
                                    },
                                  ),
                                  Spacer(),
                                  RaisedButton(
                                    child: Text("Giriş Yap"),
                                    onPressed: () {
                                      loginForm.currentState.validate();
                                    },
                                  )
                                ],
                              ),
                            )
                        )
                    )
                )
            )
    );
  }
}


class SlideLeftRoute extends PageRouteBuilder {
  final Widget widget;
  SlideLeftRoute({this.widget})
      : super(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return new SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      }
  );
}