import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final int dashCount;
  final double dashWidth;
  final double dashSpace;

  DashedBorderPainter({
    @required this.color,
    @required this.strokeWidth,
    @required this.dashCount,
    @required this.dashWidth,
    @required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double dashTotalWidth = dashWidth + dashSpace;
    final double dashTotalHeight = size.height / dashCount;

    Path path = Path();
    for (int i = 0; i < dashCount; i++) {
      final double startY = i * dashTotalHeight;
      path.moveTo(0, startY);
      path.lineTo(0, startY + dashWidth);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) => false;
}

class DashedContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double borderWidth;
  final int dashCount;
  final double dashWidth;
  final double dashSpace;

  DashedContainer({
    @required this.child,
    this.borderColor = Colors.grey,
    this.borderWidth = 1.0,
    this.dashCount = 5,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: borderColor,
        strokeWidth: borderWidth,
        dashCount: dashCount,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
      ),
      child: Container(
        child: child,
      ),
    );
  }
}
