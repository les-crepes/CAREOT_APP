import 'package:flutter/material.dart';
import 'package:pdg_app/model/custom_list_tile_data.dart';

import '../widgets/custom_list.dart';

class DiscussionListScreen extends StatelessWidget {
  const DiscussionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomList(
      conversationsTileData: [
        CustomListTileData(
          title: "test",
          date: DateTime.now(),
          badgeCount: 2,
        ),
      ],
    );
  }
}
