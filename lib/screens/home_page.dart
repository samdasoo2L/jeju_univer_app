import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main_page.dart';
import 'bus_page.dart';
import 'weather_screen.dart';
import 'food_page.dart';
import '../bottom_bar/nav_bar.dart';

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
            child: const BusPage(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const FoodPage(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const WeatherPage(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(255, 178, 79, 1),
        child: Padding(
          padding: const EdgeInsets.all(12),
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
                icon: FontAwesomeIcons.bowlRice,
                selectedIcon: FontAwesomeIcons.bowlFood,
                onTap: () => _onTap(2),
              ),
              NavTab(
                text: "Weather",
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.cloudSun,
                selectedIcon: FontAwesomeIcons.sunPlantWilt,
                onTap: () => _onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
