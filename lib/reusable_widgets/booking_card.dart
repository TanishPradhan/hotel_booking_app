import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housr_task_project/models/past_booking_model.dart';

import '../constants/colors.dart';
import '../models/hotels_model.dart';

class BookingCard extends StatelessWidget {
  final PastBookingModel pastBooking;
  const BookingCard({super.key, required this.pastBooking});

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.sizeOf(context).width / 3.5;

    return Card(
      surfaceTintColor: primaryColor.withOpacity(0.05),
      margin: const EdgeInsets.only(top: 5.0, bottom: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(14.0,),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(pastBooking.image, height: imageSize, width: imageSize, fit: BoxFit.cover,),
            ),
            const SizedBox(width: 14.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pastBooking.name, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black, height: 1.2),),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: Colors.black54, size: 16.0,),
                        const SizedBox(width: 2.0),
                        Text(pastBooking.location, style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500, color: Colors.black54),),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.calendar_month_rounded, size: 16.0, color: Colors.black54,),
                        const SizedBox(width: 2.0),
                        Text(pastBooking.date, style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.black54),),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 14.0,),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Row(
                          children: [
                            Icon(Icons.check, color: Colors.black87, size: 25.0,),
                            SizedBox(width: 14.0),
                            Expanded(
                              child: Text(
                                "Thanks for booking with us. We will contact you soon.",
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        closeIconColor: Colors.black54,
                        showCloseIcon: true,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green.shade400.withOpacity(0.9),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    width: MediaQuery.sizeOf(context).width / 2,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(child: Text("Book Again", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.black87),)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
