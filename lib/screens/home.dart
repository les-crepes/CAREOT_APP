import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pdg_app/router/router.gr.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        ChatScreenRoute(),
        DiaryScreenRoute(),
        ProfileScreenRoute(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: FadeTransition(
            opacity: animation,
            child: child,
          ),
          bottomNavigationBar: GNav(
            rippleColor: Theme.of(context).colorScheme.secondary,
            hoverColor: Theme.of(context).colorScheme.secondary,
            color: Theme.of(context).colorScheme.onSecondary,
            activeColor: Theme.of(context).colorScheme.onSecondary,
            duration: const Duration(milliseconds: 900),
            tabBackgroundColor: Theme.of(context).colorScheme.secondary,
            gap: 8,
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
            tabMargin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
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
          ),
        );
      },
    );
  }
}
