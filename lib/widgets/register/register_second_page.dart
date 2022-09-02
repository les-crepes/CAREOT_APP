import 'package:auto_route/auto_route.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../provider/register_provider.dart';
import '../../router/router.gr.dart';
import '../forms/main_text_field.dart';
import '../buttons/right_arrow_button.dart';

class RegisterSecondPage extends StatelessWidget {
  RegisterSecondPage({Key? key}) : super(key: key);

  final ImagePicker _picker = ImagePicker();

  Future<XFile?> _takePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image;
  }

  List<Widget> buildInputs(BuildContext context) {
    final registerProvider = context.watch<RegisterProvider>();
    return [
      InkWell(
        onTap: () async {
          registerProvider.profilePicture = await _takePicture();
        },
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 60,
          child: ClipOval(
            child: registerProvider.profilePicture != null
                ? Image(
                    image: XFileImage(registerProvider.profilePicture!),
                    fit: BoxFit.cover,
                    height: 120,
                    width: 120,
                  )
                : const Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                    size: 40,
                  ),
          ),
        ),
      ),
      MainTextField(
        name: 'Firstname',
        icon: const Icon(Icons.person),
        keyboardType: TextInputType.name,
        validator: validateString,
        controller: registerProvider.firstnameController,
      ),
      MainTextField(
        name: 'Lastname',
        icon: const Icon(Icons.person),
        keyboardType: TextInputType.name,
        controller: registerProvider.lastnameController,
        validator: validateString,
      ),
      const MainTextField(
        name: 'Birthdate',
        icon: Icon(Icons.cake_outlined),
        keyboardType: TextInputType.datetime,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 200,
            child: RightArrowButton(
              text: 'Next',
              onPressed: () {
                if (registerProvider.formPage2.currentState!.validate()) {
                  AutoRouter.of(context).push(const RegisterThirdPageRoute());
                }
              },
            ),
          ),
        ],
      ),
    ];
  }

  String? validateString(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final content = buildInputs(context);

    return Form(
      key: context.read<RegisterProvider>().formPage2,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (context, index) => const SizedBox(height: 30),
        itemCount: content.length,
        itemBuilder: (context, index) {
          return content[index];
        },
      ),
    );
  }
}
