import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pdg_app/model/meal.dart';
import 'package:pdg_app/screens/chat.dart';
import 'package:pdg_app/screens/diary.dart';
import 'package:pdg_app/screens/login.dart';
import 'package:pdg_app/widgets/buttons/action_button.dart';
import 'package:pdg_app/widgets/cards/arrow_pic_card.dart';
import 'package:pdg_app/widgets/cards/pic_card.dart';
import 'package:pdg_app/screens/register.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';
import 'package:pdg_app/widgets/gradient_button.dart';
import 'package:pdg_app/widgets/cards/main_card.dart';
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
            title: Text(context.knobs.text(
              label: 'title',
              initialValue: "Déjeuner",
            )),
            subtitle: Text(context.knobs.text(
              label: 'subtitle',
              initialValue: "8h30-9h00",
            )),
          ),
        )
      ],
    );

    var arrowPicCard = WidgetbookComponent(
      name: 'Arrow picture card',
      useCases: [
        WidgetbookUseCase(
          name: 'Default',
          builder: (context) => ArrowPicCard(
            title: Text(context.knobs.text(
              label: 'title',
              initialValue: "Déjeuner",
            )),
            subtitle: Text(context.knobs.text(
              label: 'subtitle',
              initialValue: "8h30-9h00",
            )),
          ),
        )
      ],
    );

    var actionButton = WidgetbookComponent(
      name: 'Action button',
      useCases: [
        WidgetbookUseCase(
            name: 'Add',
            builder: (context) => const ActionButton(icon: Icons.add))
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

    var register = WidgetbookComponent(
      name: 'Register',
      useCases: [
        WidgetbookUseCase(
          name: 'Default',
          builder: (context) {
            return const Register(screenWidth: 400);
          },
        ),
      ],
    );

    var diary = WidgetbookComponent(name: 'Diary', useCases: [
      WidgetbookUseCase(
          name: 'Default',
          builder: (context) {
            return Diary(
              getDiariesForDay: (datetime) {
                return [
                  Meal(
                    startTime: DateTime(2022, 8, 26, 12),
                    endTime: DateTime(2022, 8, 26, 12, 30),
                    comment: context.knobs.text(
                      label: 'meal name',
                      initialValue: "Déjeuner",
                    ),
                  )
                ];
              },
              clientName: context.knobs.text(
                label: 'client name',
                initialValue: "Anna",
              ),
            );
          })
    ]);

    return Widgetbook.material(
      appBuilder: (context, child) => Scaffold(
        body: child,
      ),
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
                picCard,
                arrowPicCard,
                actionButton,
              ],
            ),
          ],
        ),
        WidgetbookCategory(
          name: 'Screens',
          widgets: [
            login,
            register,
            chat,
            diary,
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
