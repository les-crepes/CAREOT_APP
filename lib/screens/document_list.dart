import 'package:flutter/material.dart';
import 'package:pdg_app/model/custom_list_tile_data.dart';
import 'package:pdg_app/provider/chat_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/user.dart';
import '../widgets/custom_list.dart';

class DocumentListScreen extends StatelessWidget {
  final User _user;
  const DocumentListScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.read<ChatProvider>();

    return Container(
      color: Colors.white,
      child: CustomList(
        title: "Documents",
        conversationsTileData: chatProvider
            .getAllFilesOfConversation(_user)
            .map(
              (m) => CustomListTileData(
                avatar: const Icon(
                  Icons.description_outlined,
                  size: 40,
                ),
                // Le contenu du message est raccourci car sinon il ne rentre pas dans la liste
                title: m.content.substring(
                    0, m.content.length < 15 ? m.content.length : 15),
                date: m.time,
                onTap: () {
                  final Uri url = Uri.parse(m.fileUrl!);
                  launchUrl(url, mode: LaunchMode.externalApplication);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
