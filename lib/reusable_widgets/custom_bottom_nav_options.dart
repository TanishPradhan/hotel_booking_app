import 'package:flutter/material.dart';

class CustomBottomNavOption extends StatelessWidget {
  final IconData icon;
  final String name;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;
  const CustomBottomNavOption({super.key, required this.icon, required this.name, required this.onTap, required this.index, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 25.0, color: currentIndex == index ? Colors.black : Colors.black38,),
          const SizedBox(height: 2.0,),
          Text(name, style: TextStyle(fontSize: 10.0, color: currentIndex == index ? Colors.black : Colors.black38, fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }
}
