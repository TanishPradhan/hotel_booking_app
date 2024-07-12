import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housr_task_project/bloc/hotels/hotel_event.dart';
import 'package:housr_task_project/bloc/hotels/hotel_state.dart';
import 'package:flutter/material.dart';
import 'package:housr_task_project/models/past_booking_model.dart';
import '../../models/hotels_model.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {

  HotelBloc() : super (const InitialHotelState()){
    on<FetchHotels>((event, emit) async {
      emit(const LoadingHotelState());

      CollectionReference firestore = FirebaseFirestore.instance.collection('hotels');
      CollectionReference discoverFirestore = FirebaseFirestore.instance.collection('discover_hotels');
      List<Hotel> hotelsList = [];
      List<Hotel> discoverHotelList = [];

      await firestore.get().then((value) => value.docs.forEach((element) {
        hotelsList.add(
          Hotel(
            name: element['name'],
            description: element['description'],
            image: element['image'],
            address: element['location'],
            price: element['price'],
            facilities: element['Facilities'],
          ),
        );
        debugPrint("EventList: ${hotelsList.toString()}");
        debugPrint("EventList: ${hotelsList[0].name}");
      }));

      emit(SuccessHotelState(hotels: hotelsList));

      await discoverFirestore.get().then((value) => value.docs.forEach((element) {
        discoverHotelList.add(
          Hotel(
            name: element['name'],
            description: element['description'],
            image: element['image'],
            address: element['location'],
            price: element['price'],
            facilities: element['Facilities'],
          ),
        );
        debugPrint("EventList: ${discoverHotelList.toString()}");
        debugPrint("EventList: ${discoverHotelList[0].name}");
      }));

      emit(SuccessDiscoverHotelList(discoverHotelList: discoverHotelList));
    });

    on<FetchPastBookings>((event, emit) async {
      emit(const LoadingPastBookingsState());

      CollectionReference firestore = FirebaseFirestore.instance.collection('past_bookings');
      List<PastBookingModel> pastBookingList = [];

      await firestore.get().then((value) => value.docs.forEach((element) {
        pastBookingList.add(
          PastBookingModel(
            name: element['name'],
            location: element['location'],
            image: element['image'],
            date: element['date'],
          ),
        );
        // debugPrint("EventList: ${pastBookingList.toString()}");
        // debugPrint("EventList: ${pastBookingList[0].name}");
      }));

      emit(SuccessPastBookingsState(pastBookings: pastBookingList));
    });

    on<BookHotelEvent>((event, emit) async {
      emit(const LoadingBookHotelState());

      try {


        CollectionReference firestore = FirebaseFirestore.instance.collection('past_bookings');

        await firestore.add({
          "name": event.name,
          "location": event.location,
          "image": event.image,
          "date": event.date,
        });

        emit(const SuccessBookHotelState());
      } catch (e){
        emit(const ErrorBookHotelState());
      }
    });

  }
}