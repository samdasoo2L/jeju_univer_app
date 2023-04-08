import 'package:flutter/material.dart';

class JejuUniBus extends StatelessWidget {
  const JejuUniBus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 140,
      width: 350,
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
    );
  }
}
