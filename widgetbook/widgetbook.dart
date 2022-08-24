// ignore_for_file: avoid_relative_lib_imports

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../lib/theme.dart';

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      categories: [
        WidgetbookCategory(
          name: 'widgets',
          widgets: [
            WidgetbookComponent(
              name: 'un widget',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const Text("data"),
                ),
              ],
            ),
          ],
          folders: [
            WidgetbookFolder(
              name: 'Texts',
              widgets: [
                WidgetbookComponent(
                  name: 'Normal Text',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default',
                      builder: (context) => const Text(
                        'The brown fox ...',
                      ),
                    ),
                  ],
                ),
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
