import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
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
              child: Text(" Software Developer", style: GoogleFonts.poiretOne(fontSize: 30),),
            ),
            SizedBox(height: 15,),
            Container(
                margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Divider(
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
          ],
        ),
      ),
    );
  }
}
