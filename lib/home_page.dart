import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/models/home_page_model.dart';
import 'main.dart';
import 'search_page.dart';
import 'sell_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomeState createState() => _HomeState();
}

List<QueryDocumentSnapshot> carData1 = [];
List<QueryDocumentSnapshot> carData2 = [];

class _HomeState extends State<HomePage> {
  TextEditingController searchnameController = TextEditingController();

  bool isloading = true;

  getCars() async {
    isloading = false;
    setState(() {});
    QuerySnapshot querySnapshot1 = await FirebaseFirestore.instance
        .collection("car")
        .where("user_id", isEqualTo: "YRke9M8sLfZ6yLE6sLLSNgtdTP63")
        .get();
    carData1.addAll(querySnapshot1.docs);
    carData1 = carData1.toSet().toList();
    print("________________________________________________________");
    print(carData1);
    QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
        .collection("car")
        .where("user_id", isEqualTo: "SSRm2f00SugXalFnRDGnRyz4d7y1")
        .get();
    carData2.addAll(querySnapshot2.docs);
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    carData1 = [];
    carData2 = [];
    getCars();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 225, // Increase the height of the app bar
        backgroundColor: const Color(0xff1e2b33),
        elevation: 0,
        title: Column(
          children: [
            const SizedBox(height: 15),
            Image.asset('assets/images/logo.png',
                color: Orange // Replace with your logo image path
                ),
            const SizedBox(height: 7),
            const Text(
              'The Greatest Selection of Verified Cars in India',
              style: TextStyle(
                color: White,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: White,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: searchnameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Orange),
                  hintText: ('Search for New and Used Cars'),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onEditingComplete: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(
                          searchBy: 'name',
                          value: searchnameController.text ?? ""),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
      body: isloading
          ? const Center(
              child: SpinKitFadingCircle(
                color: Orange,
                size: 75.0,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      'Search By Body Type',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Orange),
                    ),
                  ),
                  SizedBox(
                    height: 115,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: carBodyTypes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchPage(
                                    searchBy: 'body',
                                    value: carBodyTypes[index].label),
                              ),
                            );
                          },
                          child: Card(
                            color: White,
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 0),
                                  width: 100,
                                  child: Image.asset(
                                    carBodyTypes[index].imagePath,
                                    fit: BoxFit.cover,
                                    color:
                                        Orange, // Replace with your logo image path
                                  ),
                                ),
                                Text(
                                  carBodyTypes[index].label,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500, color: Dark),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(
                    color: White,
                    thickness: 2,
                    indent: 60,
                    endIndent: 60,
                    height: 25,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      'Search By Fuel Type',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Orange),
                    ),
                  ),
                  SizedBox(
                    height: 115,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: carFuelTypes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchPage(
                                    searchBy: 'fuel',
                                    value: carFuelTypes[index].label),
                              ),
                            );
                          },
                          child: Card(
                            color: White,
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 0),
                                  width: 100,
                                  child: Image.asset(
                                    carFuelTypes[index].imagePath,
                                    fit: BoxFit.cover,
                                    color: Orange,
                                  ),
                                ),
                                Text(
                                  carFuelTypes[index].label,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500, color: Dark),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(
                    color: White,
                    thickness: 2,
                    indent: 60,
                    endIndent: 60,
                    height: 25,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      'Latest Cars From Our Featured Dealers',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Orange),
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dealers[0].name ?? "Dealer",
                                style: const TextStyle(
                                  color: Orange,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                // Horizontal scroll
                                child: Row(
                                  children: [
                                    for (Car car in dealers[0].car)
                                      SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width * .40),
                                        child: Card(
                                          color: White,
                                          child: Row(
                                            children: [
                                              // Car's image
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  car.image,
                                                  width: 120,
                                                ),
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      car.name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    // Car's price
                                                    Text(
                                                      car.price,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Orange,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    // Car's details: Fuel Type, Year, Speed
                                                    Row(
                                                      children: [
                                                        Text(
                                                          car.fuelType,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                        const Text(
                                                          ' | ',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Orange,
                                                          ),
                                                        ),
                                                        Text(
                                                          car.year,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10),
                                                        ),
                                                        const Text(
                                                          ' | ',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Orange,
                                                          ),
                                                        ),
                                                        Text(
                                                          car.speed,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Car's name
                                              const SizedBox(
                                                width: 10,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dealers[1].name,
                                style: const TextStyle(
                                  color: Orange,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                // Horizontal scroll
                                child: Row(
                                  children: [
                                    for (Car car in dealers[1].car)
                                      SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width  * .40),
                                        child: Card(
                                          color: White,
                                          child: Row(
                                            children: [
                                              // Car's image
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  car.image,
                                                  width: 120,
                                                ),
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      car.name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    // Car's price
                                                    Text(
                                                      car.price,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Orange,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    // Car's details: Fuel Type, Year, Speed
                                                    Row(
                                                      children: [
                                                        Text(
                                                          car.fuelType,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                        const Text(
                                                          ' | ',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Orange,
                                                          ),
                                                        ),
                                                        Text(
                                                          car.year,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10),
                                                        ),
                                                        const Text(
                                                          ' | ',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Orange,
                                                          ),
                                                        ),
                                                        Text(
                                                          car.speed,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Car's name
                                              const SizedBox(
                                                width: 10,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SellPage()),
              );
              break;
            default:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
              break;
          }
        },
        selectedItemColor: Orange,
        unselectedItemColor: White,
        currentIndex: 0,
        backgroundColor: const Color(0xff1e2b33),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_car_filled_rounded,
            ),
            label: 'Sell',
          ),
        ],
      ),
    );
  }
}


