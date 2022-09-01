import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/custom_list_tile_data.dart';
import 'badge.dart';

class CustomList extends StatelessWidget {
  final List<CustomListTileData> _conversationsTileData;
  final String _title;

  const CustomList({
    required List<CustomListTileData> conversationsTileData,
    required String title,
    Key? key,
  })  : _conversationsTileData = conversationsTileData,
        _title = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('h:m:s d/m/y');
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 70,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xFFFFBD70),
                Color(0xFFFF9877),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  _title,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              final conv = _conversationsTileData[index];
              return _CustomListTile(
                avatar: conv.avatar ??
                    const Image(
                        image:
                            AssetImage('assets/images/default_user_pic.png')),
                title: conv.title ?? 'Conversation ${index + 1}',
                subtitle: conv.date != null
                    ? format.format(conv.date!)
                    : 'No messages yet',
                badgeCount: _conversationsTileData[index].badgeCount ?? 0,
                onTap: _conversationsTileData[index].onTap,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.black38,
                thickness: 1,
              );
            },
            itemCount: _conversationsTileData.length,
          ),
        ),
      ],
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String _title;
  final String _subtitle;
  final int _badgeCount;
  final Widget _avatar;
  final void Function()? _onTap;

  const _CustomListTile({
    Key? key,
    required String title,
    required String subtitle,
    required int badgeCount,
    required Widget avatar,
    void Function()? onTap,
  })  : _title = title,
        _subtitle = subtitle,
        _badgeCount = badgeCount,
        _avatar = avatar,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListTile(
        onTap: _onTap,
        leading: _avatar,
        trailing: _badgeCount == 0 ? const SizedBox() : Badge(_badgeCount),
        title: Text(_title),
        subtitle: Text(_subtitle),
      ),
    );
  }
}
