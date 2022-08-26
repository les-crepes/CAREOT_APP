import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/home/top_shape.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}

class Home extends StatefulWidget {
  final double screenWidth;

  const Home({
    this.screenWidth = 0,
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    final width = widget.screenWidth == 0
        ? MediaQuery.of(context).size.width
        : widget.screenWidth;

    final height = (width * 0.6027777777777777).toDouble();

    final background = CustomPaint(
      size: Size(width,
          height), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
      painter: HomeTopShape(),
    );

    return Column(
      children: [
        Stack(children: [
          background,
          Container(
            // color: Colors.red,
            alignment: Alignment.center,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 45,
                ),
                SizedBox(height: 15),
                Text(
                  "Hello Anna",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ]),
        TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2050, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              return [];
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle),
                todayTextStyle:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
                selectedDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle))),
      ],
    );
  }
}
