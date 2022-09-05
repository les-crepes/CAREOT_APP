import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/buttons/custom_icon_button.dart';
import 'package:pdg_app/widgets/profile/top_shape.dart';

import '../profile_avatar.dart';

class ProfileTopBar extends StatelessWidget {
  final double _width;
  final double _height;
  final String? _clientPicturePath;
  final String _clientFirstName;
  final String _clientLastName;
  final void Function()? _onIconButtonPress;
  final IconData? _buttonIcon;
  final String _defaultUserPic;

  const ProfileTopBar({
    Key? key,
    required width,
    required height,
    required String? clientPicturePath,
    required String clientFirstName,
    required String clientLastName,
    void Function()? onIconButtonPress,
    required String defaultUserPic,
    buttonIcon,
  })  : _width = width,
        _height = height,
        _clientPicturePath = clientPicturePath,
        _clientFirstName = clientFirstName,
        _clientLastName = clientLastName,
        _onIconButtonPress = onIconButtonPress,
        _buttonIcon = buttonIcon,
        _defaultUserPic = defaultUserPic,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(_width, _height),
          painter: ProfileTopShape(),
        ),
        Container(
          alignment: Alignment.center,
          height: _height + 35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _clientPicturePath != null
                  ? ProfileAvatar(image: NetworkImage(_clientPicturePath!))
                  : ProfileAvatar(image: AssetImage(_defaultUserPic)),
              const SizedBox(height: 8),
              Text(
                "$_clientFirstName $_clientLastName",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 19,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        _buttonIcon != null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomIconButton(
                            icon: _buttonIcon!,
                            onTap: _onIconButtonPress,
                          ),
                        ],
                      ),
                    ]),
              )
            : const SizedBox(),
      ],
    );
  }
}
