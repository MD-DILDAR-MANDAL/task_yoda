import 'package:flutter/material.dart';

class Menuoption extends StatelessWidget {
  const Menuoption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        isSelected ? const Color(0xFF6B8E23) : const Color(0xFF2F4F4F);
    final textDecoration =
        isSelected ? TextDecoration.underline : TextDecoration.none;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: color,
              decoration: textDecoration,
            ),
          ),
        ],
      ),
    );
  }
}
