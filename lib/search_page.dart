import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'car_details.dart';
import 'home_page.dart';
import 'sell_page.dart';
import 'login.dart';

String _selectedCondition = 'New & Used';
List<String> carConditionOptions = [
  'New & Used',
  'New',
  'Used',
];
int _selectedMinimumPrice = 0;
int _selectedMaximumPrice = 1000000;
List<int> priceOptions = [
  0,
  10000,
  20000,
  30000,
  40000,
  50000,
  60000,
  70000,
  80000,
  90000,
  100000,
  200000,
  300000,
  400000,
  500000,
  600000,
  700000,
  800000,
  900000,
  1000000,
];
String _selectedLocation = 'All';
List<String> locationOptions = [
  'All',
  'Chennai',
  'Bangalore',
  'Kochi',
  'Trivandrum',
  'Delhi',
  'Hyderabad',
  'Kozhikode',
  'Coimbatore',
  'Goa',
  ''
];
int? _selectedMinimumYear = 1990;
int? _selectedMaximumYear = DateTime.now().year;
List<int> yearOptions =
    List.generate(DateTime.now().year - 1989, (index) => 1990 + index);
int _selectedMinimumKilometers = 0;
int _selectedMaximumKilometers = 200000;
List<int> kilometerOptions = List.generate(21, (index) => (index) * 10000);
String _selectedType = "All";
List<String> typeOptions = [
  'All',
  'Sedan',
  'SUV/Crossover',
  'Pick Up Truck',
  'Hatchback',
  'Coup',
  'Bus',
  'Truck',
  'Van',
  'Bike'
];
String _selectedFuel = "All";
List<String> fuelOptions = ['All', 'Gasoline', 'Diesel', 'Hybrid', 'Electric'];

String _selectedGear = "All";
List<String> gearOptions = ['All', 'Manual', 'Automatic'];
String _selectedCylinders = "All";
List<String> cylindersOptions = [
  'All',
  '2',
  '3',
  '4',
  '5',
  '6',
  '8',
  '10',
  '12',
  '16',
  'Unknown',
  'None - Electric'
];
String _selectedColor = "All";
List<String> colorOptions = [
  'All',
  'Beige',
  'Black',
  'Blue',
  'Bronze',
  'Brown',
  'Burgundy',
  'Gold',
  'Grey',
  'Maroon',
  'Orange',
  'Pink',
  'Purple',
  'Red',
  'Silver',
  'Tan',
  'Teal',
  'Turquoise',
  'White',
  'Yellow',
  'Other Color'
];

class SearchPage extends StatefulWidget {
  String? searchBy;
  String? value;
  SearchPage({super.key, this.searchBy, this.value});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<QueryDocumentSnapshot> carData = [];
  TextEditingController searchnameController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  bool isloading = true;

  getData() async {
    if (widget.searchBy == null) {
      print(widget.value);
      getAllData();
    } else if (widget.searchBy == 'body') {
      print(
          "_______________________________________________________________________1$widget.value");
      print(widget.value);

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("car")
          .where("body", isEqualTo: widget.value)
          .get();
      carData.addAll(querySnapshot.docs);
      isloading = false;
      setState(() {});
    } else if (widget.searchBy == 'fuel') {
      print(
          "_______________________________________________________________________1$widget.value");
      print(widget.value);

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("car")
          .where("fuel", isEqualTo: widget.value)
          .get();
      carData.addAll(querySnapshot.docs);
      isloading = false;
      setState(() {});
    } else if (widget.searchBy == 'name') {
      print(
          "_______________________________________________________________________1$widget.value");
      print(widget.searchBy);
      print(widget.value);
      print(searchnameController.text);
      setState(() {
        searchnameController.text = widget.value!;
      });
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("car")
          .orderBy("name")
          .where("name", isEqualTo: widget.value)
          .get();
      carData.addAll(querySnapshot.docs);
      isloading = false;
      setState(() {});
    }
  }

