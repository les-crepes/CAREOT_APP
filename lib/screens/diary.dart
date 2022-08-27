import 'package:flutter/material.dart';
import 'package:pdg_app/model/meal.dart';
import 'package:pdg_app/widgets/home/top_shape.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pdg_app/widgets/cards/arrow_pic_card.dart';

import '../widgets/home/home_top_bar.dart';
import 'package:intl/intl.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Diary();
  }
}

class Diary extends StatefulWidget {
  final double screenWidth;
  final bool showActionButton;

  const Diary({
    this.screenWidth = 0,
    this.showActionButton = true,
    Key? key,
  }) : super(key: key);

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  late final ValueNotifier<List<Meal>> _selectedEvents;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  List<Meal> _getEventsForDay(DateTime day) {
    return [
      Meal(
          startTime: DateTime(2022, 8, 26, 12),
          endTime: DateTime(2022, 8, 26, 12, 30),
          comment: "Déjeuner"),
      Meal(
          startTime: DateTime(2022, 8, 26, 19),
          endTime: DateTime(2022, 8, 26, 19, 30),
          comment: "Souper"),
      Meal(
          startTime: DateTime(2022, 8, 26, 19),
          endTime: DateTime(2022, 8, 26, 19, 30),
          comment: "Souper"),
      Meal(
          startTime: DateTime(2022, 8, 26, 19),
          endTime: DateTime(2022, 8, 26, 19, 30),
          comment: "Souper")
    ];
  }

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

    final DateFormat hourFormatter = DateFormat('HH:mm');

    return Stack(children: [
      Column(
        children: [
          HomeTopBar(background: background, height: height),
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
                return _getEventsForDay(day);
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
          const SizedBox(height: 13),
          Expanded(
            child: ValueListenableBuilder<List<Meal>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 4.0,
                      ),
                      child: ArrowPicCard(
                        title: Text(value[index].comment!,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text(
                          "${hourFormatter.format(value[index].startTime!)} - ${hourFormatter.format(value[index].endTime!)}",
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      if (widget.showActionButton)
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                      spreadRadius: 0,
                    ),
                  ], shape: BoxShape.circle),
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    onPressed: (() => 1),
                    elevation: 100,
                    child: Icon(Icons.add,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 35),
                  ),
                ),
                const SizedBox(width: 20)
              ],
            ),
            const SizedBox(height: 20)
          ],
        )
    ]);
  }
}
