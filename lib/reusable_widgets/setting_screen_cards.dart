import 'package:flutter/material.dart';

class SettingsScreenCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const SettingsScreenCard({super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          children: [
            Icon(icon, size: 24.0, color: Colors.black54,),
            const SizedBox(width: 10.0,),
            Text(text, style: const TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w500),),
            const Spacer(),
            const Icon(Icons.chevron_right, size: 24.0, color: Colors.black,),
          ],
        ),
      ),
    );
  }
}
