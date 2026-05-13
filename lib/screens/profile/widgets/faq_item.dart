import 'package:flutter/material.dart';

class FAQItem extends StatelessWidget {
  final String q;
  final String a;
  const FAQItem({super.key, required this.q, required this.a});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(q,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text(a,
              style: const TextStyle(
                  color: Colors.grey, fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }
}
