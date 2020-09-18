import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  Future<String> getPos() async {
    var url = "https://api-adresse.data.gouv.fr/search/?q=toulouse&type=street";

    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map['features'];
      return(data[0]['properties']['label']);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    var locate = getPos();
    print(locate);
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: 300,
                    height: 300,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                )
              ],
            ),
            Center(
              child: Text(" Software Developer", style: GoogleFonts.poiretOne(fontSize: 30, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 15,),
            Container(
                margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Divider(
                  thickness: 2,
                  color: Colors.red,
                )),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    Icon(Icons.phone),
                    Text("  +33 6 98 30 04 26", style: TextStyle(fontSize: 20),),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.mail),
                Text("  quentin.payre@gmail.com", style: TextStyle(fontSize: 20),),
              ],
            ),
            SizedBox(height: 20,),
            FutureBuilder(
              future: getPos(),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasError) return Text('${snapshot.error}');
                if (snapshot.hasData) return Text('${snapshot.data}');
                return const CircularProgressIndicator();
              },
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondRoute()),
                  );
                },
                child: Text('next page !'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}