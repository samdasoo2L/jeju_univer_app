import 'package:flutter/material.dart';

class JejuDust extends StatelessWidget {
  const JejuDust({
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
    );
  }
}
