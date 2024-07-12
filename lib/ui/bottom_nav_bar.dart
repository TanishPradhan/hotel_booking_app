import 'package:flutter/material.dart';
import 'package:housr_task_project/constants/colors.dart';
import 'package:housr_task_project/reusable_widgets/custom_bottom_nav_options.dart';
import 'package:housr_task_project/ui/home_screen.dart';
import 'package:housr_task_project/ui/past_bookings_screen.dart';
import 'package:housr_task_project/ui/settings_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const PastBookingsScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     items: <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.home),
      //           label: "Home",
      //           // backgroundColor: Colors.green
      //         backgroundColor: primaryColor.withOpacity(0.3),
      //       ),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.search),
      //           // title: Text('Search'),
      //           label: "Home",
      //           // backgroundColor: Colors.yellow
      //         backgroundColor: primaryColor.withOpacity(0.3),
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         // title: Text('Profile'),
      //         label: "Home",
      //         // backgroundColor: Colors.blue,
      //         backgroundColor: primaryColor.withOpacity(0.3),
      //       ),
      //     ],
      //     type: BottomNavigationBarType.shifting,
      //     currentIndex: _selectedIndex,
      //     selectedItemColor: Colors.black,
      //     backgroundColor: primaryColor.withOpacity(0.3),
      //     iconSize: 40,
      //     onTap: _onItemTapped,
      //     elevation: 5
      // ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          height: 70,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // IconButton(
                //   icon: const Icon(Icons.home, color: Colors.black,),
                //   onPressed: () {
                //     _onItemTapped(0);
                //   },
                // ),
                CustomBottomNavOption(icon: Icons.home, name: "Home", onTap: () => _onItemTapped(0), index: 0, currentIndex: _selectedIndex),
                CustomBottomNavOption(icon: Icons.mode_of_travel_rounded, name: "Bookings", onTap: () => _onItemTapped(1), index: 1, currentIndex: _selectedIndex),
                CustomBottomNavOption(icon: Icons.account_circle_outlined, name: "Profile", onTap: () => _onItemTapped(2), index: 2, currentIndex: _selectedIndex),
                // IconButton(
                //   icon: const Icon(Icons.search),
                //   onPressed: () {
                //     _onItemTapped(1);
                //   },
                // ),
                // IconButton(
                //   icon: const Icon(Icons.account_circle_outlined),
                //   onPressed: () {
                //     _onItemTapped(2);
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
