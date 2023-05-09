import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: professorMenu(context),
    );
  }

  Widget professorMenu(BuildContext context) {
    final controller = PageController();
    return SizedBox(
      width: 250.w,
      height: 200.h,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 0, right: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 0.0,
                  offset: Offset(0.0, 0.0),
                ),
              ],
            ),
            child: PageView(
              controller: controller,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/professorfoods/gogiguksu.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: const Text("국밥 이미지 준비중"),
                ),
                Container(
                  child: const Text("순두부찌개 이미지 준비중"),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10.h,
            left: 113.w,
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              axisDirection: Axis.horizontal,
              effect: const SlideEffect(
                activeDotColor: Color.fromRGBO(255, 178, 79, 1),
                dotHeight: 15,
                dotColor: Colors.white,
                dotWidth: 15,
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
