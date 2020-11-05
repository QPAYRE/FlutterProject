import 'package:space_y/ui/widgets/sectionHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:space_y/ui/home/home_screen.dart';

class BookedScreen extends StatefulWidget {
  const BookedScreen();
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookedScreen> {
  DateTime now = DateTime.now();

  String getDat () {
    final DateTime tmp = now.add(const Duration(days: 10));
    final String kDate = DateFormat('dd/MM/yyyy').format(tmp);
    return kDate;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: [
          header(context, 'Space Tickets'),
          Column(
            children: <Widget>[
              const SizedBox(height: 200,),
              const Center(
                child: Text(
                  'You will go to space with Space Y in 10 days ! ',
                  style: TextStyle(color: Colors.grey, fontSize: 30), textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30,),
              Center(
                child: Text(getDat(), style: const TextStyle(color: Colors.grey, fontSize: 30), textAlign: TextAlign.center,),
              ),
              const SizedBox(height: 30,),
              const Icon(Icons.flight_takeoff, size: 100),
              const SizedBox(height: 60,),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0)),
                color: Colors.red,
                padding: const EdgeInsets.all(15.0),
                splashColor: Colors.deepOrange,
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    CupertinoPageRoute<dynamic>(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                },
                child: const Text('Done'),
              )
            ],
          ),
        ],
      )
    );
  }
}