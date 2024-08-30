import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;
  final Color color;

  const ProgressBar(
      {super.key, required this.progress, this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: color.withOpacity(0.2),
      valueColor: AlwaysStoppedAnimation<Color>(color),
    );
  }
}
