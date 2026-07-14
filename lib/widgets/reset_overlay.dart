import 'package:flutter/material.dart';
import 'dart:math';

class ResetOverlay extends StatefulWidget {
  @override
  _ResetOverlayState createState() => _ResetOverlayState();
}

class _ResetOverlayState extends State<ResetOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // 애니메이션 컨트롤러 설정
    _controller = AnimationController(
      duration: Duration(seconds: 2), // 총 애니메이션 시간
      vsync: this,
    );

    // 회전 애니메이션 설정 (천천히 멈춤)
    _rotationAnimation = Tween<double>(begin: 0, end: 6 * pi) // 3바퀴 회전
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut, // 점점 느려짐
    ));

    // 애니메이션 시작
    _controller.forward().then((_) {
      // 애니메이션 종료 후 상태 업데이트
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.isCompleted
        ? Container() // 애니메이션 종료 후 빈 컨테이너 반환
        : Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value,
              child: CustomPaint(
                size: Size(200, 200),
                painter: RevolverPainter(),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RevolverPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey[800]!;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 리볼버 외곽 원 그리기
    canvas.drawCircle(center, radius, paint);

    // 슬롯 위치 계산
    final slotRadius = radius / 4;
    final angleStep = 2 * pi / 6;

    for (int i = 0; i < 6; i++) {
      final angle = angleStep * i - pi / 2; // 12시 방향부터 시작
      final slotCenter = Offset(
        center.dx + radius * 0.6 * cos(angle),
        center.dy + radius * 0.6 * sin(angle),
      );

      // 슬롯의 외곽
      canvas.drawCircle(slotCenter, slotRadius, Paint()..color = Colors.black);

      // 슬롯 내부 (총알 여부)
      final isBullet = i == 0; // 첫 번째 슬롯에만 총알
      final slotInnerPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = isBullet ? Colors.yellow : Colors.grey[400]!;

      canvas.drawCircle(slotCenter, slotRadius - 5, slotInnerPaint);
    }

    // 중앙 원 (리볼버 중앙부)
    canvas.drawCircle(center, radius / 6, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
