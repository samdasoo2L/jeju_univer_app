import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusNotificationDialog extends StatelessWidget {
  const BusNotificationDialog({super.key});

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
    return SizedBox(
      width: 250.w,
      height: 250.h,
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
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "안내사항",
                  style: TextStyle(fontSize: 30.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Text(
                    "순환 버스 위치는 제주대 버스시간표 정보를 바탕으로 돌아갑니다.\n\n"
                    "그 날 상황에 따라 시간오차가 생겨 버스가 조금씩 늦어 질 수 있습니다.\n\n"
                    "이 점 유의해주시기 바랍니다. 😊",
                    style: TextStyle(fontSize: 17.sp),
                  ),
                ),
              ],
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
