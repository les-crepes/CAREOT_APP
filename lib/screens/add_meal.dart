import 'package:auto_route/auto_route.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/provider/auth_provider.dart';
import 'package:pdg_app/widgets/buttons/action_button.dart';
import 'package:pdg_app/widgets/cards/main_card.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../model/meal.dart';
import '../widgets/buttons/custom_icon_button.dart';
import '../widgets/slider_with_text.dart';

class AddMealScreen extends StatefulWidget {
  final DateTime _day;
  final Meal? _meal;

  const AddMealScreen({required DateTime day, Meal? meal, Key? key})
      : _day = day,
        _meal = meal,
        super(key: key);

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

enum _TimeButtonEnum {
  start,
  end,
  none,
}

class _AddMealScreenState extends State<AddMealScreen> {
  double _hungerBeforeValue = 5;
  double _hungerAfterValue = 3;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  _TimeButtonEnum _timeValueToChange = _TimeButtonEnum.none;
  bool _showModal = false;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _settingsController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    if (widget._meal != null) {
      _nameTextController.text = widget._meal!.title;

      if (widget._meal!.setting != null) {
        _settingsController.text = widget._meal!.setting!;
      }

      if (widget._meal!.comment != null) {
        _commentController.text = widget._meal!.comment!;
      }

      _hungerBeforeValue = widget._meal!.hunger.toDouble();
      _hungerAfterValue = widget._meal!.satiety.toDouble();

      _startTime = TimeOfDay.fromDateTime(widget._meal!.startTime);
      _endTime = TimeOfDay.fromDateTime(widget._meal!.endTime);
    }

    super.initState();
  }

  Future<XFile?> _takePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image;
  }

  Future<XFile?> _getPicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return AddMeal(
      nameTextController: _nameTextController,
      settingsController: _settingsController,
      commentController: _commentController,
      hungerBeforeValue: _hungerBeforeValue,
      hungerAfterValue: _hungerAfterValue,
      onHungerAfterChanged: (value) => setState(() {
        _hungerAfterValue = value;
      }),
      onHungerBeforeChanged: (value) => setState(() {
        _hungerBeforeValue = value;
      }),
      image: _image,
      onCameraPressed: () async {
        _image = await _takePicture();
        setState(() {});
      },
      onGalleryPressed: () async {
        _image = await _getPicture();
        setState(() {});
      },
      onTimeSelected: (time) {
        setState(() {
          switch (_timeValueToChange) {
            case _TimeButtonEnum.start:
              _startTime = time;
              break;
            case _TimeButtonEnum.end:
              _endTime = time;
              break;
            default:
              break;
          }

          _showModal = false;
          _timeValueToChange = _TimeButtonEnum.none;
        });
      },
      onTimeSelectCanceled: () {
        setState(() {
          _showModal = false;
          _timeValueToChange = _TimeButtonEnum.none;
        });
      },
      onStartTimeSelected: () {
        setState(() {
          _timeValueToChange = _TimeButtonEnum.start;
          _showModal = true;
        });
      },
      onEndTimeSelected: () {
        setState(() {
          _timeValueToChange = _TimeButtonEnum.end;
          _showModal = true;
        });
      },
      showTimePicker: _showModal,
      startTimeText: _startTime?.format(context) ?? 'Start Time',
      endTimeText: _endTime?.format(context) ?? 'End Time',
      onValidatePressed: () {
        final DateTime selectedStartDate = DateTime(
          widget._day.year,
          widget._day.month,
          widget._day.day,
          _startTime?.hour ?? 0,
          _startTime?.minute ?? 0,
        );

        final DateTime selectedEndDate = DateTime(
          widget._day.year,
          widget._day.month,
          widget._day.day,
          _endTime?.hour ?? 0,
          _endTime?.minute ?? 0,
        );
        if (widget._meal == null) {
          AutoRouter.of(context).pop(Meal(
            title: _nameTextController.text,
            startTime: selectedStartDate,
            endTime: selectedEndDate,
            hunger: _hungerBeforeValue.toInt(),
            satiety: _hungerAfterValue.toInt(),
            setting: _settingsController.text,
            comment: _commentController.text,
            owner: context.read<AuthProvider>().userUid,
          ));
          return;
        }
        AutoRouter.of(context).pop(Meal(
          uid: widget._meal!.uid,
          title: _nameTextController.text,
          startTime: selectedStartDate,
          endTime: selectedEndDate,
          hunger: _hungerBeforeValue.toInt(),
          satiety: _hungerAfterValue.toInt(),
          setting: _settingsController.text,
          comment: _commentController.text,
          owner: context.read<AuthProvider>().userUid,
        ));
      },
    );
  }
}

