import 'package:flutter/material.dart';

class AppBarIcon extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const AppBarIcon({super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon),
      ),
    );
  }
}
