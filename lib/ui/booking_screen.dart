import 'dart:ui';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housr_task_project/bloc/hotels/hotel_bloc.dart';
import 'package:housr_task_project/bloc/hotels/hotel_event.dart';
import 'package:housr_task_project/reusable_widgets/loader.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:housr_task_project/constants/colors.dart';
import 'package:housr_task_project/constants/text_styles.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../bloc/hotels/hotel_state.dart';
import '../models/hotels_model.dart';

class BookingScreen extends StatefulWidget {
  final Hotel hotel;

  const BookingScreen({super.key, required this.hotel});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late HotelBloc hotelBloc;

  late Razorpay _razorpay;

  int guests = 1;
  int rooms = 1;

  String checkinDate = DateFormat('d MMMM y').format(DateTime.now());
  String checkoutDate = DateFormat('d MMMM y')
      .format(DateTime.now().add(const Duration(days: 1)));

  DateTime? checkin = DateTime.now();
  DateTime? checkout = DateTime.now();

  List<DateTime?> _dates = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 1)),
  ];

  TextStyle headingStyle = const TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black);

  @override
  void initState() {
    hotelBloc = HotelBloc();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    debugPrint("PaymentId: ${response.paymentId} \n OrderId: ${response.orderId}");

    hotelBloc.add(BookHotelEvent(widget.hotel.name, DateFormat('d MMMM y').format(_dates[0]!), widget.hotel.address, widget.hotel.image));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Payment Successful"),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
              10.0)),
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("Payment Error Response: ${response.message}");

    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Payment Failed"),
      showCloseIcon: true,
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
              10.0)),
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.walletName!),
      backgroundColor: Colors.green,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
              10.0)),
    ));
  }

  void openCheckout() {
    debugPrint("Checkout initiated");
    var options = {
      "key": "rzp_test_wFEIWe7sxtp71p",
      "amount": (int.tryParse(widget.hotel.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0) * 100,
      "name": widget.hotel.name,
      "description": "this is the test payment",
      // "timeout": "180",
      // "currency": "INR",
      "prefill": {
        // "contact": "0000000000",
        "email": "tanish.pradhan4@gmail.com",
      }
    };
    _razorpay.open(options);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => hotelBloc,
          child: BlocListener<HotelBloc, HotelState>(
            listener: (context, state) {
              if (state is LoadingBookHotelState) {
                showDialog(context: context, builder: (context) => const LoaderDialog());
              }
              if (state is SuccessBookHotelState) {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return PopScope(
                      canPop: false,
                      child: Material(
                        color: Colors.transparent,
                        child: Center(
                          child: Container(
                            height: MediaQuery.sizeOf(context).height / 1.5,
                            width: MediaQuery.sizeOf(context).width / 1.2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "assets/success.png",
                                  width:
                                      MediaQuery.sizeOf(context).width / 1.3,
                                ),
                                const Text(
                                  "Booking Successful!",
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                const Text(
                                  "You hotel has been successfully booked. You will receive all the details via email.",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12.0,
                                      horizontal: 20.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Done",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is ErrorHotelState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Row(
                      children: [
                        Icon(Icons.warning_amber, color: Colors.white70, size: 25.0,),
                        SizedBox(width: 14.0),
                        Expanded(
                          child: Text(
                            "Booking Failed! :(",
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    closeIconColor: Colors.white70,
                    showCloseIcon: true,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.redAccent.withOpacity(0.9),
                  ),
                );
              }
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          const Center(
                            child: Text(
                              "Booking Details",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor.withOpacity(0.1),
                              ),
                              padding: const EdgeInsets.all(2.0),
                              child: const Icon(
                                Icons.chevron_left,
                                size: 35,
                                color: primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  widget.hotel.image,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.hotel.name, style: heading),
                                  Text(widget.hotel.address, style: subHeading),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    widget.hotel.price,
                                    style: smallHeading,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.range,
                          firstDate: DateTime.now(),
                          selectedRangeHighlightColor:
                          primaryColor.withOpacity(0.2),
                          selectedDayHighlightColor: primaryColor,
                        ),
                        value: _dates,
                        onValueChanged: (dates) {
                          _dates = dates;
                          if (dates.length == 2) {
                            setState(() {});
                          }
                        },
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Check-in",
                                style: headingStyle,
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width / 2.5,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 14.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.black38),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat('d MMMM y').format(_dates[0]!),
                                      style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87),
                                    ),
                                    const Icon(
                                      Icons.calendar_month_outlined,
                                      size: 25.0,
                                      color: primaryColor,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Check-out",
                                style: headingStyle,
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width / 2.5,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 14.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.black38),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat('d MMMM y').format(_dates[1]!),
                                      style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87),
                                    ),
                                    const Icon(
                                      Icons.calendar_month_outlined,
                                      size: 25.0,
                                      color: primaryColor,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Guest",
                                style: headingStyle,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(
                                    12.0,
                                  ),
                                ),
                                width: MediaQuery.sizeOf(context).width / 2.5,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6.0, horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          guests++;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        size: 25.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      guests.toString(),
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (guests > 1) {
                                            guests--;
                                          }
                                        });
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        size: 25.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Room",
                                style: headingStyle,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(
                                    12.0,
                                  ),
                                ),
                                width: MediaQuery.sizeOf(context).width / 2.5,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6.0, horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          rooms++;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        size: 30.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      rooms.toString(),
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (rooms > 1) {
                                            rooms--;
                                          }
                                        });
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        size: 30.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // hotelBloc.add(BookHotelEvent(widget.hotel.name, DateFormat('d MMMM y').format(_dates[0]!), widget.hotel.address, widget.hotel.image));
                        openCheckout();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Center(
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
