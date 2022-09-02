import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/router/router.gr.dart';
import 'package:provider/provider.dart';

import '../../provider/register_provider.dart';
import '../forms/main_text_field.dart';
import '../right_arrow_button.dart';

class RegisterThirdPage extends StatefulWidget {
  const RegisterThirdPage({Key? key}) : super(key: key);

  @override
  State<RegisterThirdPage> createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  List<Widget> buildInputs(BuildContext context) {
    final registerProvider = context.watch<RegisterProvider>();

    return [
      MainTextField(
        name: 'Phone',
        icon: const Icon(Icons.phone_android_outlined),
        keyboardType: TextInputType.phone,
        controller: registerProvider.phoneController,
      ),
      MainTextField(
        name: 'insurance',
        icon: const Icon(Icons.house_outlined),
        keyboardType: TextInputType.text,
        controller: registerProvider.insuranceController,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 200,
            child: RightArrowButton(
              text: 'Register',
              onPressed: () =>
                  AutoRouter.of(context).push(const RegisterThirdPageRoute()),
            ),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final content = buildInputs(context);

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      separatorBuilder: (context, index) => const SizedBox(height: 30),
      itemCount: content.length,
      itemBuilder: (context, index) {
        return content[index];
      },
    );
  }
}
