import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housr_task_project/bloc/hotels/hotel_bloc.dart';
import 'package:housr_task_project/bloc/hotels/hotel_event.dart';
import 'package:housr_task_project/bloc/hotels/hotel_state.dart';
import 'package:housr_task_project/constants/colors.dart';
import 'package:housr_task_project/reusable_widgets/booking_card.dart';
import 'package:shimmer/shimmer.dart';

import '../models/past_booking_model.dart';

class PastBookingsScreen extends StatefulWidget {
  const PastBookingsScreen({super.key});

  @override
  State<PastBookingsScreen> createState() => _PastBookingsScreenState();
}

class _PastBookingsScreenState extends State<PastBookingsScreen> {
  late HotelBloc hotelBloc;
  bool listLoading = false;

  List<PastBookingModel> pastBookings = [];

  @override
  void initState() {
    hotelBloc = HotelBloc();
    hotelBloc.add(const FetchPastBookings());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.sizeOf(context).width / 3.5;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Past Bookings",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        surfaceTintColor: primaryColor.withOpacity(0.3),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
        ),
        centerTitle: true,
        toolbarHeight: 80.0,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => hotelBloc,
          child: BlocConsumer<HotelBloc, HotelState>(
            listener: (BuildContext context, HotelState state) {
              if (state is LoadingPastBookingsState) {
                listLoading = true;
              }
              if (state is SuccessPastBookingsState) {
                listLoading = false;
              }
            },
            builder: (BuildContext context, HotelState state) {
              if (state is LoadingPastBookingsState) {
                listLoading = true;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                  child: ListView.builder(
                    itemCount: 8,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white54,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          margin: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0,),
                            child: Row(
                              children: [
                                Container(
                                  height: imageSize,
                                  width: imageSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                const SizedBox(width: 14.0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 12.0,
                                      width: MediaQuery.sizeOf(context).width / 2.5,
                                      color: Colors.grey.shade300,
                                    ),
                                    const SizedBox(height: 10.0,),
                                    Container(
                                      height: 10.0,
                                      width: 120,
                                      color: Colors.grey.shade300,
                                    ),
                                    const SizedBox(height: 10.0,),
                                    Container(
                                      height: 10.0,
                                      width: 80,
                                      color: Colors.grey.shade300,
                                    ),
                                    const SizedBox(height: 16.0,),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width / 2,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is SuccessPastBookingsState) {
                pastBookings = state.pastBookings;
                listLoading = false;
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: ListView.builder(
                    itemCount: pastBookings.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return BookingCard(pastBooking: pastBookings[index],);
                    },
                  ),
                );
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                  child: listLoading ? ListView.builder(
                    itemCount: pastBookings.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white54,
                        child: Card(
                          surfaceTintColor: primaryColor.withOpacity(0.05),
                          margin: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0,),
                            child: Row(
                              children: [
                                Container(
                                  height: imageSize,
                                  width: imageSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                const SizedBox(width: 14.0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 12.0,
                                      width: MediaQuery.sizeOf(context).width / 2.5,
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(height: 10.0,),
                                    Container(
                                      height: 12.0,
                                      width: 120,
                                      color: Colors.grey.shade300,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ) : ListView.builder(
                    itemCount: pastBookings.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return BookingCard(pastBooking: pastBookings[index],);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
