import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_app/models/cart_item.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/models/recently_viewed.dart';

List<Plant> recommended = [
  Plant(
    plantType: 'Cây Trong Nhà',
    plantName: 'Cây Rắn',
    plantPrice: 80.0,
    stars: 4.0,
    metrics: PlantMetrics('8.2"', '52%', '4.2"'),
    image: 'images/snake_plant.png',
  ),
  Plant(
    plantType: 'Cây Trong Nhà',
    plantName: 'Cau',
    plantPrice: 480.0,
    stars: 3.5,
    metrics: PlantMetrics('8.2"', '52%', '4.2"'),
    image: 'images/Palm.png',
  ),
  Plant(
    plantType: 'Cây Ngoài Trời',
    plantName: 'Chi Sung',
    plantPrice: 600.0,
    stars: 4.6,
    metrics: PlantMetrics('8.2"', '52%', '4.2"'),
    image: 'images/ficuss_alii.png',
  ),
  Plant(
    plantType: 'Cây Ngoài Trời',
    plantName: 'Duối Cảnh',
    plantPrice: 4000.0,
    stars: 4.5,
    metrics: PlantMetrics('8.2"', '52%', '4.2"'),
    image: 'images/money_bonsai.png',
  ),
  Plant(
    plantType: 'Cây Ngoài Trời',
    plantName: 'Bách Xù',
    plantPrice: 2000.0,
    stars: 5.0,
    metrics: PlantMetrics('8.2"', '52%', '4.2"'),
    image: 'images/Juniper_Bonsai.png',
  ),
];

List<ViewHistory> viewed = [
  ViewHistory('Đuôi Công', 'Gai của nó không phát triển.', 'images/calathea.jpg'),
  ViewHistory('Xương Rồng', 'Nó có gai.', 'images/cactus.jpg'),
  ViewHistory('Móng Rồng Xoáy', 'Gai của nó không phát triển.', 'images/stephine_2.jpg'),
];

List<Plant> filterPlantsByType(String type) {
  return recommended.where((plant) => plant.plantType == type).toList();
}

List<Plant> getTopSellingPlants() {
  // Giả sử cây top-selling được định nghĩa dựa trên một điều kiện nào đó, ví dụ:
  return recommended.where((plant) => plant.plantPrice > 10000).toList(); // Ví dụ lọc cây có giá trên 10,000
}

// may ni kieu du lieu a, vi rang han dua vo ham de lam chi
List<CartItem> cartItems = [
  CartItem(
    Plant(
      plantType: 'Cây Trong Nhà',
      plantName: 'Đuôi Công',
      plantPrice: 100,
      image: 'images/calathea.jpg',
      stars: 3.5,
      metrics: PlantMetrics('', '', ''),
    ),
    2,
  ),
  CartItem(
    Plant(
      plantType: 'Cây Trong Nhà',
      plantName: 'Xương Rồng',
      plantPrice: 100,
      image: 'images/cactus.jpg',
      stars: 3.5,
      metrics: PlantMetrics('', '', ''),
    ),
    2,
  ),
  CartItem(
    Plant(
      plantType: 'Cây Trong Nhà',
      plantName: 'Đuôi Công',
      plantPrice: 100,
      image: 'images/calathea.jpg',
      stars: 3.5,
      metrics: PlantMetrics('', '', ''),
    ),
    2,
  ),
  CartItem(
    Plant(
      plantType: 'Cây Trong Nhà',
      plantName: 'Đuôi Công',
      plantPrice: 100,
      image: 'images/calathea.jpg',
      stars: 3.5,
      metrics: PlantMetrics('', '', ''),
    ),
    2,
  ),
];


Map<String, dynamic> plantToJson(Plant plant) => {
  'plantType': plant.plantType,
  'plantName': plant.plantName,
  'plantPrice': plant.plantPrice,
  'stars': plant.stars,
  'metrics': {
    'height': plant.metrics.height,
    'humidity': plant.metrics.humidity,
    'width': plant.metrics.width,
  },
  'image': plant.image,
};

Map<String, dynamic> viewHistoryToJson(ViewHistory viewHistory) => {
  'plantName': viewHistory.plantName,
  'plantInfo': viewHistory.plantInfo,
  'image': viewHistory.image,
};

Map<String, dynamic> cartItemToJson(CartItem cartItem) => {
  'plant': plantToJson(cartItem.plant),
  'quantity': cartItem.quantity,
};

Future<void> initializeFirebaseData() async {
  final firestore = FirebaseFirestore.instance;

  final recommendedQuery = await firestore.collection('recommended').limit(1).get();
  final viewedQuery = await firestore.collection('viewed').limit(1).get();
  final cartItemsQuery = await firestore.collection('cartItems').limit(1).get();

  if (recommendedQuery.docs.isEmpty && viewedQuery.docs.isEmpty && cartItemsQuery.docs.isEmpty) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final recommendedCollection = firestore.collection('recommended');
    for (final plant in recommended) {
      await recommendedCollection.add(plantToJson(plant));
    }

    final viewedCollection = firestore.collection('viewed');
    for (final viewHistory in viewed) {
      await viewedCollection.add(viewHistoryToJson(viewHistory));
    }

    final cartItemsCollection = firestore.collection('cartItems');
    for (final cartItem in cartItems) {
      await cartItemsCollection.add(cartItemToJson(cartItem));
    }
  }
}


Future<List<CartItem>> getCartItems(String uid) async {
  final firestore = FirebaseFirestore.instance;
  final cartItemsCollection = firestore.collection('cartItems');
  final querySnapshot = await cartItemsCollection.where('users', isEqualTo: uid).get();
  final cartItems = querySnapshot.docs.map((doc) {
    final data = doc.data();
    return CartItem(
      Plant.fromJson(data['plant']),
      data['quantity'],
    );
  }).toList();

  return cartItems;
}

Future<List<Plant>> getRecommend() async {
  final firestore = FirebaseFirestore.instance;
  final cartItemsCollection = firestore.collection('recommended');
  final querySnapshot = await cartItemsCollection.get();
  final recommended = querySnapshot.docs.map((doc) {
    final data = doc.data();
    return Plant(
      plantType: data['plantType'],
      plantName: data['plantName'],
      plantPrice: data['plantPrice'],
      image: data['image'],
      stars: data['stars'],
      metrics: PlantMetrics.fromJson(data['metrics']),
    );
  }).toList();

  return recommended;
}

Future<Plant?> getPlantDataByName(String plantName) async {
  final firestore = FirebaseFirestore.instance;
  final plantsCollection = firestore.collection('recommended');
  final querySnapshot = await plantsCollection.where('plantName', isEqualTo: plantName).get();

  if (querySnapshot.docs.isNotEmpty) {
    return Plant(
      plantType: querySnapshot.docs.first.data()['plantType'],
      plantName: querySnapshot.docs.first.data()['plantName'],
      plantPrice: querySnapshot.docs.first.data()['plantPrice'],
      image: querySnapshot.docs.first.data()['image'],
      stars: querySnapshot.docs.first.data()['stars'],
      metrics: PlantMetrics.fromJson(querySnapshot.docs.first.data()['metrics']),
    );
  } else {
    return null;
  }
}