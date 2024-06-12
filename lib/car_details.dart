import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'main.dart';

class CarDetailsPage extends StatefulWidget {
  final QueryDocumentSnapshot carData;

  const CarDetailsPage({super.key, required this.carData});

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  @override
  List<String> images = [];
  String? currentUserName;
  bool isloading = true;

  // getData() async {
  //   DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
  //   await FirebaseFirestore.instance.collection("car").doc(widget.carId).get();
  //   carData = documentSnapshot.data();
  //   images = carData?['images'].split(',');
  //   isloading=false;
  //   setState(() {
  //
  //   });
  // }

  Future<String?> getCurrentUserUsername() async {
    final userQuery = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.carData['user_id'])
        .get();
    currentUserName = userQuery["Name"];
    isloading = false;
    setState(() {});
    return null;
  }

  @override
  void initState() {
    getCurrentUserUsername();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: White,
      appBar: AppBar(
        backgroundColor: Dark,
        title: const Text('Car Details'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 230,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1000),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.7,
                    ),
                    items: splitImages(widget.carData['images']).map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.network(image);
                        },
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          color: Dark,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          '${widget.carData['name']}',
                          style: const TextStyle(
                              color: Dark,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${widget.carData['description']}',
                          style: const TextStyle(color: Dark, fontSize: 16),
                        ),
                        const Divider(color: Dark),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Icon(Icons.attach_money, color: Dark),
                            Text(
                              '\$${widget.carData['price']}',
                              style: const TextStyle(
                                  color: Orange,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 100),
                            const Icon(
                              Icons.location_on_outlined,
                              color: Dark,
                            ),
                            Text(
                              '${widget.carData['location']}',
                              style: const TextStyle(
                                  color: Orange,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Highlights',
                          style: TextStyle(
                              color: Dark,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const Divider(color: Dark),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Dark,
                                  ),
                                  const SizedBox(height: 15),
                                  const Text(
                                    'Year',
                                    style: TextStyle(color: Dark, fontSize: 14),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${widget.carData['year']}',
                                    style: const TextStyle(
                                        color: Orange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                width: 1,
                                color: Dark,
                                height: 85), // Vertical divider
                            Expanded(
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.speed,
                                    color: Dark,
                                  ),
                                  const SizedBox(height: 15),
                                  const Text(
                                    'Kilometers',
                                    style: TextStyle(color: Dark, fontSize: 14),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${widget.carData['kilometers']} Km',
                                    style: const TextStyle(
                                        color: Orange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                width: 1,
                                color: Dark,
                                height: 85), // Vertical divider
                            Expanded(
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.local_gas_station,
                                    color: Dark,
                                  ),
                                  const SizedBox(height: 15),
                                  const Text(
                                    'Fuel Type',
                                    style: TextStyle(color: Dark, fontSize: 14),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${widget.carData['fuel']}',
                                    style: const TextStyle(
                                        color: Orange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                width: 1,
                                color: Dark,
                                height: 85), // Vertical divider
                            Expanded(
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.settings,
                                    color: Dark,
                                  ),
                                  const SizedBox(height: 15),
                                  const Text(
                                    'Gearbox',
                                    style: TextStyle(color: Dark, fontSize: 14),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${widget.carData['gearbox']}',
                                    style: const TextStyle(
                                        color: Orange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Divider(color: Dark),
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.branding_watermark),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  "Brand",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  "${widget.carData['brand']}",
                                  style: const TextStyle(
                                    color: Orange,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: Dark),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.model_training),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  "Model",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  "${widget.carData['model']}",
                                  style: const TextStyle(
                                    color: Orange,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: Dark),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.color_lens),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  "Color",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 110),
                                Text(
                                  "${widget.carData['color']}",
                                  style: const TextStyle(
                                    color: Orange,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: Dark),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.format_shapes),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  "Body",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 110,
                                ),
                                Text(
                                  "${widget.carData['body']}",
                                  style: const TextStyle(
                                    color: Orange,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: Dark),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.ev_station),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  "Cylinders",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 80,
                                ),
                                Text(
                                  "${widget.carData['cylinder']}",
                                  style: const TextStyle(
                                    color: Orange,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: Dark),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.check_circle),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  "Condition",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 77,
                                ),
                                Text(
                                  "${widget.carData['condition']}",
                                  style: const TextStyle(
                                    color: Orange,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: Dark),
                            Row(
                              children: [
                                const Text(
                                  'Listed by: ',
                                  style: TextStyle(
                                      color: Dark,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  currentUserName ?? "Admin",
                                  style: const TextStyle(
                                      color: Orange,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  List<String> splitImages(String images) {
    List<String> i = images.split(',');
    if (i[i.length - 1] == "") {
      i.removeAt(i.length - 1);
    }
    return i;
  }
}
