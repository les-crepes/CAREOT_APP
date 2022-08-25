import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pdg_app/main.dart';
import 'package:pdg_app/screens/login.dart';
import 'package:pdg_app/widgets/cards/pic_card.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';
import 'package:pdg_app/widgets/gradient_button.dart';
import 'package:pdg_app/widgets/cards/main_card.dart';
import 'package:pdg_app/widgets/right_arrow_button.dart';
import 'package:widgetbook/widgetbook.dart';

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

    var mainCard = WidgetbookComponent(name: 'Main card', useCases: [
      WidgetbookUseCase(
          name: 'Default',
          builder: (context) => MainCard(
              child: Text(
                  context.knobs.text(label: 'text', initialValue: "coucou"))))
    ]);

    var picCard = WidgetbookComponent(
      name: 'Picture card',
      useCases: [
        WidgetbookUseCase(
          name: 'Default',
          builder: (context) => PicCard(
            title: context.knobs.text(
              label: 'title',
              initialValue: "Déjeuner",
            ),
            subtitle: context.knobs.text(
              label: 'subtitle',
              initialValue: "8h30-9h00",
            ),
          ),
        )
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
                mainCard,
                picCard
              ],
            ),
          ],
        ),
        WidgetbookCategory(
          name: 'Screens',
          widgets: [
            login,
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
