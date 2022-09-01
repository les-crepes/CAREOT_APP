import 'package:flutter/material.dart';
import 'package:pdg_app/model/custom_list_tile_data.dart';

import '../widgets/custom_list.dart';

class DocumentListScreen extends StatelessWidget {
  const DocumentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomList(
      title: "Documents",
      conversationsTileData: [
        CustomListTileData(
          avatar: const Icon(
            Icons.document_scanner,
            size: 40,
          ),
          title: "test",
          date: DateTime.now(),
        ),
      ],
    );
  }
}
