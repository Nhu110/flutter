import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plant_app/components/curve.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/data.dart';
import 'package:plant_app/models/cart_item.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/screens/plant_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageSearchPage extends StatefulWidget {
  const ImageSearchPage({super.key});
  static const String id = "ImageSearchPage";

  @override
  _ImageSearchPageState createState() => _ImageSearchPageState();
}

class _ImageSearchPageState extends State<ImageSearchPage> {
  String _searchKeyword = '';

  @override
  void initState() {
    fetchCartItems();
    super.initState();
  }

  List<Plant> plants = [];
  List<Plant> filteredPlants = [];

  Future<void> fetchCartItems() async {
    final fetchedItems = await getRecommend();
    setState(() {
      plants = fetchedItems;
      filteredPlants = fetchedItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: 
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  style: TextStyle(color: kDarkGreenColor),
                  cursorColor: kDarkGreenColor,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kGinColor,
                    hintText: 'Tìm Kiếm',
                    hintStyle: TextStyle(color: kGreyColor),
                    prefixIcon: Icon(
                      Icons.search,
                      color: kDarkGreenColor,
                      size: 26.0,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.camera_alt),
                      color: kDarkGreenColor,
                      iconSize: 26.0,
                      splashRadius: 20.0,
                      onPressed: () {
                        setState(() {
                          _searchKeyword = ''; // Reset search keyword
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: kGinColor),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kGinColor),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kGinColor),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchKeyword = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: LayoutBuilder(
                    builder: (context, constraints) {
                      final combinedList = _combineLists(plants, cartItems);
                      final filteredPlants = _filterPlants(combinedList);
                      return GridView.count(
                        // shrinkWrap: true,
                        crossAxisCount: 2,
                    
                        crossAxisSpacing: 20.0,
                        childAspectRatio: 0.5,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        children: List.generate(
                          filteredPlants.length,
                              (index) => PlantCard(
                            plantType: filteredPlants[index].plantType,
                            plantName: filteredPlants[index].plantName,
                            plantPrice: filteredPlants[index].plantPrice,
                            image: Image.asset(
                              filteredPlants[index].image,
                              alignment: Alignment.topLeft,
                              height: 240, // Đặt chiều cao cố định cho ảnh
                              width: 100, // Đặt chiều rộng cố định cho ảnh
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PlantDetails(
                                      plant: filteredPlants[index],
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
              ),
            ],
          ),
        ),
      );
  }

  List<Plant> _combineLists(List<Plant> recommended, List<CartItem> cartItems) {
    List<Plant> combinedList = [...recommended];
    for (CartItem cartItem in cartItems) {
      combinedList.add(cartItem.plant);
    }
    return combinedList;
  }

  List<Plant> _filterPlants(List<Plant> plants) {
    if (_searchKeyword.isEmpty) {
      return plants;
    } else {
      return plants
          .where((plant) => plant.plantName
          .toLowerCase()
          .contains(_searchKeyword.toLowerCase()))
          .toList();
    }
  }

  int _calculateCrossAxisCount(BoxConstraints constraints) {
    if (constraints.maxWidth < 400) {
      return 1;
    } else if (constraints.maxWidth < 800) {
      return 2;
    } else if (constraints.maxWidth < 1000) {
      return 3;
    } else {
      return 4;
    }
  }
}
class PlantCard extends StatelessWidget {
  const PlantCard({
    required this.plantType,
    required this.plantName,
    required this.plantPrice,
    required this.image,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String plantType;
  final String plantName;
  final double plantPrice;
  final Image image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 220.0,
            width: 185.0,
            decoration: BoxDecoration(
              color: kGinColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: CustomPaint(
              painter: CurvePainter(),
            ),
          ),
          Positioned(
            // height: 240.0,
            // width: 124.0,
            left: 8.0,
            bottom: 70.0,
            child: Container(
              constraints:
                  const BoxConstraints(maxWidth: 124.0, maxHeight: 240.0),
              child: Hero(tag: plantName, child: image),
            ),
          ),
          Positioned(
            bottom: 90.0,
            left: 0.0,
            child: Container(
              width: 185,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plantType,
                            style: TextStyle(
                              color: kDarkGreenColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Expanded(
                            child: Text(
                              plantName,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                color: kDarkGreenColor,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 5.0,
                      ),
                      decoration: BoxDecoration(
                        color: kFoamColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      constraints: const BoxConstraints(maxWidth: 90.0),
                      child: Text(
                        '₹${plantPrice}0',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          color: kDarkGreenColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// class PlantCard extends StatelessWidget {
//   const PlantCard({
//     required this.plantType,
//     required this.plantName,
//     required this.plantPrice,
//     required this.image,
//     required this.onTap,
//     Key? key,
//   }) : super(key: key);
//   final String plantType;
//   final String plantName;
//   final double plantPrice;
//   final Image image;
//   final Function() onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             Positioned(
//               // height: 240.0,
//               // width: 124.0,
//               left: 8.0,
//               bottom: 70.0,
//               child: Container(
//                 constraints:
//                 const BoxConstraints(maxWidth: 124.0, maxHeight: 250.0),
//                 child: Hero(tag: plantName, child: image),
//               ),
//             ),
//             Positioned(
//               bottom: 0.0,
//               left: 0.0,
//               child: Container(
//                 width: 185,
//                 height: 70.0,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 child: Padding(
//                   padding:
//                   const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Flexible(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               plantType,
//                               style: TextStyle(
//                                 color: kDarkGreenColor,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             const SizedBox(height: 2.0),
//                             Expanded(
//                               child: Text(
//                                 plantName,
//                                 overflow: TextOverflow.fade,
//                                 maxLines: 1,
//                                 softWrap: false,
//                                 style: TextStyle(
//                                   color: kDarkGreenColor,
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 6.0,
//                           horizontal: 10.0,
//                         ),
//                         decoration: BoxDecoration(
//                           color: kFoamColor,
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         constraints: const BoxConstraints(maxWidth: 90.0),
//                         child: Text(
//                           'VND${plantPrice}0',
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                           softWrap: false,
//                           style: TextStyle(
//                             color: kDarkGreenColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 12.8,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//   }
// }
class RecentlyViewedCard extends StatelessWidget {
  const RecentlyViewedCard({
    required this.plantName,
    required this.plantInfo,
    required this.image,
    Key? key,
  }) : super(key: key);

  final String plantName;
  final String plantInfo;
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60.0,
          height: 60.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        const SizedBox(width: 24.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              plantName,
              style: GoogleFonts.poppins(
                color: kDarkGreenColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              plantInfo,
              style: GoogleFonts.poppins(
                color: kGreyColor,
              ),
            )
          ],
        ),
      ],
    );
  }
}
