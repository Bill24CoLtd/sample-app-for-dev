import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  static const platform = const MethodChannel('paymentSdk');
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void callSdk() async {
      var result;
      var language = "en";

      Map<String, String> sdk_parameters =
      {
        "session_id": "",
        "client_id": "",
        "language": "",
        "environment": ""
      };
      try {
            sdk_parameters["session_id"] = controller.text;
            sdk_parameters["language"] = language;
            sdk_parameters["client_id"] = "weYubIQRp7KoaEo4oy3kHEc8J7QVQasSrMPtvfOFamQ=";
            sdk_parameters["environment"] = "testing";
            result = await platform.invokeMethod("paymentSdk", sdk_parameters);
            if (result.isNotEmpty) {
              // do your stuff here
            }

      } catch (e) {
        print(e);
      }
    }
    return GestureDetector(
      onTap: () =>  FocusScope.of(context).unfocus()
      ,
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Sample App for Dev"),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Session Id: ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  autofocus: true,
                      controller: controller,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFFFFFFF),
                            ),
                            borderRadius:
                            BorderRadius.circular(
                                10)),
                        labelText: 'Input Session Id',
                        labelStyle:
                        TextStyle(fontSize: 15),
                        hintText:
                        'Session id',
                        hintStyle: const TextStyle(
                          fontSize: 15,
                        ),
                        prefixIcon: const Icon(
                          Icons.key,
                          size: 30,
                        ),
                      ),
                ),
            const SizedBox(height: 30,),
            Container(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ButtonStyle(
                  //to style a button
                    
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(8)))),
                child: const Text(
                  "Request",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 20),
                ),
                onPressed: () {
                  callSdk();
                },
              ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
