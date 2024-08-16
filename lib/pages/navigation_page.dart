import 'package:flutter/material.dart';
import 'package:verifeye/enums/enum.dart';
import 'package:verifeye/pages/home_page.dart';
import 'package:verifeye/helpers/functions/navigate.dart';
import 'package:verifeye/pages/search_page.dart';
import 'package:verifeye/pages/settings_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({
    super.key,
    required this.selectedPage,
    this.tabIndex = 0,
  });
  final NavigationPages selectedPage;
  final int tabIndex;
  @override
  State<NavigationPage> createState() => _NavigationPagestate();
}

class _NavigationPagestate extends State<NavigationPage> {
  int? selectedIndex;
  final Navigate navigate = Navigate();
  @override
  void initState() {
    selectedIndex = navigate.choosePage(widget.selectedPage)['index'];
    super.initState();
  }

  void onItemTapped(int index) {
    setState(
      () {
        selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      const HomePage(),
      const SearchPage(),
      const SettingsPage(),
    ];
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: pages[selectedIndex!],
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height < 800
              ? 70
              : MediaQuery.of(context).size.height > 1000
                  ? 90
                  : 95,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.abc,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.abc,
                  ),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.abc,
                  ),
                  label: 'Settings ',
                ),
              ],
              currentIndex: selectedIndex!,
              onTap: onItemTapped,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.grey.withOpacity(0.75),
            ),
          ),
        ),
      ),
    );
  }
}
