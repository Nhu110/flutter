import 'package:flutter/material.dart';
import 'package:plant_app/components/bottom_nav_bar.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/bill_screen.dart';
import 'package:plant_app/screens/home_screen.dart';
import 'package:plant_app/screens/profile.dart';
import 'package:plant_app/screens/search_plant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String id = 'MainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    ImageSearchPage(),
    const BillPay(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   leadingWidth: 0,
      //   automaticallyImplyLeading: false,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     // children: [
      //     //   GestureDetector(
      //     //     // child: CircleAvatar(
      //     //     //   backgroundColor: kDarkGreenColor,
      //     //     //   radius: 22.0,
      //     //     //   backgroundImage: const AssetImage('images/Dhairye.jpg'),
      //     //     // ),
      //     //     onTap: () {},
      //     //   ),
      //       // CircleAvatar(
      //       //   backgroundColor: kDarkGreenColor,
      //       //   radius: 22.0,
      //       //   child: IconButton(
      //       //     color: Colors.white,
      //       //     splashRadius: 28.0,
      //       //     icon: const Icon(
      //       //       Icons.shopping_cart_outlined,
      //       //     ),
      //       //     onPressed: () {
      //       //       Navigator.pushNamed(context, CartScreen.id);
      //       //     },
      //       //   ),
      //       // ),
      //     // ],
      //   ),
      // ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        selectedColor: kDarkGreenColor,
        unselectedColor: kSpiritedGreen,
        onTapped: (index) {
          setState(() {
            selectedIndex = index;
          });
          if(index ==1){
            Navigator.pushNamed(context, Profile.id);
          }
           if(index ==1){
            Navigator.pushNamed(context, BillPay.id);
          }
          // print(index);
          // if(index == 1){
          //   Navigator.pushNamed(context, ImageSearchPage.id); ?????
          // }
        },
        items: const [
          Icon(Icons.home),
          Icon(Icons.image_search_outlined),
          Icon(Icons.receipt),
          Icon(Icons.person),
        ],
      ),
      body: screens[selectedIndex],
    );
  }
}
