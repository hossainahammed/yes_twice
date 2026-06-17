import 'dart:math';
import 'package:flutter/material.dart';

class ReadinessGaugePainter extends CustomPainter {
  final int score;

  ReadinessGaugePainter({required this.score});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - 8;

    // Track paint (Background circle)
    final trackPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    // Progress paint (Active arc)
    final progressPaint = Paint()
      ..shader = const SweepGradient(
        colors: [
          Color(0xFFFF5A5A),
          Color(0xFFFF8B5A),
          Color(0xFFFF5A5A),
        ],
        stops: [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    // Draw background track
    canvas.drawCircle(center, radius, trackPaint);

    // Draw progress arc (starting from -90 degrees, i.e., top)
    final double startAngle = -pi / 2;
    final double sweepAngle = 2 * pi * (score / 100.0);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ReadinessGaugePainter oldDelegate) {
    return oldDelegate.score != score;
  }
}

class WeeklyLoadChartPainter extends CustomPainter {
  final List<double> dataPoints; // 7 points for Mon-Sun (ranges from 0 to 1200)

  WeeklyLoadChartPainter({required this.dataPoints});

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    // Define chart area paddings
    final double paddingLeft = 35;
    final double paddingRight = 10;
    final double paddingTop = 20;
    final double paddingBottom = 25;

    final double chartWidth = width - paddingLeft - paddingRight;
    final double chartHeight = height - paddingTop - paddingBottom;

    // Draw background grid lines (0, 300, 600, 900, 1200)
    final List<int> yLabels = [0, 300, 600, 900, 1200];
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Text style for axes labels
    const axisTextStyle = TextStyle(
      color: Color(0xFFB3B5BA),
      fontSize: 9,
      fontWeight: FontWeight.w400,
    );

    for (int i = 0; i < yLabels.length; i++) {
      final label = yLabels[i];
      // Y coordinate from bottom
      final double y = paddingTop + chartHeight - (label / 1200.0) * chartHeight;

      // Draw horizontal line
      canvas.drawLine(Offset(paddingLeft, y), Offset(width - paddingRight, y), gridPaint);

      // Draw Y labels
      textPainter.text = TextSpan(
        text: label.toString(),
        style: axisTextStyle,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(paddingLeft - textPainter.width - 8, y - textPainter.height / 2),
      );
    }

    if (dataPoints.length != 7) return;

    // Calculate point coordinates
    final double stepX = chartWidth / 6;
    final List<Offset> points = [];
    for (int i = 0; i < 7; i++) {
      final double val = dataPoints[i];
      final double x = paddingLeft + i * stepX;
      final double y = paddingTop + chartHeight - (val / 1200.0) * chartHeight;
      points.add(Offset(x, y));
    }

    // Draw bezier curve line
    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];

      // Smooth control points
      final controlX1 = p0.dx + stepX / 2;
      final controlY1 = p0.dy;
      final controlX2 = p1.dx - stepX / 2;
      final controlY2 = p1.dy;

      path.cubicTo(controlX1, controlY1, controlX2, controlY2, p1.dx, p1.dy);
    }

    // Paint for the line
    final linePaint = Paint()
      ..color = const Color(0xFF10B981) // Emerald Green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    // Draw filled area gradient under the curve
    final fillPath = Path.from(path);
    fillPath.lineTo(points.last.dx, paddingTop + chartHeight);
    fillPath.lineTo(points.first.dx, paddingTop + chartHeight);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF10B981).withOpacity(0.15),
          const Color(0xFF10B981).withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(paddingLeft, paddingTop, chartWidth, chartHeight))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);

    // Draw dots and glow on data points
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final dotBorderPaint = Paint()
      ..color = const Color(0xFF10B981)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final glowPaint = Paint()
      ..color = const Color(0xFF10B981).withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
      ..style = PaintingStyle.fill;

    for (final pt in points) {
      canvas.drawCircle(pt, 6, glowPaint);
      canvas.drawCircle(pt, 4, dotPaint);
      canvas.drawCircle(pt, 4, dotBorderPaint);
    }

    // Draw X labels (Mon, Tue, Wed, Thu, Fri, Sat, Sun)
    final List<String> xLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    for (int i = 0; i < 7; i++) {
      final pt = points[i];
      textPainter.text = TextSpan(
        text: xLabels[i],
        style: axisTextStyle,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(pt.dx - textPainter.width / 2, paddingTop + chartHeight + 6),
      );
    }
  }

  @override
  bool shouldRepaint(covariant WeeklyLoadChartPainter oldDelegate) {
    return oldDelegate.dataPoints != dataPoints;
  }
}
