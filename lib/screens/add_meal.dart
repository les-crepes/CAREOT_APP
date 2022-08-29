import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pdg_app/widgets/buttons/action_button.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';

class AddMealScreen extends StatelessWidget {
  const AddMealScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AddMeal();
  }
}

class AddMeal extends StatelessWidget {
  const AddMeal({Key? key}) : super(key: key);

  List<Widget> listViewContent(BuildContext context) => const [
        Text("Add a meal"),
        MainTextField(
          name: "name",
          icon: Icon(Icons.label),
        ),
        MainTextField(
          name: "name",
          icon: Icon(Icons.label),
        ),
        MainTextField(
          name: "name",
          icon: Icon(Icons.label),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final listContent = listViewContent(context);

    return Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://www.washingtonian.com/wp-content/uploads/2021/07/2Fiftys-1500x1000.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16.0),
                physics: const BouncingScrollPhysics(),
                itemCount: listContent.length,
                itemBuilder: (context, index) => listContent[index],
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
            ),
          ],
        ),
        const ActionButton(icon: Icons.check),
      ],
    );
  }
}
