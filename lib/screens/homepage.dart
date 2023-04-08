import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/bottom_widgets/nav_bar.dart';
import '/bottom_body/bb_food_page.dart';
import '/constants/sizes.dart';
import '/bottom_body/bb_main_page.dart';
import '/web_crawling/food_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const MainPage(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: Container(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const FoodDetailPage(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const DormitoryMenu(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "Home",
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
              ),
              NavTab(
                text: "Bus",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.busSimple,
                selectedIcon: FontAwesomeIcons.bus,
                onTap: () => _onTap(1),
              ),
              NavTab(
                text: "Food",
                isSelected: _selectedIndex == 2,
                icon: FontAwesomeIcons.bowlFood,
                selectedIcon: FontAwesomeIcons.bowlRice,
                onTap: () => _onTap(2),
              ),
              NavTab(
                text: "Map",
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
