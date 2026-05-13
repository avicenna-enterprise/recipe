import 'package:flutter/material.dart';

// ─── Google Button ────────────────────────────────────────
class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onTap;
  const GoogleSignInButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CustomPaint(painter: _GoogleGPainter()),
          ),
        ),
      ),
    );
  }
}

// ─── Facebook Button ──────────────────────────────────────
class FacebookSignInButton extends StatelessWidget {
  final VoidCallback onTap;
  const FacebookSignInButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF00597d), // Branded blue
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'f',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Google "G" CustomPainter ─────────────────────────────
class _GoogleGPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Scale factor — original path is 24x24
    final double s = size.width / 24.0;
    canvas.scale(s, s);

    // Red portion — top arc
    final redPath = Path()
      ..moveTo(23.52, 12.27)
      ..cubicTo(23.52, 11.48, 23.46, 10.73, 23.34, 10.0)
      ..lineTo(12.0, 10.0)
      ..lineTo(12.0, 14.26)
      ..lineTo(18.46, 14.26)
      ..cubicTo(18.18, 15.77, 17.34, 17.07, 16.06, 17.93)
      ..lineTo(16.06, 20.67)
      ..lineTo(19.93, 20.67)
      ..cubicTo(22.19, 18.6, 23.52, 15.72, 23.52, 12.27)
      ..close();
    canvas.drawPath(redPath, Paint()..color = const Color(0xFF4285F4));

    // Blue portion
    final bluePath = Path()
      ..moveTo(12.0, 24.0)
      ..cubicTo(15.24, 24.0, 17.96, 22.93, 19.93, 20.67)
      ..lineTo(16.06, 17.93)
      ..cubicTo(14.99, 18.66, 13.62, 19.1, 12.0, 19.1)
      ..cubicTo(8.87, 19.1, 6.23, 17.01, 5.29, 14.17)
      ..lineTo(1.29, 14.17)
      ..lineTo(1.29, 17.0)
      ..cubicTo(3.26, 20.91, 7.31, 24.0, 12.0, 24.0)
      ..close();
    canvas.drawPath(bluePath, Paint()..color = const Color(0xFF34A853));

    // Yellow portion
    final yellowPath = Path()
      ..moveTo(5.29, 14.17)
      ..cubicTo(5.05, 13.44, 4.91, 12.66, 4.91, 11.86)
      ..cubicTo(4.91, 11.06, 5.05, 10.28, 5.29, 9.55)
      ..lineTo(5.29, 6.72)
      ..lineTo(1.29, 6.72)
      ..cubicTo(0.47, 8.35, 0.0, 10.06, 0.0, 11.86)
      ..cubicTo(0.0, 13.66, 0.47, 15.37, 1.29, 17.0)
      ..lineTo(5.29, 14.17)
      ..close();
    canvas.drawPath(yellowPath, Paint()..color = const Color(0xFFFBBC05));

    // Red portion — bottom
    final redPath2 = Path()
      ..moveTo(12.0, 4.62)
      ..cubicTo(13.76, 4.62, 15.34, 5.24, 16.58, 6.44)
      ..lineTo(20.02, 3.0)
      ..cubicTo(17.95, 1.14, 15.24, 0.0, 12.0, 0.0)
      ..cubicTo(7.31, 0.0, 3.26, 3.09, 1.29, 7.0)
      ..lineTo(5.29, 9.83)
      ..cubicTo(6.23, 6.99, 8.87, 4.62, 12.0, 4.62)
      ..close();
    canvas.drawPath(redPath2, Paint()..color = const Color(0xFFEA4335));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Facebook "f" CustomPainter ───────────────────────────
class _FacebookFPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Blue rounded square background
    final bgPaint = Paint()..color = const Color(0xFF1877F2);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, w, h),
        Radius.circular(w * 0.22),
      ),
      bgPaint,
    );

    // White "f" letter
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'f',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          height: 1,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (w - textPainter.width) / 2 + 1,
        (h - textPainter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
