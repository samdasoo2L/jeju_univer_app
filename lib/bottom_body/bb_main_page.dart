import 'package:flutter/material.dart';
import '/constants/gaps.dart';
import '/main_page_widgets/jeju_dust.dart';
import '/main_page_widgets/jeju_food_menu.dart';
import '/main_page_widgets/jeju_uni_bus.dart';
import '/main_page_widgets/jeju_weather.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Column(
            children: [
              Gaps.v10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: const [
                      Text(
                        '제주대 날씨',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Gaps.v10,
                      JejuWeather(),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        "미세먼지",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Gaps.v10,
                      JejuDust(),
                    ],
                  ),
                ],
              ),
              Gaps.v20,
              Row(
                children: const [
                  Gaps.h24,
                  Text(
                    '오늘의 메뉴',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              Gaps.v20,
              const JejuFoodMenu(),
              Gaps.v20,
              Row(
                children: const [
                  Gaps.h24,
                  Text(
                    '제주대 순환 버스표',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              Gaps.v20,
              const JejuUniBus(),
            ],
          ),
        ),
      ),
    );
  }
}
