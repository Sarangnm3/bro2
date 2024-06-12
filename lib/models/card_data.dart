class CarData {
  final String userId;
  final String name;
  final String price;
  final String fuel;
  final String year;
  final String kilometers;
  final String images;
  final String speed; // Added speed detail

  CarData({
    required this.userId,
    required this.name,
    required this.price,
    required this.fuel,
    required this.year,
    required this.kilometers,
    required this.images,
    required this.speed, // Added speed detail
  });
}