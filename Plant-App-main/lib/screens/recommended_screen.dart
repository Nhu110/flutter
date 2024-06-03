import 'package:flutter/material.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/screens/plant_details_screen.dart';
import 'package:plant_app/data.dart';

class RecommendedScreen extends StatelessWidget {
  const RecommendedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Plant> filteredPlants = recommended.where((plant) => plant.stars > 3.5).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommended Plants'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: filteredPlants.length, // Sử dụng filteredPlants thay vì recommended
        itemBuilder: (context, index) {
          Plant plant = filteredPlants[index]; // Sử dụng filteredPlants thay vì recommended
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlantDetails(plant: plant), // Sửa thành PlantDetailsScreen
                ),
              );
            },
            child: Card(
              child: ListTile(
                leading: Image.asset(plant.image),
                title: Text(plant.plantName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Type: ${plant.plantType}'),
                    Text('Price: ₹${plant.plantPrice.toStringAsFixed(2)}'),
                    Text('Stars: ${plant.stars.toStringAsFixed(1)}'),
                    Text('Metrics: ${plant.metrics.toString()}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
