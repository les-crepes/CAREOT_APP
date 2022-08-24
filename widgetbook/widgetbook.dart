// ignore_for_file: avoid_relative_lib_imports

import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/gradient_button.dart';
import 'package:widgetbook/widgetbook.dart';

import '../lib/theme.dart';

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgetbookComponent = WidgetbookComponent(
      name: 'Gradient Button',
      useCases: [
        WidgetbookUseCase(
          name: 'Default',
          builder: (context) => GradientButton(
            color1: const Color(0xFFFFBD70),
            color2: const Color(0xFFFF9877),
            child:
                Text(context.knobs.text(label: 'text', initialValue: 'Login')),
          ),
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
                widgetbookComponent,
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
      ],
      devices: [
        Apple.iPhone11,
        Samsung.s21ultra,
      ],
    );
  }
}
