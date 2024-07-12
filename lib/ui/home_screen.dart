import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:housr_task_project/bloc/hotels/hotel_bloc.dart';
import 'package:housr_task_project/bloc/hotels/hotel_state.dart';
import 'package:housr_task_project/constants/colors.dart';
import 'package:housr_task_project/reusable_widgets/hotel_reusable_card.dart';
import 'package:housr_task_project/ui/hotel_detail_screen.dart';
import 'package:housr_task_project/ui/search_page.dart';
import 'package:shimmer/shimmer.dart';
import '../bloc/hotels/hotel_event.dart';
import '../models/hotels_model.dart';
import '../models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box<UserModel> userBox = Hive.box<UserModel>('users');

  List<Hotel> hotelsList = [];
  List<Hotel> discoverList = [];

  late HotelBloc hotelBloc;

  List<Hotel> allHotels = [];
  bool hotelsLoading = false;

  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
  );

  @override
  void initState() {
    hotelBloc = HotelBloc();
    hotelBloc.add(const FetchHotels());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    hotelBloc.add(const FetchHotels());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocProvider(
              create: (context) => hotelBloc,
              child: BlocConsumer<HotelBloc, HotelState>(
                listener: (BuildContext context, HotelState state) {
                  if (state is SuccessDiscoverHotelList) {
                    discoverList.clear();
                    discoverList = state.discoverHotelList;
                    for (var hotels in state.discoverHotelList) {
                      allHotels.add(hotels);
                    }
                  }

                  if (state is LoadingHotelState) {
                    hotelsLoading = true;
                  }

                  if (state is SuccessHotelState) {
                    hotelsLoading = false;
                  }
                },
                builder: (BuildContext context, HotelState state) {
                  // if (state is LoadingHotelState) {
                  //   return SizedBox(
                  //     height: MediaQuery.sizeOf(context).height,
                  //     width: MediaQuery.sizeOf(context).width,
                  //     child: const Center(
                  //       child: CircularProgressIndicator(),
                  //     ),
                  //   );
                  // }
                  if (state is SuccessHotelState) {
                    hotelsList.clear();
                    hotelsList = state.hotels;
                    for (var hotels in state.hotels) {
                      allHotels.add(hotels);
                    }
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Discover",
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "Find your perfect hotel to stay",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (_) => const SettingsScreen()));
                              //   },
                              //   child: Hero(
                              //     tag: "DisplayPicture",
                              //     child: CachedNetworkImage(
                              //       imageUrl: userBox.getAt(0)!.displayPicture!,
                              //       imageBuilder: (context, imageProvider) => Container(
                              //         height: 60,
                              //         width: 60,
                              //         decoration: BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           image: DecorationImage(
                              //             image: imageProvider,
                              //             fit: BoxFit.cover,
                              //           ),
                              //         ),
                              //       ),
                              //       placeholder: (context, url) => imageWidget(30),
                              //       errorWidget: (context, url, error) => imageWidget(30),
                              //     ),
                              //   ),
                              //   // child: Hero(
                              //   //   tag: "DisplayPicture",
                              //   //   child: CircleAvatar(
                              //   //     radius: 30.0,
                              //   //     backgroundColor: primaryColor.withOpacity(0.2),
                              //   //     backgroundImage: NetworkImage(userBox.getAt(0)!.displayPicture!),
                              //   //     child: userBox.getAt(0)!.displayPicture != null
                              //   //         ? null
                              //   //         : const Icon(
                              //   //       Icons.person,
                              //   //       size: 40,
                              //   //       color: primaryColor,
                              //   //     ),
                              //   //   ),
                              //   // ),
                              // )
                            ],
                          ),
                          if (discoverList.isNotEmpty)
                            SizedBox(
                              height: 290,
                              child: ListView.builder(
                                itemCount: discoverList.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    margin: const EdgeInsets.only(
                                        right: 15.0, top: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Image.network(
                                            discoverList[index].image,
                                            height: 160,
                                            width: 160,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 14.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              discoverList[index].name,
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              discoverList[index].address,
                                              style: const TextStyle(
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${discoverList[index].price}/",
                                                  style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: primaryColor),
                                                ),
                                                const Text(
                                                  " day",
                                                  style: TextStyle(
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black45),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          const Text(
                            "Explore",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: hotelsList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return HotelReusableCard(
                                  hotel: hotelsList[index],
                                );
                              })
                        ],
                      ),
                    );
                  }
                  if (state is ErrorHotelState) {
                    return const Center(
                      child: Text("Encountered Error Fetching Hotels."),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Discover",
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Find your perfect hotel to stay",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (_) => const SettingsScreen()));
                            //   },
                            //   child: Hero(
                            //     tag: "DisplayPicture",
                            //     child: CachedNetworkImage(
                            //       imageUrl: userBox.getAt(0)!.displayPicture!,
                            //       imageBuilder: (context, imageProvider) => Container(
                            //         height: 60,
                            //         width: 60,
                            //         decoration: BoxDecoration(
                            //           shape: BoxShape.circle,
                            //           image: DecorationImage(
                            //             image: imageProvider,
                            //             fit: BoxFit.cover,
                            //           ),
                            //         ),
                            //       ),
                            //       placeholder: (context, url) => imageWidget(30),
                            //       errorWidget: (context, url, error) => imageWidget(30),
                            //     ),
                            //   ),
                            //   // child: Hero(
                            //   //   tag: "DisplayPicture",
                            //   //   child: CircleAvatar(
                            //   //     radius: 30.0,
                            //   //     backgroundColor: primaryColor.withOpacity(0.2),
                            //   //     backgroundImage: NetworkImage(userBox.getAt(0)!.displayPicture!),
                            //   //     child: userBox.getAt(0)!.displayPicture != null
                            //   //         ? null
                            //   //         : const Icon(
                            //   //       Icons.person,
                            //   //       size: 40,
                            //   //       color: primaryColor,
                            //   //     ),
                            //   //   ),
                            //   // ),
                            // )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: 'Search ',
                              hintStyle: const TextStyle(
                                fontSize: 14,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14.0,
                                horizontal: 10.0,
                              ),
                              prefixIcon:
                                  const Icon(Icons.search, color: primaryColor),
                              enabledBorder: border,
                              focusedBorder: border,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          SearchPage(fooList: allHotels)));
                            },
                          ),
                        ),
                        if (discoverList.isNotEmpty)
                          SizedBox(
                            height: 290,
                            child: ListView.builder(
                              itemCount: discoverList.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => HotelDetailScreen(
                                            hotel: discoverList[index]),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    margin: const EdgeInsets.only(
                                        right: 15.0, top: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Image.network(
                                            discoverList[index].image,
                                            height: 160,
                                            width: 160,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 14.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              discoverList[index].name,
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              discoverList[index].address,
                                              style: const TextStyle(
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${discoverList[index].price}/",
                                                  style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: primaryColor),
                                                ),
                                                const Text(
                                                  " day",
                                                  style: TextStyle(
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black45),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Text(
                          "Explore",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        hotelsLoading ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: 5,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.white54,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 14.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 90.0,
                                      width: 90.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.0),
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 20.0,
                                          width: MediaQuery.sizeOf(context).width / 1.8,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12.0),
                                            color: Colors.grey.shade200,
                                          ),),
                                        const SizedBox(height: 10.0,),
                                        Container(
                                          height: 20.0,
                                          width: 150.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12.0),
                                            color: Colors.grey.shade200,
                                          ),),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            );
                          },
                        ) : ListView.builder(
                          shrinkWrap: true,
                          itemCount: hotelsList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return HotelReusableCard(
                              hotel: hotelsList[index],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}
