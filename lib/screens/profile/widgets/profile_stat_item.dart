import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/settings_viewmodel.dart';

class ProfileStatItem extends StatelessWidget {
  final String label;
  final String value;
  const ProfileStatItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A))),
        const SizedBox(height: 2),
        Text(label,
            style: const TextStyle(
                fontSize: 12, color: Color(0xFF9E9E9E))),
      ],
    );
  }
}
