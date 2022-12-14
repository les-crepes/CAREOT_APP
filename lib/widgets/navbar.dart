import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);

    return GNav(
      color: Theme.of(context).colorScheme.onSecondary,
      activeColor: Theme.of(context).colorScheme.onSecondary,
      duration: const Duration(milliseconds: 400),
      tabBackgroundColor: Theme.of(context).colorScheme.secondary,
      gap: 6,
      haptic: true,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      tabMargin: const EdgeInsets.symmetric(vertical: 13, horizontal: 25),
      backgroundColor: Theme.of(context).colorScheme.surface,
      tabs: const [
        GButton(
          icon: Icons.chat_bubble_outline,
          text: "Chat",
        ),
        GButton(
          icon: Icons.calendar_month_outlined,
          text: "Diary",
        ),
        GButton(
          icon: Icons.account_circle_outlined,
          text: "Profile",
        )
      ],
      selectedIndex: _selectedIndex,
      onTabChange: (index) {
        setState(() {
          _selectedIndex = index;
          tabsRouter.setActiveIndex(index);
        });
      },
    );
  }
}
