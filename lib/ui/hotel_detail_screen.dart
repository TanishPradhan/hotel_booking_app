import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:housr_task_project/constants/colors.dart';
import 'package:housr_task_project/reusable_widgets/facilities_reusable_widget.dart';
import 'package:housr_task_project/ui/booking_screen.dart';
import '../models/hotels_model.dart';

class HotelDetailScreen extends StatelessWidget {
  final Hotel hotel;

  const HotelDetailScreen(
      {super.key,
      required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              hotel.image,
                              fit: BoxFit.cover,
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).width,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white70,
                                ),
                                padding: const EdgeInsets.all(5.0),
                                child: const Icon(
                                  Icons.chevron_left,
                                  size: 30.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              hotel.name,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Text(
                              hotel.address,
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54),
                            ),
                            const SizedBox(height: 14.0,),
                            Text(hotel.description, style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.black54),),
                            const SizedBox(height: 20.0,),
                            const Text("Facilities", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.black, height: 1.2),),
                            const SizedBox(height: 10.0),
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                itemCount: hotel.facilities.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return FacilitiesWidget(icon: Icons.pool, name: hotel.facilities[index],);
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(width: 10.0,),
                    Text(hotel.price, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: primaryColor),),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => BookingScreen(hotel: hotel,)));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                        width: MediaQuery.sizeOf(context).width / 1.4,
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const Center(
                          child: Text("Book Now", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
