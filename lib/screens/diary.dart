import 'package:auto_route/auto_route.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pdg_app/model/meal.dart';
import 'package:pdg_app/provider/meal_provider.dart';
import 'package:pdg_app/router/router.gr.dart';
import 'package:pdg_app/widgets/cards/arrow_pic_card.dart';
import 'package:pdg_app/widgets/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../model/user.dart';
import '../api/firebase_file.dart';
import 'package:tuple/tuple.dart';
import '../api/ifile.dart';
import '../provider/auth_provider.dart';
import '../widgets/buttons/action_button.dart';
import '../widgets/diary/diary_top_bar.dart';
import '../widgets/diary/top_shape.dart';

class DiaryScreen extends StatefulWidget {
  final User? _client;

  const DiaryScreen({
    User? client,
    Key? key,
  })  : _client = client,
        super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  DateTime _selectedDate = DateTime.now();
  IFile fileApi = FirebaseFile(FirebaseStorage.instance);
  final LoadingOverlayController _loadingOverlayController =
      LoadingOverlayController();
  late MealProvider mealProvider;

  @override
  void dispose() {
    if (GetIt.I.get<AuthProvider>().isAdmin) {
      mealProvider.stopNewDiaryListener();
    }
    super.dispose();
  }

  List<Meal> _getEventsForDay(BuildContext context, DateTime day) {
    return context.read<MealProvider>().meals;
  }

  @override
  Widget build(BuildContext context) {
    final uid = context.read<AuthProvider>().userUid;
    final isAdmin = context.read<AuthProvider>().isAdmin;

    return Container(
      color: Colors.white,
      child: ChangeNotifierProvider(
        create: (context) => MealProvider(!isAdmin ? uid : widget._client!.uid),
        builder: (context, child) {
          context.watch<MealProvider>().meals;

          mealProvider = context.read<MealProvider>();
          AuthProvider authProvider = GetIt.I.get<AuthProvider>();

          if (isAdmin) {
            mealProvider.startNewDiaryListener(
                widget._client!.uid, _selectedDate);
          }

          return LoadingOverlay(
            controller: _loadingOverlayController,
            child: Diary(
                onDaySelected: (date) {
                  _selectedDate = date;
                  if (isAdmin) {
                    mealProvider.stopNewDiaryListener();
                    mealProvider.startNewDiaryListener(
                        widget._client!.uid, date);
                  }
                },
                getDiariesForDay: (day) {
                  return _getEventsForDay(context, day);
                },
                clientName: !isAdmin
                    ? GetIt.I.get<AuthProvider>().user!.firstName
                    : widget._client!.firstName,
                clientPicturePath: !isAdmin
                    ? authProvider.user!.photoUrl
                    : widget._client!.photoUrl,
                defaultUserPic: "assets/images/default_user_pic.png",
                showActionButton: !isAdmin,
                defaultMealPic: "assets/images/breakfast.jpg",
                onAddPressed: () async {
                  final addedMeal = await AutoRouter.of(context)
                      .push<Tuple2<Meal?, XFile?>>(
                          AddMealScreenRoute(day: _selectedDate));
                  _loadingOverlayController.showLoadingOverlay();
                  if (addedMeal != null) {
                    await mealProvider.addMeal(
                        addedMeal.item1!, addedMeal.item2);
                    mealProvider.fetchMeals();
                  }
                  _loadingOverlayController.hideLoadingOverlay();
                },
                onMealBlocPressed: (Meal meal) async {
                  final changedMeal = await AutoRouter.of(context)
                      .push<Tuple2<Meal?, XFile?>>(
                          AddMealScreenRoute(day: _selectedDate, meal: meal));
                  _loadingOverlayController.showLoadingOverlay();
                  if (changedMeal != null) {
                    await mealProvider.updateMeal(
                        changedMeal.item1!, changedMeal.item2);
                    mealProvider.fetchMeals();
                  }
                  _loadingOverlayController.hideLoadingOverlay();
                }),
          );
        },
      ),
    );
  }
}

class Diary extends StatefulWidget {
  final double screenWidth;
  final bool showActionButton;
  final List<Meal> Function(DateTime) getDiariesForDay;
  final String clientName;
  final String? clientPicturePath;
  final void Function()? _onAddPressed;
  final void Function(DateTime)? _onDaySelected;
  final void Function(Meal)? _onMealBlocPressed;
  final String _defaultUserPic;
  final String _defaultMealPic;

  const Diary({
    this.screenWidth = 0,
    this.showActionButton = true,
    required this.getDiariesForDay,
    required this.clientName,
    this.clientPicturePath,
    void Function(DateTime)? onDaySelected,
    void Function()? onAddPressed,
    void Function(Meal)? onMealBlocPressed,
    required String defaultUserPic,
    required String defaultMealPic,
    Key? key,
  })  : _onAddPressed = onAddPressed,
        _onDaySelected = onDaySelected,
        _onMealBlocPressed = onMealBlocPressed,
        _defaultUserPic = defaultUserPic,
        _defaultMealPic = defaultMealPic,
        super(key: key);

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
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
            defaultUserPic: widget._defaultUserPic,
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
              if (widget._onDaySelected != null) {
                widget._onDaySelected!(selectedDay);
              }
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
            eventLoader: context.read<MealProvider>().getMealsByDay,
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
            child: _CalendarBody(
              defaultMealPic: widget._defaultMealPic,
              hourFormatter: hourFormatter,
              meals: context.read<MealProvider>().getMealsByDay(_selectedDay),
              onMealBlocPressed: widget._onMealBlocPressed,
            ),
          ),
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
  final void Function(Meal)? onMealBlocPressed;
  final String defaultMealPic;

  const _CalendarBody({
    required this.meals,
    Key? key,
    required this.hourFormatter,
    required this.defaultMealPic,
    this.onMealBlocPressed,
  }) : super(key: key);

  final DateFormat hourFormatter;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: meals.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: onMealBlocPressed != null
              ? (() => onMealBlocPressed!(meals[index]))
              : () {},
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 4.0,
            ),
            child: ArrowPicCard(
              image: meals[index].photo != null
                  ? NetworkImage(meals[index].photo!)
                  : null,
              defaultUserPic: AssetImage(defaultMealPic),
              title: Text(meals[index].title,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(
                "${hourFormatter.format(meals[index].startTime)} - ${hourFormatter.format(meals[index].endTime)}",
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ),
        );
      },
    );
  }
}
