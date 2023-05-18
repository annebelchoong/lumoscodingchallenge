import 'package:flutter/material.dart';
import 'package:lumoscodingchallenge/routing/entry_page.dart';
import 'package:lumoscodingchallenge/routing/list_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  List<Widget> pages = [
    // const HomePage(),
    // const MallPage(),

    const EntryPage(),
    const ListPage(),
  ];

  _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: pages.elementAt(_currentIndex)),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _changeTab,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.exit_to_app_rounded), label: 'Entry'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          ],
        ));
  }
}
