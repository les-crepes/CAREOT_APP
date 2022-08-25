import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';
import 'package:pdg_app/widgets/register/top_shape.dart';
import 'package:pdg_app/widgets/register/bottom_shape.dart';
import 'package:pdg_app/widgets/right_arrow_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Register();
  }
}

class Register extends StatelessWidget {
  final double screenWidth;
  const Register({
    this.screenWidth = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width =
        screenWidth == 0 ? MediaQuery.of(context).size.width : screenWidth;
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            const SizedBox(height: 50),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView(
                  clipBehavior: Clip.none,
                  children: const [
                    MainTextField(
                        name: 'Email', icon: Icon(Icons.email_outlined)),
                    SizedBox(height: 20),
                    MainTextField(
                        name: 'Password', icon: Icon(Icons.lock_outline)),
                    SizedBox(height: 20),
                    MainTextField(name: 'Firstname', icon: Icon(Icons.person)),
                    SizedBox(height: 20),
                    MainTextField(name: 'Lastname', icon: Icon(Icons.person)),
                    SizedBox(height: 20),
                    MainTextField(
                        name: 'Phone',
                        icon: Icon(Icons.phone_android_outlined)),
                    SizedBox(height: 20),
                    MainTextField(
                        name: 'Birthdate', icon: Icon(Icons.cake_outlined)),
                    SizedBox(height: 20),
                    MainTextField(
                        name: 'insurance', icon: Icon(Icons.house_outlined)),
                    SizedBox(height: 20),
                    RightArrowButton(text: 'REGISTER'),
                  ],
                ),
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
