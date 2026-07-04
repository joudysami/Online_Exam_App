import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const HeaderSection({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
