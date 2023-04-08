import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sample_app2/constants/gaps.dart';
import 'package:sample_app2/constants/sizes.dart';

class JejuWeather extends StatelessWidget {
  const JejuWeather({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 170,
      width: 163,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Text(
            "10",
            style: TextStyle(fontSize: Sizes.size56),
          ),
          FaIcon(FontAwesomeIcons.cloud),
          Gaps.v10,
          Text('고뿔 조심합서'),
        ],
      ),
    );
  }
}
