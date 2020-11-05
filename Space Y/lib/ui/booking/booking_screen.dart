import 'package:space_y/ui/widgets/sectionHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:space_y/blocs/booking_bloc.dart';
import 'package:space_y/ui/booking/booked_screen.dart';


class BookingScreen extends StatefulWidget {
  const BookingScreen();
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool checkMassage = false;
  bool checkMeal = false;
  bool checkPool = false;

  String result;
  Booking bloc = Booking();

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
        children: <Widget>[
          header(context, 'Space Tickets'),
          const SizedBox(height: 150,),
          Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text('Massage           ', style: TextStyle(color: Colors.grey), textAlign: TextAlign.center,),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Checkbox(value: checkMassage,
                            activeColor: Colors.red,
                            onChanged:(bool newValue){
                              setState(() {
                                checkMassage = newValue;
                              });
                            }),
                      ],
                    ),
                  ),
                ],
              )
          ),
          Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text('No gravity meal', style: TextStyle(color: Colors.grey), textAlign: TextAlign.center,),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Checkbox(value: checkMeal,
                            activeColor: Colors.red,
                            onChanged:(bool newValue) {
                          setState(() {
                            checkMeal = newValue;
                          });
                        }),
                      ],
                    ),
                  ),
                ],
              )
          ),
          Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text('No gravity pool', style: TextStyle(color: Colors.grey), textAlign: TextAlign.center,),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Checkbox(value: checkPool,
                            activeColor: Colors.red,
                            onChanged:(bool newValue){
                          setState(() {
                            checkPool = newValue;
                          });
                        }),
                      ],
                    ),
                  ),
                ],
              )
          ),
          const SizedBox(height: 50,),
          StreamBuilder<bool>(
              builder: (BuildContext context, AsyncSnapshot<bool> snap){
                return Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      child: ClipOval(
                        child: Material(
                          color: Colors.red,
                          child: InkWell(
                            splashColor: Colors.grey, // inkwell color
                            child: const SizedBox(width: 50, height: 50, child:  Icon(Icons.flight_takeoff, size: 100)),
                            onTap: () async {
                              await bloc.getUserTickets();
                              result = await bloc.sendBooking(massage: checkMassage, meal: checkMeal, pool: checkPool);
                              print(result);
                              if (result != null)
                                Navigator.push<dynamic>(
                                  context,
                                  CupertinoPageRoute<dynamic>(
                                    builder: (_) => const BookedScreen(),
                                  ),
                                );
                            },
                          ),
                        ),
                      ),
                    )
                );
              },
          ),
        ],
      ),
    );
  }
}