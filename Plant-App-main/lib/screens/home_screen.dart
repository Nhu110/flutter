//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/components/curve.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/data.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/screens/indoor_screen.dart';
import 'package:plant_app/screens/outdoor_screen.dart';
import 'package:plant_app/screens/plant_details_screen.dart';
import 'package:plant_app/screens/cart_screen.dart';
import 'package:plant_app/screens/recommended_screen.dart';
import 'package:plant_app/screens/top_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String _searchKeyword = '';

class _HomeScreenState extends State<HomeScreen> {
  int selected = 0;

  @override
  void initState() {
    fetchCartItems();
    super.initState();
  }

  List<Plant> originalList = [];

  Future<void> fetchCartItems() async {
    final fetchedItems = await getRecommend();

    setState(() {
      recommended = fetchedItems;
      originalList = fetchedItems;
    });
    print(fetchedItems);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Flexible(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        'HÃY TÌM CÂY CHO BẠN !',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          color: kDarkGreenColor,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: kDarkGreenColor),
                            cursorColor: kDarkGreenColor,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: kGinColor,
                              hintText: 'Tìm Kiếm Cây',
                              hintStyle: TextStyle(color: kGreyColor),
                              prefixIcon: Icon(
                                Icons.search,
                                color: kDarkGreenColor,
                                size: 26.0,
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.mic),
                                color: kDarkGreenColor,
                                iconSize: 26.0,
                                splashRadius: 20.0,
                                onPressed: () {},
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
                              _filterPlants(originalList);
                            },
                          ),
                        ),

                        const SizedBox(width: 16.0),
                        // Thêm biểu tượng giỏ hàng
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, CartScreen.id);
                          },
                          child: CircleAvatar(
                            backgroundColor: kDarkGreenColor,
                            radius: 22.0,
                            child: IconButton(
                              color: Colors.white,
                              splashRadius: 28.0,
                              icon: const Icon(
                                Icons.shopping_cart_outlined,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, CartScreen.id);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // const SizedBox(height: 4.0),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: CategorySelector(
                      selected: selected,
                      categories: const [
                        'Tất cả',
                        'Gợi Ý',
                        'Bán Chạy',
                        'Cây Trong Nhà',
                        'Cây Ngoài Trời'
                      ],
                      onTap: (index) {
                        setState(() {
                          selected = index;
                        });
                        print(index);
                        if (index == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RecommendedScreen()));
                          // _filterPlantsByType("Recommended", originalList);
                        }
                        else if (index == 2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TopScreen()));
                          // _filterPlantsByType("Top", originalList);
                        } 
                        else
                        if (index == 3) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const IndoorScreen()));
                          // _filterPlantsByType("Indoor", originalList);
                        } else if (index == 4) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OutdoorScreen()));
                          // _filterPlantsByType("Outdoor", originalList);
                        } 
                        else{
                           _filterPlantsByType("", originalList);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 290.0,
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 220.0,
                            child: ListView.separated(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: recommended.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 20.0);
                              },
                              itemBuilder: (context, index) {
                                // final filteredPlants = _filterPlants(combinedList);
                                return PlantCard(
                                  plantType: recommended[index].plantType,
                                  plantName: recommended[index].plantName,
                                  plantPrice: recommended[index].plantPrice,
                                  image: Image.asset(
                                    recommended[index].image,
                                    alignment: Alignment.topLeft,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return PlantDetails(
                                            plant: recommended[index],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 16.0),
                          child: Text(
                            'Đã Xem Gần Đây',
                            style: TextStyle(
                              color: kDarkGreenColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80.0,
                          child: ListView.separated(
                            itemCount: viewed.length,
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return RecentlyViewedCard(
                                plantName: viewed[index].plantName,
                                plantInfo: viewed[index].plantInfo,
                                image: AssetImage(viewed[index].image),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 20.0);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _filterPlants(List<Plant> plants) {
    if (_searchKeyword.isEmpty) {
      setState(() {
        recommended = originalList;
      });
    } else {
      List<Plant> newList = plants
          .where((plant) => plant.plantName
              .toLowerCase()
              .contains(_searchKeyword.toLowerCase()))
          .toList();
      setState(() {
        recommended = newList;
      });
    }
  }

  void _filterPlantsByType(String type, List<Plant> plants) {
    if (type.isEmpty) {
      setState(() {
        recommended = originalList;
      });
    } else {
      List<Plant> newList = plants
          .where((plant) => plant.plantType.toLowerCase() == type.toLowerCase())
          .toList();
      print(newList.length);
      setState(() {
        recommended = newList;
      });
    }
  }
}

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
            bottom: 0.0,
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
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 10.0,
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
                          fontSize: 12.8,
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

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    Key? key,
    required this.selected,
    required this.categories,
    required this.onTap,
  }) : super(key: key);

  final int selected;
  final List<String> categories;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < categories.length; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              padding: EdgeInsets.symmetric(
                vertical: selected == i ? 8.0 : 0.0,
                horizontal: selected == i ? 12.0 : 0.0,
              ),
              decoration: BoxDecoration(
                color: selected == i ? kGinColor : Colors.transparent,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: GestureDetector(
                onTap: () {
                  onTap(i);
                },
                child: Align(
                  child: Text(
                    categories[i],
                    style: TextStyle(
                      color: selected == i ? kDarkGreenColor : kGreyColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
