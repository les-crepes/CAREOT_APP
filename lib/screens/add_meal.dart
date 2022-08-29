import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/buttons/action_button.dart';
import 'package:pdg_app/widgets/cards/main_card.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';
import 'package:image_picker/image_picker.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({Key? key}) : super(key: key);

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  double _hungerBeforeValue = 3;
  double _hungerAfterValue = 3;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

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

  const AddMeal({
    Key? key,
    required double hungerBeforeValue,
    required double hungerAfterValue,
    required void Function(double) onHungerBeforeChanged,
    required void Function(double) onHungerAfterChanged,
    required void Function() onCameraPressed,
    required void Function() onGalleryPressed,
    XFile? image,
  })  : _hungerBeforeValue = hungerBeforeValue,
        _hungerAfterValue = hungerAfterValue,
        _onHungerAfterChanged = onHungerAfterChanged,
        _onHungerBeforeChanged = onHungerBeforeChanged,
        _onCameraPressed = onCameraPressed,
        _onGalleryPressed = onGalleryPressed,
        _image = image,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    const double height = 250;
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
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
                            ? const NetworkImage(
                                    "https://www.washingtonian.com/wp-content/uploads/2021/07/2Fiftys-1500x1000.jpg")
                                as ImageProvider
                            : XFileImage(_image!),
                      ),
                    ),
                  ),
                  _PictureSelector(
                    onCameraPress: _onCameraPressed,
                    onImageSelectPress: _onGalleryPressed,
                  ),
                ],
              ),
            ),
            Expanded(
              child: _ListView(
                hungerAfterValue: _hungerAfterValue,
                hungerBeforeValue: _hungerBeforeValue,
                onHungerAfterChanged: _onHungerAfterChanged,
                onHungerBeforeChanged: _onHungerBeforeChanged,
              ),
            ),
          ],
        ),
        const ActionButton(icon: Icons.check),
      ],
    );
  }
}

class _PictureSelector extends StatelessWidget {
  final void Function()? _onCameraPress;
  final void Function()? _onImageSelectPress;

  const _PictureSelector({
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
              _IconButton(
                icon: Icons.camera_alt,
                onTap: _onCameraPress,
              ),
              _IconButton(
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

class _IconButton extends StatelessWidget {
  final IconData _icon;
  final void Function()? _onTap;

  const _IconButton({
    Key? key,
    required IconData icon,
    void Function()? onTap,
  })  : _icon = icon,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCard(
      child: InkWell(
        onTap: _onTap,
        child: SizedBox(
          height: 40,
          width: 40,
          child: Icon(_icon),
        ),
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  final double _hungerBeforeValue;
  final double _hungerAfterValue;
  final void Function(double) _onHungerBeforeChanged;
  final void Function(double) _onHungerAfterChanged;

  const _ListView({
    Key? key,
    required double hungerBeforeValue,
    required double hungerAfterValue,
    required void Function(double) onHungerBeforeChanged,
    required void Function(double) onHungerAfterChanged,
  })  : _hungerBeforeValue = hungerBeforeValue,
        _hungerAfterValue = hungerAfterValue,
        _onHungerAfterChanged = onHungerAfterChanged,
        _onHungerBeforeChanged = onHungerBeforeChanged,
        super(key: key);

  List<Widget> listViewContent(BuildContext context) => [
        const Text("Add a meal"),
        const MainTextField(
          name: "Meal name",
          icon: Icon(
            Icons.label,
            color: Colors.black,
          ),
        ),
        const MainTextField(
          name: "Start time",
          icon: Icon(
            Icons.timer,
            color: Colors.black,
          ),
        ),
        const MainTextField(
          name: "End time",
          icon: Icon(
            Icons.timer,
            color: Colors.black,
          ),
        ),
        buildSliderWithText(
          context,
          "Rate your hunger before eating",
          _hungerBeforeValue,
          _onHungerBeforeChanged,
          ["encore faim", "inconfort", "léger inconfort", "confort"],
        ),
        buildSliderWithText(
          context,
          "Rate your satiety after eating",
          _hungerAfterValue,
          _onHungerAfterChanged,
          ["encore faim", "inconfort", "léger inconfort", "confort"],
        ),
      ];

  MainCard buildSliderWithText(
    BuildContext context,
    String text,
    double value,
    void Function(double)? onChanged,
    List<String> labels,
  ) {
    return MainCard(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.local_dining),
                const SizedBox(width: 10),
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: const Color(0xFF5B5B5B), fontSize: 15),
                ),
              ],
            ),
          ),
          Slider(
            value: value,
            onChanged: onChanged,
            divisions: labels.length - 1,
            label: labels[value.floor()],
            min: 0,
            max: labels.length.toDouble() - 1,
          ),
        ],
      ),
    );
  }

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
