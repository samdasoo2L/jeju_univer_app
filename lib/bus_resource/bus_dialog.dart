import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bus_info.dart';

class BusDialog extends StatelessWidget {
  BusDialog({super.key});
  List<int> aTimeLine = BusTimeLine().aTimeLine;
  List<String> aBusStopLocation = BusStopLocation().aBusStopLocation;

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
    return Container(
      child: Stack(
        children: [
          Container(
            width: 400.w,
            height: 500.h,
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
                ]),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        for (var i = 0; i <= 10; i++)
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  aBusStopLocation[i],
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                  for (var i = 0; i <= 23; i++)
                    Container(
                        child: Row(
                      children: [
                        Text(
                          "${i + 1}회차",
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          aTimeLine[i].toString(),
                        )
                      ],
                    ))
                ],
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
