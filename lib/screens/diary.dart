import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdg_app/model/meal.dart';
import 'package:pdg_app/router/router.gr.dart';
import 'package:pdg_app/widgets/cards/arrow_pic_card.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/buttons/action_button.dart';
import '../widgets/diary/diary_top_bar.dart';
import '../widgets/diary/top_shape.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  static List<Meal> _getEventsForDay(DateTime day) {
    return [
      Meal(
          startTime: DateTime(2022, 8, 26, 12),
          endTime: DateTime(2022, 8, 26, 12, 30),
          comment: "Déjeuner",
          title: 'Déjeuner',
          satiety: 5,
          hunger: 2,
          owner: ''),
      Meal(
          startTime: DateTime(2022, 8, 26, 19),
          endTime: DateTime(2022, 8, 26, 19, 30),
          comment: "Souper",
          title: 'Souper',
          satiety: 5,
          hunger: 2,
          owner: ''),
      Meal(
          startTime: DateTime(2022, 8, 26, 19),
          endTime: DateTime(2022, 8, 26, 19, 30),
          comment: "Souper",
          title: 'Souper',
          satiety: 2,
          hunger: 5,
          owner: ''),
      Meal(
          startTime: DateTime(2022, 8, 26, 19),
          endTime: DateTime(2022, 8, 26, 19, 30),
          comment: "Souper",
          title: 'Souper',
          satiety: 2,
          hunger: 3,
          owner: '')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Diary(
      getDiariesForDay: _getEventsForDay,
      clientName: "Marie",
      onAddPressed: () {
        AutoRouter.of(context).navigate(const AddMealScreenRoute());
      },
    );
  }
}

class Diary extends StatefulWidget {
  final double screenWidth;
  final bool showActionButton;
  final List<Meal> Function(DateTime) getDiariesForDay;
  final String clientName;
  final String clientPicturePath;
  final void Function()? _onAddPressed;

  const Diary({
    this.screenWidth = 0,
    this.showActionButton = true,
    required this.getDiariesForDay,
    required this.clientName,
    this.clientPicturePath = "assets/images/default_user_pic.png",
    void Function()? onAddPressed,
    Key? key,
  })  : _onAddPressed = onAddPressed,
        super(key: key);

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  late final ValueNotifier<List<Meal>> _selectedDiaries;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedDiaries = ValueNotifier(widget.getDiariesForDay(_selectedDay));
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
      painter: DiaryTopShape(),
    );

    final DateFormat hourFormatter = DateFormat('HH:mm');

    return Stack(children: [
      Column(
        children: [
          DiaryTopBar(
            background: background,
            height: height,
            clientName: widget.clientName,
            clientPicturePath: widget.clientPicturePath,
          ),
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
            eventLoader: widget.getDiariesForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle),
              todayTextStyle:
                  TextStyle(color: Theme.of(context).colorScheme.onSurface),
              selectedDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle),
            ),
          ),
          const SizedBox(height: 13),
          Expanded(
            child: ValueListenableBuilder<List<Meal>>(
              valueListenable: _selectedDiaries,
              builder: (context, value, _) {
                return _CalendarBody(
                  hourFormatter: hourFormatter,
                  meals: value,
                );
              },
            ),
          )
        ],
      ),
      if (widget.showActionButton)
        ActionButton(
          icon: Icons.add,
          onPressed: widget._onAddPressed,
        )
    ]);
  }
}

class _CalendarBody extends StatelessWidget {
  final List<Meal> meals;

  const _CalendarBody({
    required this.meals,
    Key? key,
    required this.hourFormatter,
  }) : super(key: key);

  final DateFormat hourFormatter;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: meals.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 4.0,
          ),
          child: ArrowPicCard(
            title: Text(meals[index].comment!,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(
              "${hourFormatter.format(meals[index].startTime)} - ${hourFormatter.format(meals[index].endTime)}",
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
        );
      },
    );
  }
}
