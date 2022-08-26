import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pdg_app/screens/chat.dart';
import 'package:pdg_app/screens/login.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';
import 'package:pdg_app/widgets/gradient_button.dart';
import 'package:pdg_app/widgets/right_arrow_button.dart';
import 'package:widgetbook/widgetbook.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:pdg_app/theme.dart';

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textFieldComponent =
        WidgetbookComponent(name: 'Main text field', useCases: [
      WidgetbookUseCase(
          name: 'Email',
          builder: (context) => MainTextField(
                name: context.knobs.text(label: 'text', initialValue: 'Email'),
                icon: const Icon(Icons.email_outlined),
              ))
    ]);

    var gradientButton = WidgetbookComponent(
      name: 'Gradient Button',
      useCases: [
        WidgetbookUseCase(
          name: 'Default',
          builder: (context) => GradientButton(
            color1: const Color(0xFFFFBD70),
            color2: const Color(0xFFFF9877),
            onPress: () {
              log("coucou");
            },
            child: Text(
                context.knobs.text(label: 'text', initialValue: 'Login'),
                style: Theme.of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
          ),
        ),
      ],
    );

    var rightArrowButton = WidgetbookComponent(
      name: 'Right Arrow Button',
      useCases: [
        WidgetbookUseCase(
          name: 'Default',
          builder: (context) => RightArrowButton(
              text: context.knobs.text(label: 'label', initialValue: 'Login')),
        ),
      ],
    );

    var login = WidgetbookComponent(
      name: 'Login',
      useCases: [
        WidgetbookUseCase(
          name: 'Default',
          builder: (context) {
            return const Login(screenWidth: 400);
          },
        ),
      ],
    );

    var chat = WidgetbookComponent(
      name: 'Chat',
      useCases: [
        WidgetbookUseCase(
          name: 'Default',
          builder: (context) {
            return ChatInterface(
              messages: const [],
              currentUser:
                  const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3af'),
              name: "test",
              onSendPressed: (types.PartialText p) {},
            );
          },
        ),
      ],
    );

    return Widgetbook.material(
      categories: [
        WidgetbookCategory(
          name: 'widgets',
          folders: [
            WidgetbookFolder(
              name: 'Components',
              widgets: [
                textFieldComponent,
                gradientButton,
                rightArrowButton,
              ],
            ),
          ],
        ),
        WidgetbookCategory(
          name: 'Screens',
          widgets: [
            login,
            chat,
          ],
        ),
      ],
      appInfo: AppInfo(
        name: 'Widgetbook Example',
      ),
      themes: [
        WidgetbookTheme(
          name: 'Light',
          data: CustomTheme.lightTheme,
        ),
        WidgetbookTheme(
          name: 'Dark',
          data: ThemeData.dark(),
        ),
      ],
      devices: [
        Samsung.s21ultra,
      ],
    );
  }
}
