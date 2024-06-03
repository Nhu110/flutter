import 'package:flutter/material.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/screens/plant_details_screen.dart';
import 'package:plant_app/data.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Plant> sortedPlants = [...recommended];
    sortedPlants.sort((a, b) => b.plantPrice.compareTo(a.plantPrice));
    List<Plant> topPlants = sortedPlants.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Selling Plants'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: topPlants.length,
        itemBuilder: (context, index) {
          Plant plant = topPlants[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlantDetails(plant: plant),
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