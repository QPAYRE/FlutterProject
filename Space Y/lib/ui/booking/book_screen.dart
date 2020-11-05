import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:space_y/models/ticket_model.dart';
import 'package:space_y/models/tickets_model.dart';

import 'package:space_y/ui/widgets/sectionHeader.dart';
import 'package:space_y/blocs/booking_bloc.dart';
import 'package:space_y/ui/booking/booked_screen.dart';

class BookScreen extends StatefulWidget {
  BookScreen();
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  Booking bloc = Booking();
  bool checkMassage = false;
  bool checkMeal = false;
  bool checkPool = false;

  String result;

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

  StreamBuilder toBook(BuildContext context) {
    return StreamBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        return Column(
          children: [
            const SizedBox(height: 70,),
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
        );
      },
    );
  }

  Future<Tickets> getContent() async {
    final Tickets tickets = await bloc.getUserTickets();
    return tickets;
  }

  Widget booked(BuildContext context, Booking bloc){
    return Container(
      child: FutureBuilder(
        future: getContent(),
        builder: (BuildContext context, AsyncSnapshot<Tickets> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return new Text(
                'loading...',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              );
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return ListView.builder(
                  shrinkWrap: true,
                    itemCount: snapshot.data.tickets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child:
                          Column(
                            children: [
                              const SizedBox(height: 10,),
                              Text(snapshot.data.tickets[index].dateTakeoff
                                  .toString()),
                              const SizedBox(height: 5,),
                              Text('Options :'),
                              const SizedBox(height: 5,),
                              if (snapshot.data.tickets[index].massage == true)
                                Text('Massage'),
                              if (snapshot.data.tickets[index].gravityMeal == true)
                                Text('No gravity meal'),
                              if (snapshot.data.tickets[index].gravityPool == true)
                                Text('No gravity pool'),
                              const SizedBox(height: 10,),
                            ],
                          )
                      );
                    }
                );
          }
        }
      )
    );
  }

  ButtonTheme BookingSectionMenuButton(List menuItem, int section) {
    return ButtonTheme(
      child: FlatButton(
        onPressed: () {
          bloc.changeBookingMenuSection(section);
        },
        child: Text(
          menuItem[0],
          style: TextStyle(
              fontSize: 16,
              fontWeight:
              menuItem[1] == true ? FontWeight.w500 : FontWeight.w400,
              color: Colors.grey),
        ),
      ),
    );
  }

  Row BookinSectionMenu(List<List> menu) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    //SizedBox(,),
                    BookingSectionMenuButton(menu[0], 0),
                    Container(
                      height: 2,
                      width: 124,
                      color: menu[0][1] == true
                          ? Theme.of(context).accentColor
                          : Colors.transparent,
                    ),
                  ],
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BookingSectionMenuButton(menu[1], 1),
                    Container(
                      height: 2,
                      width: 150,
                      color: menu[1][1] == true
                          ? Theme.of(context).accentColor
                          : Colors.transparent,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: 279,
              height: 2,
              color: Colors.grey[200],
            ),
          ],
        ),
      ],
    );
  }

  StreamBuilder sectionSelector(BuildContext context) {
    return StreamBuilder(
      initialData: bloc.BookingMenuButtons,
      stream: bloc.changeBookingSection,
      builder: (context, snapshot) {
        final List<List> menu = snapshot.data as List<List>;
        return Container(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20,),
              BookinSectionMenu(menu),
              menu[0][1] == true ? toBook(context) : booked(context, bloc),
            ],
          ),
        );
      },
    );
  }

  Container buildBookingView(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: <Widget>[
          sectionSelector(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: <Widget>[
          header(context, 'Space Tickets'),
          buildBookingView(context),
        ],
      ),
      //bottomNavigationBar: loadingUserAdsBar(adsBloc),
    );
  }
}
