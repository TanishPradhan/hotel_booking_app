import 'package:housr_task_project/models/hotels_model.dart';
import 'package:housr_task_project/models/past_booking_model.dart';

abstract class HotelState {
  const HotelState();
}

class InitialHotelState extends HotelState {
  const InitialHotelState();
}

class LoadingHotelState extends HotelState {
  const LoadingHotelState();
}

class SuccessHotelState extends HotelState {
  List<Hotel> hotels;
  SuccessHotelState({required this.hotels});
}

class ErrorHotelState extends HotelState {
  const ErrorHotelState();
}

class SuccessDiscoverHotelList extends HotelState {
  List<Hotel> discoverHotelList;

  SuccessDiscoverHotelList({required this.discoverHotelList});
}

class LoadingPastBookingsState extends HotelState {
  const LoadingPastBookingsState();
}

class SuccessPastBookingsState extends HotelState {
  List<PastBookingModel> pastBookings;
  SuccessPastBookingsState({required this.pastBookings});
}

class ErrorPastBookingsState extends HotelState {
  const ErrorPastBookingsState();
}

class LoadingBookHotelState extends HotelState {
  const LoadingBookHotelState();
}

class SuccessBookHotelState extends HotelState {
  const SuccessBookHotelState();
}

class ErrorBookHotelState extends HotelState {
  const ErrorBookHotelState();
}