// ignore_for_file: avoid_relative_lib_imports

import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';
import 'package:widgetbook/widgetbook.dart';

import '../lib/theme.dart';

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

    return Widgetbook.material(
      categories: [
        WidgetbookCategory(
          name: 'widgets',
          folders: [
            WidgetbookFolder(
              name: 'Components',
              widgets: [
                textFieldComponent,
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
