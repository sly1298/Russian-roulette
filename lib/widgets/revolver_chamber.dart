import 'package:flutter/material.dart';

class RevolverChamber extends StatelessWidget {
  final List<bool> chamber;
  final int currentChamberIndex;

  RevolverChamber({
    required this.chamber,
    required this.currentChamberIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(6, (i) {
        // 상태에 따른 색상 결정
        Color circleColor;
        if (i < currentChamberIndex) {
          // 격발된 상태
          circleColor = chamber[i] ? Colors.red : Colors.green;
        } else {
          // 격발되지 않은 상태
          circleColor = Colors.grey;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1),
              color: circleColor,
            ),
          ),
        );
      }),
    );
  }
}
