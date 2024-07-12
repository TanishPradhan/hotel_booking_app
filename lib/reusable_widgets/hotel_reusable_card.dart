import 'package:flutter/material.dart';
import 'package:housr_task_project/constants/colors.dart';
import 'package:housr_task_project/ui/hotel_detail_screen.dart';

import '../models/hotels_model.dart';

class HotelReusableCard extends StatelessWidget {
  final Hotel hotel;
  const HotelReusableCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => HotelDetailScreen(hotel: hotel,)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                hotel.image,
                height: 90,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.black54, size: 16.0,),
                      const SizedBox(width: 2.0,),
                      Text(
                        hotel.address,
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14.0),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20.0,),
                      SizedBox(width: 2.0,),
                      Text("4.0/5", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.black54),)
                    ],
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${hotel.price}/",
                  style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: primaryColor),
                ),
                const Text(
                  " day",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black45),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