  getAllData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("car").get();
    carData.addAll(querySnapshot.docs);
    isloading = false;
    setState(() {});
  }

  String _searchQuery = '';
  bool _isFilterDrawerOpen = false;
  int searchResultsCount = 3;
  String _selectedSortOption = 'Sort By';

  void _showFilterDrawer() {
    setState(() {
      _isFilterDrawerOpen = true;
    });
  }

  void _hideFilterDrawer() {
    setState(() {
      _isFilterDrawerOpen = false;
    });
  }

  Future<bool> _onWillPop() async {
    if (_isFilterDrawerOpen) {
      _hideFilterDrawer();
      return false;
    }
    return true;
  }

  void _selectCondition(String carCondition) {
    setState(() {
      _selectedCondition = carCondition;
    });
  }

  void _selectMinimumPrice(int price) {
    setState(() {
      _selectedMinimumPrice = price;
    });
  }

  void _selectMaximumPrice(int price) {
    setState(() {
      _selectedMaximumPrice = price;
    });
  }

  void _selectLocation(String location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  void _selectMinimumYear(int? year) {
    setState(() {
      _selectedMinimumYear = year;
    });
  }

  void _selectMaximumYear(int? year) {
    setState(() {
      _selectedMaximumYear = year;
    });
  }

  void _selectMinimumKilometers(int kilometers) {
    setState(() {
      _selectedMinimumKilometers = kilometers;
    });
  }

  void _selectMaximumKilometers(int kilometers) {
    setState(() {
      _selectedMaximumKilometers = kilometers;
    });
  }

  void _selectType(String type) {
    setState(() {
      _selectedType = type;
    });
  }

  void _selectFuel(String type) {
    setState(() {
      _selectedFuel = type;
    });
  }

  void _selectGear(String type) {
    setState(() {
      _selectedGear = type;
    });
  }

  void _selectCylinders(String type) {
    setState(() {
      _selectedCylinders = type;
    });
  }

  void _selectColor(String type) {
    setState(() {
      _selectedColor = type;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => _onWillPop,
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Dark,
            elevation: 0,
            title: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.searchBy != 'name'
                        ? searchnameController
                        : searchController,
                    cursorColor: White,
                    style: const TextStyle(color: White),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Orange,
                      labelText: 'Search',
                      labelStyle: TextStyle(color: Orange),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: White),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Orange),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  color: Orange,
                  onPressed: _showFilterDrawer,
                ),
              ],
            )),
        body: isloading
            ? const Center(
                child: SpinKitFadingCircle(
                  color: Orange,
                  size: 75.0,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: (carData.isNotEmpty)
                      ? [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${carData.length} Cars Found",
                                      style: const TextStyle(color: Orange)),
                                ), // Replace with your desired format
                              ),
                              DropdownButton<String>(
                                style: const TextStyle(
                                  color: Orange,
                                  fontWeight: FontWeight.bold,
                                ),
                                dropdownColor: White,
                                icon: (const Icon(
                                  Icons.sort,
                                  color: Orange,
                                )),
                                value: _selectedSortOption,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedSortOption = newValue!;
                                    // Add your sort functionality here based on the selected option
                                  });
                                },
                                items: <String>[
                                  'Sort By',
                                  'Price (Low to High)',
                                  'Price (High to Low)',
                                  'Year (Low to High)',
                                  'Year (High to Low)',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: carData.length,
                            itemBuilder: (context, index) {
                              final car = carData[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CarDetailsPage(
                                          carData: carData[index]),
                                    ),
                                  );
                                },
                                child: Card(
                                  color: White,
                                  margin: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 8, right: 8),
                                        child: CarouselSlider(
                                          options: CarouselOptions(
                                            autoPlay: true,
                                            enlargeCenterPage: true,
                                            enableInfiniteScroll: true,
                                            viewportFraction: 1.0,
                                          ),
                                          items: splitImages(
                                                  carData[index]['images'])
                                              .map((image) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                return Image.network(image);
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 10),
                                          child: Text(carData[index]['name'],
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Dark)),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 10),
                                          child: Text(
                                              '\$${carData[index]['price']}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Orange)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(children: [
                                              const Icon(
                                                Icons.location_on_rounded,
                                                size: 16,
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(carData[index]['location'],
                                                  style: const TextStyle(
                                                      fontSize: 12)),
                                            ]),
                                            const Text(
                                              "|",
                                              style: TextStyle(
                                                  color: Orange,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(children: [
                                              const Icon(
                                                Icons.calendar_month_rounded,
                                                size: 16,
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                  carData[index]['model']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12)),
                                            ]),
                                            const Text(
                                              "|",
                                              style: TextStyle(
                                                  color: Orange,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(children: [
                                              const Icon(
                                                Icons.speed_rounded,
                                                size: 16,
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                  '${carData[index]['kilometers']} km',
                                                  style: const TextStyle(
                                                      fontSize: 12)),
                                            ]),
                                            const Text(
                                              "|",
                                              style: TextStyle(
                                                  color: Orange,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(children: [
                                              Image.asset(
                                                'assets/gearbox.png',
                                                width: 16,
                                                height: 16,
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(carData[index]['gearbox'],
                                                  style: const TextStyle(
                                                      fontSize: 12)),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      ButtonBar(
                                        alignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // Email button
                                          IconButton(
                                            onPressed: () {
                                              // Implement email functionality
                                              // Example: launch email app with car details pre-filled
                                            },
                                            icon: Image.asset(
                                              'assets/whatsapp.png',
                                              width: 24,
                                              height: 24,
                                              color: Orange,
                                            ),
                                          ),
                                          // WhatsApp button
                                          IconButton(
                                            onPressed: () {
                                              // Implement WhatsApp functionality
                                              // Example: open WhatsApp with car details pre-filled
                                            },
                                            icon: const Icon(
                                              Icons.call,
                                              color: Orange,
                                            ),
                                          ),
                                          // SMS button
                                          IconButton(
                                            onPressed: () {
                                              // Implement SMS functionality
                                              // Example: open SMS app with car details pre-filled
                                            },
                                            icon: const Icon(
                                              Icons.sms,
                                              color: Orange,
                                            ),
                                          ),
                                          // Call button
                                          IconButton(
                                            onPressed: () {
                                              // Implement call functionality
                                              // Example: initiate a call with car owner's phone number
                                            },
                                            icon: const Icon(
                                              Icons.mail_outline_rounded,
                                              color: Orange,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ]
                      : [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 5),
                          Image.asset('assets/no_car.png'),
                          const Center(
                              child: Text(
                            "No Results Found For That Filter",
                            style: TextStyle(color: White),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            WidgetStatePropertyAll(Orange)),
                                    onPressed: () {},
                                    child: const Text(
                                      "Clear Filters",
                                      style: TextStyle(color: White),
                                    ))),
                          ),
                        ],
                ),
              ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                break;
              case 1:
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
          currentIndex: 1,
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
        bottomSheet: _isFilterDrawerOpen
            ? Container(
                color: White,
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          onPressed: _hideFilterDrawer,
                          color: Dark,
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Filters',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Dark),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        color: White,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text(
                                  'Condition',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Dark),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _selectedCondition,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Orange,
                                      ),
                                    ),
                                    const Icon(Icons.keyboard_arrow_right),
                                  ],
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: Dark,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              for (String option
                                                  in carConditionOptions)
                                                ListTile(
                                                  title: Text(
                                                    option,
                                                    style: const TextStyle(
                                                        color: White),
                                                  ),
                                                  trailing:
                                                      _selectedCondition ==
                                                              option
                                                          ? const Icon(
                                                              Icons.check,
                                                              color: Orange)
                                                          : null,
                                                  onTap: () {
                                                    _selectCondition(option);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ), //Condition
                              const Divider(color: Dark),
                              ListTile(
                                title: const Text(
                                  'Price',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Dark),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '$_selectedMinimumPrice\$ - $_selectedMaximumPrice\$',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Orange,
                                      ),
                                    ),
                                    const Icon(Icons.keyboard_arrow_right),
                                  ],
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: Dark,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const ListTile(
                                                title: Text(
                                                  'Minimum Price',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Orange),
                                                ),
                                              ),
                                              const Divider(
                                                  color: Orange,
                                                  thickness: 3,
                                                  indent: 100,
                                                  endIndent: 100,
                                                  height: 0),
                                              for (int option in priceOptions)
                                                ListTile(
                                                  title: Text(
                                                    '$option\$',
                                                    style: const TextStyle(
                                                        color: White),
                                                  ),
                                                  trailing:
                                                      _selectedMinimumPrice ==
                                                              option
                                                          ? const Icon(
                                                              Icons.check,
                                                              color: Orange)
                                                          : null,
                                                  onTap: () {
                                                    _selectMinimumPrice(option);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              const ListTile(
                                                title: Text(
                                                  'Maximum Price',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Orange),
                                                ),
                                              ),
                                              const Divider(
                                                  color: Orange,
                                                  thickness: 3,
                                                  indent: 100,
                                                  endIndent: 100,
                                                  height: 0),
                                              for (int option in priceOptions)
                                                ListTile(
                                                  title: Text(
                                                    '$option\$',
                                                    style: const TextStyle(
                                                        color: White),
                                                  ),
                                                  trailing:
                                                      _selectedMaximumPrice ==
                                                              option
                                                          ? const Icon(
                                                              Icons.check,
                                                              color: Orange)
                                                          : null,
                                                  onTap: () {
                                                    _selectMaximumPrice(option);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ), //Price
                              const Divider(color: Dark),
                              ListTile(
                                title: const Text(
                                  'Location',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Dark),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _selectedLocation,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Orange,
                                      ),
                                    ),
                                    const Icon(Icons.keyboard_arrow_right),
                                  ],
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: Dark,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              for (String option
                                                  in locationOptions)
                                                ListTile(
                                                  title: Text(
                                                    option,
                                                    style: const TextStyle(
                                                        color: White),
                                                  ),
                                                  trailing: _selectedLocation ==
                                                          option
                                                      ? const Icon(Icons.check,
                                                          color: Orange)
                                                      : null,
                                                  onTap: () {
                                                    _selectLocation(option);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ), //Location
                              const Divider(color: Dark),
                              ListTile(
                                title: const Text(
                                  'Year',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Dark),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '$_selectedMinimumYear - $_selectedMaximumYear',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Orange,
                                      ),
                                    ),
                                    const Icon(Icons.keyboard_arrow_right),
                                  ],
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: Dark,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const ListTile(
                                                title: Text(
                                                  'Minimum Year',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Orange),
                                                ),
                                              ),
                                              const Divider(
                                                  color: Orange,
                                                  thickness: 3,
                                                  indent: 100,
                                                  endIndent: 100,
                                                  height: 0),
                                              for (int option in yearOptions)
                                                ListTile(
                                                  title: Text(
                                                    option.toString(),
                                                    style: const TextStyle(
                                                        color: White),
                                                  ),
                                                  trailing:
                                                      _selectedMinimumYear ==
                                                              option
                                                          ? const Icon(
                                                              Icons.check,
                                                              color: Orange)
                                                          : null,
                                                  onTap: () {
                                                    _selectMinimumYear(option);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              const ListTile(
                                                title: Text(
                                                  'Maximum Price',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Orange),
                                                ),
                                              ),
                                              const Divider(
                                                  color: Orange,
                                                  thickness: 3,
                                                  indent: 100,
                                                  endIndent: 100,
                                                  height: 0),
                                              for (int option in yearOptions)
                                                ListTile(
                                                  title: Text(
                                                    option.toString(),
                                                    style: const TextStyle(
                                                        color: White),
                                                  ),
                                                  trailing:
                                                      _selectedMaximumYear ==
                                                              option
                                                          ? const Icon(
                                                              Icons.check,
                                                              color: Orange)
                                                          : null,
                                                  onTap: () {
                                                    _selectMaximumYear(option);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ), //Year
                              const Divider(color: Dark),
                              ListTile(
                                title: const Text(
                                  'Kilometers',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Dark),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '$_selectedMinimumKilometers km - $_selectedMaximumKilometers km',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Orange,
                                      ),
                                    ),
                                    const Icon(Icons.keyboard_arrow_right),
                                  ],
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: Dark,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const ListTile(
                                                title: Text(
                                                  'Minimum Kilometers',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Orange),
                                                ),
                                              ),
                                              const Divider(
                                                  color: Orange,
                                                  thickness: 3,
                                                  indent: 100,
                                                  endIndent: 100,
                                                  height: 0),
                                              for (int option
                                                  in kilometerOptions)
                                                ListTile(
                                                  title: Text(
                                                    '$option km',
                                                    style: const TextStyle(
                                                        color: White),
                                                  ),
                                                  trailing:
                                                      _selectedMinimumKilometers ==
                                                              option
                                                          ? const Icon(
                                                              Icons.check,
                                                              color: Orange)
                                                          : null,
                                                  onTap: () {
                                                    _selectMinimumKilometers(
                                                        option);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              const ListTile(
                                                title: Text(
                                                  'Maximum Kilometers',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Orange),
                                                ),
                                              ),
                                              const Divider(
                                                  color: Orange,
                                                  thickness: 3,
                                                  indent: 100,
                                                  endIndent: 100,
                                                  height: 0),
                                              for (int option
                                                  in kilometerOptions)
                                                ListTile(
                                                  title: Text(
                                                    '$option km',
                                                    style: const TextStyle(
                                                        color: White),
                                                  ),
                                                  trailing:
                                                      _selectedMaximumKilometers ==
                                                              option
                                                          ? const Icon(
                                                              Icons.check,
                                                              color: Orange)
                                                          : null,
                                                  onTap: () {
                                                    _selectMaximumKilometers(
                                                        option);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ), //Kilometers
                              const Divider(color: Dark),
                              ListTile(
                                title: const Text(
                                  'Vehicle Type',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Dark),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _selectedType,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Orange,
                                      ),
                                    ),
                                    const Icon(Icons.keyboard_arrow_right),
                                  ],
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: Dark,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              for (String option in typeOptions)
                                                ListTile(
                                                  title: Text(
                                                    option,
                                                    style: const TextStyle(
                                                        color: White),
                                                  ),
                                                  trailing: _selectedType ==
                                                          option
                                                      ? const Icon(Icons.check,
                                                          color: Orange)
                                                      : null,
                                                  onTap: () {
                                                    _selectType(option);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ), //Type
                              const Divider(color: Dark),
                              ListTile(
                                title: const Text(
                                  'Fuel Type',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Dark),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _selectedFuel,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Orange,
                                      ),
                                    ),
                                    const Icon(Icons.keyboard_arrow_right),
                                  ],
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: Dark,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              for (String option in fuelOptions)
                                                ListTile(
                                                  title: Text(
                                                    option,
                                                    style: const TextStyle(
                                                        color: White),
                                                  ),
                                                  trailing: _selectedFuel ==
                                                          option
                                                      ? const Icon(Icons.check,
                                                          color: Orange)
                                                      : null,
                                                  onTap: () {
                                                    _selectFuel(option);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ), //Fuel
                              const Divider(color: Dark),
                              ListTile(
                                title: const Text(
                                  'Gearbox',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Dark),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _selectedGear,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Orange,
                                      ),
                                    ),
                                    const Icon(Icons.keyboard_arrow_right),
                                  ],
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: Dark,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              for (String option in gearOptions)
                                                ListTile(
                                                  title: Text(
                                                    option,
                                                    style: const TextStyle(
                                                        color: White),
                                                  ),
                                                  trailing: _selectedGear ==
                                                          option
                                                      ? const Icon(Icons.check,
                                                          color: Orange)
                                                      : null,
                                                  onTap: () {
                                                    _selectGear(option);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ), //Gear
                              const Divider(color: Dark),
                              ListTile(
                                title: const Text(
                                  'Cylinders',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Dark),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _selectedCylinders,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Orange,
                                      ),
                                    ),
                                    const Icon(Icons.keyboard_arrow_right),
                                  ],
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: Dark,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              for (String option
                                                  in cylindersOptions)
                                                ListTile(
                                                  title: Text(
                                                    option,
                                                    style: const TextStyle(
                                                        color: White),
                                                  ),
                                                  trailing:
                                                      _selectedCylinders ==
                                                              option
                                                          ? const Icon(
                                                              Icons.check,
                                                              color: Orange)
                                                          : null,
                                                  onTap: () {
                                                    _selectCylinders(option);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ), //Cylinders
                              const Divider(color: Dark),
                              ListTile(
                                title: const Text(
                                  'Color',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Dark),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _selectedColor,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Orange,
                                      ),
                                    ),
                                    const Icon(Icons.keyboard_arrow_right),
                                  ],
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: Dark,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              for (String option
                                                  in colorOptions)
                                                ListTile(
                                                  title: Text(
                                                    option,
                                                    style: const TextStyle(
                                                        color: White),
                                                  ),
                                                  trailing: _selectedColor ==
                                                          option
                                                      ? const Icon(Icons.check,
                                                          color: Orange)
                                                      : null,
                                                  onTap: () {
                                                    _selectColor(option);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ), //Color
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : null,
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