class AddMeal extends StatelessWidget {
  final double _hungerBeforeValue;
  final double _hungerAfterValue;
  final void Function(double) _onHungerBeforeChanged;
  final void Function(double) _onHungerAfterChanged;
  final void Function() _onCameraPressed;
  final void Function() _onGalleryPressed;
  final XFile? _image;
  final void Function(TimeOfDay) _onTimeSelected;
  final void Function()? _onTimeSelectCanceled;
  final void Function()? _onStartTimeSelected;
  final void Function()? _onEndTimeSelected;
  final bool _showTimePicker;
  final String? _startTimeText;
  final String? _endTimeText;
  final void Function()? _onValidatePressed;
  final TextEditingController? _nameTextController;
  final TextEditingController? _settingsController;
  final TextEditingController? _commentController;

  const AddMeal(
      {Key? key,
      required double hungerBeforeValue,
      required double hungerAfterValue,
      required void Function(double) onHungerBeforeChanged,
      required void Function(double) onHungerAfterChanged,
      required void Function() onCameraPressed,
      required void Function() onGalleryPressed,
      required void Function(TimeOfDay) onTimeSelected,
      void Function()? onStartTimeSelected,
      void Function()? onEndTimeSelected,
      void Function()? onTimeSelectCanceled,
      void Function()? onValidatePressed,
      bool showTimePicker = false,
      String? startTimeText,
      String? endTimeText,
      XFile? image,
      TextEditingController? nameTextController,
      TextEditingController? settingsController,
      TextEditingController? commentController})
      : _hungerBeforeValue = hungerBeforeValue,
        _hungerAfterValue = hungerAfterValue,
        _onHungerAfterChanged = onHungerAfterChanged,
        _onHungerBeforeChanged = onHungerBeforeChanged,
        _onCameraPressed = onCameraPressed,
        _onGalleryPressed = onGalleryPressed,
        _image = image,
        _onTimeSelected = onTimeSelected,
        _onTimeSelectCanceled = onTimeSelectCanceled,
        _onStartTimeSelected = onStartTimeSelected,
        _onEndTimeSelected = onEndTimeSelected,
        _showTimePicker = showTimePicker,
        _startTimeText = startTimeText,
        _endTimeText = endTimeText,
        _onValidatePressed = onValidatePressed,
        _nameTextController = nameTextController,
        _settingsController = settingsController,
        _commentController = commentController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    const double height = 250;
    return Stack(
      children: [
        Column(
          children: [
            _Top(
                height: height,
                image: _image,
                onCameraPressed: _onCameraPressed,
                onGalleryPressed: _onGalleryPressed),
            Expanded(
              child: _ListView(
                nameTextController: _nameTextController,
                settingsController: _settingsController,
                commentController: _commentController,
                hungerAfterValue: _hungerAfterValue,
                hungerBeforeValue: _hungerBeforeValue,
                onHungerAfterChanged: _onHungerAfterChanged,
                onHungerBeforeChanged: _onHungerBeforeChanged,
                onEndTimePress: _onEndTimeSelected,
                onStartTimePress: _onStartTimeSelected,
                endTimeText: _endTimeText,
                startTimeText: _startTimeText,
              ),
            ),
          ],
        ),
        ActionButton(
          icon: Icons.check,
          onPressed: _onValidatePressed,
        ),
        if (_showTimePicker)
          createInlinePicker(
            value: TimeOfDay.now(),
            onChange: _onTimeSelected,
            onCancel: _onTimeSelectCanceled,
            is24HrFormat: true,
            blurredBackground: true,
          ),
      ],
    );
  }
}

class _Top extends StatelessWidget {
  const _Top({
    Key? key,
    required this.height,
    required XFile? image,
    required void Function() onCameraPressed,
    required void Function() onGalleryPressed,
  })  : _image = image,
        _onCameraPressed = onCameraPressed,
        _onGalleryPressed = onGalleryPressed,
        super(key: key);

