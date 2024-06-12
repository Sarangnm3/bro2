class CarBodyType {
  final String imagePath;
  final String label;

  CarBodyType({required this.imagePath, required this.label});
}

final List<CarBodyType> carBodyTypes = [
  CarBodyType(
    imagePath: 'assets/images/Sedan.jpg',
    label: 'Sedan',
  ),
  CarBodyType(
    imagePath: 'assets/images/SUVCrossover.jpg',
    label: 'SUV/Crossover',
  ),
  CarBodyType(
    imagePath: 'assets/images/Pick Up Truck.jpg',
    label: 'Pick Up Truck',
  ),
  CarBodyType(
    imagePath: 'assets/images/Hatchback.jpg',
    label: 'Hatchback',
  ),
  CarBodyType(
    imagePath: 'assets/images/Coupe.jpg',
    label: 'Coupe',
  ),
  CarBodyType(
    imagePath: 'assets/images/Bus.jpg',
    label: 'Bus',
  ),
  CarBodyType(
    imagePath: 'assets/images/Truck.jpg',
    label: 'Truck',
  ),
  CarBodyType(
    imagePath: 'assets/images/Van.jpg',
    label: 'Van',
  ),
  CarBodyType(
    imagePath: 'assets/images/Bike.jpg',
    label: 'Bike',
  ),
  // Add more car body types with their respective image paths and labels
];

class CarFuelType {
  final String imagePath;
  final String label;

  CarFuelType({required this.imagePath, required this.label});
}

final List<CarFuelType> carFuelTypes = [
  CarFuelType(
    imagePath: 'assets/images/Gasoline.jpg',
    label: 'Gasoline',
  ),
  CarFuelType(
    imagePath: 'assets/images/Diesel.jpg',
    label: 'Diesel',
  ),
  CarFuelType(
    imagePath: 'assets/images/Hybrid.jpg',
    label: 'Hybrid',
  ),
  CarFuelType(
    imagePath: 'assets/images/Electric.jpg',
    label: 'Electric',
  )
];

class Dealer {
  String name;
  List<Car> car;

  Dealer({required this.name, required this.car});
}

class Car {
  String name;
  String price;
  String fuelType;
  String year;
  String speed;
  String image;

  Car({
    required this.name,
    required this.price,
    required this.fuelType,
    required this.year,
    required this.speed,
    required this.image,
  });
}

List<Dealer> dealers = [
  Dealer(name: "Al Fadhel", car: [
    Car(
      name: "Ferrari",
      price: "10 Million YER",
      fuelType: "ne",
      year: "2022",
      speed: "200 km/h",
      image: "assets/images/car1.jpg",
    ),
    Car(
      name: "Ferrari",
      price: "10 Million YER",
      fuelType: "Gasoline",
      year: "2022",
      speed: "200 km/h",
      image: "assets/images/car1.jpg",
    ),
    Car(
      name: "Ferrari",
      price: "10 Million YER",
      fuelType: "Gasoline",
      year: "2022",
      speed: "200 km/h",
      image: "assets/images/car1.jpg",
    ),
  ]),
  Dealer(name: "AL-SHEHAB", car: [
    Car(
      name: "Bugatti",
      price: "15000\$",
      fuelType: "Diesel",
      year: "2021",
      speed: "180 km/h",
      image: "assets/images/car2.jpg",
    ),
    Car(
      name: "Bugatti",
      price: "15000\$",
      fuelType: "Diesel",
      year: "2021",
      speed: "180 km/h",
      image: "assets/images/car2.jpg",
    ),
  ]),
  // Add more dealers and cars as needed
];