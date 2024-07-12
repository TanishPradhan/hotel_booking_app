import 'package:equatable/equatable.dart';

abstract class HotelEvent extends Equatable {
  const HotelEvent();
}

class FetchHotels extends HotelEvent{
  @override
  List<Object> get props => [];

  const FetchHotels();
}

class FetchPastBookings extends HotelEvent{
  @override
  List<Object> get props => [];

  const FetchPastBookings();
}

class BookHotelEvent extends HotelEvent{
  final String name;
  final String date;
  final String location;
  final String image;
  @override
  List<Object> get props => [];

  const BookHotelEvent(this.name, this.date, this.location, this.image);
}