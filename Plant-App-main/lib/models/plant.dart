class Plant {
  final String plantType;
  final String plantName;
  final double plantPrice;
  final String image;
  final double stars;
  final PlantMetrics metrics;

  Plant({
    required this.plantType,
    required this.plantName,
    required this.plantPrice,
    required this.image,
    required this.stars,
    required this.metrics,
  });
  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
    plantType: json['plantType'],
    plantName: json['plantName'],
    plantPrice: json['plantPrice'].toDouble(),
    stars: json['stars'].toDouble(),
    metrics: PlantMetrics.fromJson(json['metrics']),
    image: json['image'],
  );
  Map<String, dynamic> toJson() => {
    'plantType': plantType,
    'plantName': plantName,
    'plantPrice': plantPrice,
    'stars': stars,
    'metrics': metrics.toJson(),
    'image': image,
  };
}

class PlantMetrics {
  final String height;
  final String humidity;
  final String width;

  PlantMetrics(this.height, this.humidity, this.width);
  factory PlantMetrics.fromJson(Map<String, dynamic> json) => PlantMetrics(
    json['height'],
    json['humidity'],
    json['width'],
  );
  Map<String, dynamic> toJson() => {
    'height': height,
    'humidity': humidity,
    'width': width,
  };
}
