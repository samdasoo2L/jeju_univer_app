import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodTimeTable extends StatelessWidget {
  const FoodTimeTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: foodtimetable(context),
    );
  }

  Widget foodtimetable(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 425.h,
          width: 500.w,
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "식당 운영시간",
                    style: TextStyle(fontSize: 30.sp),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "백두관 식당",
                                style: TextStyle(fontSize: 14.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "평일",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          children: [
                                            Text(
                                              "아침 09:00 ~ 10:00",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              "아침 메뉴(라면, 공기밥)",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              "점심 11:00 ~ 14:00",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              "저녁 17:00 ~ 18:30",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text(
                                              "주말 및 공휴일 미운영",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "교수회관",
                                style: TextStyle(fontSize: 14.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "평일",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          children: [
                                            Text(
                                              "10:30 ~ 15:00\n(식권 마감 14:30)",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text(
                                              "주말 및 공휴일 미운영",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "기숙사 식당",
                                style: TextStyle(fontSize: 14.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "평일",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          children: [
                                            Text(
                                              "아침 07:30 ~ 09:00",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              "점심 11:40 ~ 13:30",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              "저녁 17:30 ~ 19:00",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "토요일",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          children: [
                                            Text(
                                              "아침 08:00 ~ 09:00",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              "점심 11:40 ~ 13:30",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              "저녁 17:30 ~ 19:00",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "일요일",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          children: [
                                            Text(
                                              "아침 미운영",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              "점심 11:40 ~ 13:30",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              "저녁 17:30 ~ 19:00",
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
    );
  }
}
