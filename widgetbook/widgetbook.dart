// ignore_for_file: avoid_relative_lib_imports

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/gradient_button.dart';
import 'package:pdg_app/widgets/right_arrow_button.dart';
import 'package:widgetbook/widgetbook.dart';

import '../lib/theme.dart';

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return Widgetbook.material(
      categories: [
        WidgetbookCategory(
          name: 'widgets',
          folders: [
            WidgetbookFolder(
              name: 'Components',
              widgets: [
                gradientButton,
                rightArrowButton,
              ],
            ),
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
        Apple.iPhone11,
        Samsung.s21ultra,
      ],
    );
  }
}