  final double height;
  final XFile? _image;
  final void Function() _onCameraPressed;
  final void Function() _onGalleryPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: _image == null
                    ? const AssetImage("assets/images/placeholderfood.png")
                        as ImageProvider
                    : XFileImage(_image!),
              ),
            ),
          ),
          _PictureSelectorLayout(
            onCameraPress: _onCameraPressed,
            onImageSelectPress: _onGalleryPressed,
          ),
        ],
      ),
    );
  }
}

class _PictureSelectorLayout extends StatelessWidget {
  final void Function()? _onCameraPress;
  final void Function()? _onImageSelectPress;

  const _PictureSelectorLayout({
    Key? key,
    void Function()? onCameraPress,
    void Function()? onImageSelectPress,
  })  : _onCameraPress = onCameraPress,
        _onImageSelectPress = onImageSelectPress,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomIconButton(
                icon: Icons.camera_alt,
                onTap: _onCameraPress,
              ),
              const SizedBox(width: 8),
              CustomIconButton(
                icon: Icons.image,
                onTap: _onImageSelectPress,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  final double _hungerBeforeValue;
  final double _hungerAfterValue;
  final void Function(double) _onHungerBeforeChanged;
  final void Function(double) _onHungerAfterChanged;
  final void Function()? _onStartTimePress;
  final void Function()? _onEndTimePress;
  final String? _startTimeText;
  final String? _endTimeText;
  final TextEditingController? _nameTextController;
  final TextEditingController? _settingsController;
  final TextEditingController? _commentController;

  const _ListView(
      {Key? key,
      required double hungerBeforeValue,
      required double hungerAfterValue,
      required void Function(double) onHungerBeforeChanged,
      required void Function(double) onHungerAfterChanged,
      void Function()? onStartTimePress,
      void Function()? onEndTimePress,
      String? startTimeText,
      String? endTimeText,
      TextEditingController? nameTextController,
      TextEditingController? settingsController,
      TextEditingController? commentController})
      : _hungerBeforeValue = hungerBeforeValue,
        _hungerAfterValue = hungerAfterValue,
        _onHungerAfterChanged = onHungerAfterChanged,
        _onHungerBeforeChanged = onHungerBeforeChanged,
        _onStartTimePress = onStartTimePress,
        _onEndTimePress = onEndTimePress,
        _startTimeText = startTimeText,
        _endTimeText = endTimeText,
        _nameTextController = nameTextController,
        _settingsController = settingsController,
        _commentController = commentController,
        super(key: key);

  List<Widget> listViewContent(BuildContext context) => [
        Text(
          "Add a meal",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.black),
        ),
        MainTextField(
          name: "Meal name",
          controller: _nameTextController,
          icon: const Icon(
            Icons.label,
            color: Colors.black,
          ),
        ),
        _TimePickerbutton(
          text: _startTimeText ?? "Start Time",
          onTap: _onStartTimePress,
        ),
        _TimePickerbutton(
          text: _endTimeText ?? "End Time",
          onTap: _onEndTimePress,
        ),
        SliderWithText(
            context: context,
            text: "Rate your hunger before eating",
            value: _hungerBeforeValue,
            onChanged: _onHungerBeforeChanged,
            labels: const [
              "0 - not hungry",
              "1",
              "2",
              "3",
              "4",
              "5 - really hungry"
            ]),
        SliderWithText(
            context: context,
            text: "Rate your satiety after eating",
            value: _hungerAfterValue,
            onChanged: _onHungerAfterChanged,
            labels: const [
              "still hungry",
              "discomfort",
              "mild discomfort",
              "comfort"
            ]),
        MainTextField(
          name: "Settings",
          icon: const Icon(Icons.people_alt, color: Colors.black),
          maxLines: null,
          controller: _settingsController,
        ),
        MainTextField(
          name: "Comments",
          icon: const Icon(Icons.comment, color: Colors.black),
          maxLines: null,
          controller: _commentController,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final listContent = listViewContent(context);

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      physics: const BouncingScrollPhysics(),
      itemCount: listContent.length,
      itemBuilder: (context, index) => listContent[index],
      separatorBuilder: (context, index) => const SizedBox(height: 10),
    );
  }
}

class _TimePickerbutton extends StatelessWidget {
  final String _text;
  final void Function()? _onTap;

  const _TimePickerbutton({
    Key? key,
    required String text,
    void Function()? onTap,
  })  : _text = text,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: MainCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
          child: Row(
            children: [
              const Icon(Icons.timer),
              const SizedBox(width: 10),
              Text(
                _text,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: const Color.fromARGB(255, 112, 112, 112),
                      fontSize: 15,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
