import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';
import 'package:pdg_app/widgets/gradient_button.dart';
import 'package:pdg_app/widgets/right_arrow_button.dart';

import '../router/router.gr.dart';
import '../widgets/login/bottom_shape.dart';
import '../widgets/login/top_shape.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Login(
        onLoginPress: () =>
            AutoRouter.of(context).navigate(const RegisterScreenRoute()));
  }
}

class Login extends StatelessWidget {
  final void Function()? onLoginPress;

  const Login({
    this.onLoginPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final background = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomPaint(
          size: Size(
            width,
            width * 0.15,
          ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: const TopShape(),
        ),
        CustomPaint(
          size: Size(
            width,
            width * 0.15,
          ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: const BottomShape(),
        ),
      ],
    );
    return Stack(
      children: [
        background,
        Column(
          children: [
            SizedBox(height: width * 0.07),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 60.0),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.orange,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome...',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                            'Please sign in to continue',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const MainTextField(
                    name: 'email',
                    icon: Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: 20),
                  const MainTextField(
                    name: 'password',
                    icon: Icon(Icons.lock_outlined),
                    obscureText: true,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [RightArrowButton(text: 'Login')],
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
