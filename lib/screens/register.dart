import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';
import 'package:pdg_app/widgets/register/top_shape.dart';
import 'package:pdg_app/widgets/register/bottom_shape.dart';

import '../router/router.gr.dart';
import '../widgets/buttons/right_arrow_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Register(
        onRegisterPress: () =>
            AutoRouter.of(context).navigate(const RegisterScreenRoute()),
      ),
    );

    /// Navigating to the RegisterScreenRoute.
  }
}

class Register extends StatelessWidget {
  final void Function()? onRegisterPress;
  final double screenWidth;

  const Register({
    this.screenWidth = 0,
    this.onRegisterPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width =
        screenWidth == 0 ? MediaQuery.of(context).size.width : screenWidth;
    final items = [
      const MainTextField(name: 'Email', icon: Icon(Icons.email_outlined)),
      const MainTextField(name: 'Password', icon: Icon(Icons.lock_outline)),
      const MainTextField(name: 'Firstname', icon: Icon(Icons.person)),
      const MainTextField(name: 'Lastname', icon: Icon(Icons.person)),
      const MainTextField(
          name: 'Phone', icon: Icon(Icons.phone_android_outlined)),
      const MainTextField(name: 'Birthdate', icon: Icon(Icons.cake_outlined)),
      const MainTextField(name: 'insurance', icon: Icon(Icons.house_outlined)),
      RightArrowButton(text: 'REGISTER', onPressed: onRegisterPress),
    ];

    return Stack(
      children: [
        Column(
          children: [
            CustomPaint(
              size: Size(
                  width,
                  (width * 0.16944444444444445)
                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: TopShape(),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text(
                    'Create account',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                clipBehavior: Clip.none,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                separatorBuilder: (context, i) {
                  return const SizedBox(height: 20);
                },
                itemCount: items.length,
                itemBuilder: (context, i) {
                  return items[i];
                },
              ),
            ),
            CustomPaint(
              size: Size(
                  width,
                  (width * 0.21944444444444444)
                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: BottomShape(),
            ),
          ],
        )
      ],
    );
  }
}
