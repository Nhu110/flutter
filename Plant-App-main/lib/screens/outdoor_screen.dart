import 'package:flutter/material.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/screens/plant_details_screen.dart';
import 'package:plant_app/data.dart';

class OutdoorScreen extends StatelessWidget {
  const OutdoorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Plant> outdoorPlants = filterPlantsByType('Outdoor');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Outdoor Plants'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: outdoorPlants.length,
        itemBuilder: (context, index) {
          Plant plant = outdoorPlants[index];
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