import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Custom Barcode Scanner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String qr;
  bool camState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
            child: new Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        )),
      ),
      body: Container(
        color: const Color(0xFFF6F8FA),
        child: new Column(
          children: <Widget>[
            new Expanded(
                child: camState
                    ? new Center(
                        child: new SizedBox(
                          width: 300.0,
                          height: 300.0,
                          child: new QrCamera(
                            onError: (context, error) => Text(
                                  error.toString(),
                                  style: TextStyle(color: Colors.red),
                                ),
                            qrCodeCallback: (code) {
                              setState(() {
                                qr = code;
                              });
                            },
                            child: new Container(
                              decoration: new BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Colors.black54,
                                    width: 50.0,
                                    style: BorderStyle.solid),
                              ),
                            ),
                          ),
                        ),
                      )
                    : defaultAccessTabCamera()),
            new Container(
              child: new Text("QRCODE: $qr"),
            )
          ],
        ),
      ),
    );
  }

  Widget defaultAccessTabCamera() {
    return new GestureDetector(
        onTap: () {
          print("click");
          setState(() {
            camState = !camState;
          });
        },
        child: new Container(
          width: 300.0,
          height: 300.0,
          
          decoration: new BoxDecoration(
            
            shape: BoxShape.rectangle,
            color: Colors.grey,
            borderRadius: new BorderRadius.all(
              new Radius.circular(8.0),
            ),
          ),
          child: Center(
            child: new Text("Tap to Activity the Scan Camera"),
          ),
        ));
  }
}
