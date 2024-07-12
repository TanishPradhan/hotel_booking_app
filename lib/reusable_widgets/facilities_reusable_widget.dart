import 'package:flutter/material.dart';
import 'package:housr_task_project/constants/colors.dart';

class FacilitiesWidget extends StatelessWidget {
  final IconData icon;
  final String name;
  const FacilitiesWidget({super.key, required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: Column(
        children: [
          // const Icon(Icons.star_border_rounded, size: 25.0, color: primaryColor,),
          Text(name, style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: primaryColor),),
        ],
      ),
    );
  }
}
