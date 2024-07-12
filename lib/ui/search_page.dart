import 'package:flutter/material.dart';
import 'package:housr_task_project/constants/colors.dart';

import '../models/hotels_model.dart';
import '../reusable_widgets/hotel_reusable_card.dart';

class SearchPage extends StatefulWidget {
  final List<Hotel> fooList;
  const SearchPage({super.key, required this.fooList});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Hotel> filteredList = [];

  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
  );

  void filter(String inputString) {
    filteredList = widget.fooList.where((i) => i.address.toLowerCase().contains(inputString)).toList();
    setState(() {});
  }

  @override
  void initState() {
    filteredList = widget.fooList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left,
            size: 30.0,
            color: Colors.black,
          ),
        ),
        title: const Text("Search", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.black),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                textCapitalization: TextCapitalization.words,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0,),
                  prefixIcon: const Icon(Icons.search, color: primaryColor),
                  enabledBorder: border,
                  focusedBorder: border,
                ),
                onChanged: (text) {
                  text = text.toLowerCase();
                  filter(text);
                },
              ),
              const SizedBox(height: 10.0,),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (BuildContext context, int index) => HotelReusableCard(
                    hotel: filteredList[index],
                  ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
