import 'package:dormitory_management/models/dormitory.dart';
import 'package:dormitory_management/ui/pages/dormitory_details_page.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/dorm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/rating.dart';

class CompareDormitoriesPage extends ConsumerStatefulWidget {
  const CompareDormitoriesPage({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _CompareDormitoriesPageState();
}

class _CompareDormitoriesPageState extends ConsumerState<CompareDormitoriesPage> {
  List<String> filters = [
    'Clean Service',
    'TV',
    'AC',
    'Shower',
    'Internet',
    'Kitchen',
    'Balcony',
    'Microwave'
  ];

  bool hasMicrowave = true;
  bool hasKitchen = true;
  bool hasCleanService = true;
  bool hasShowerAndToilet = true;
  bool hasBalcony = true;
  bool hasTV = true;
  bool hasAirConditioning = true;
  bool internetSpeed = true;

  Set<String> selectedFilters = {};


  List<Dormitory> dormitories = [];

  bool isLoading = false;

  @override
  void initState() {
    getAllDormitories();
    super.initState();
  }

  Future<void> getAllDormitories() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    setState(() {
      isLoading = true;
    });
    dormitories = await dormManager.getAllDormitories();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(dormManagerProvider);

    List<Dormitory> filteredDormitories = dormitories.where((dormitory) {
      if (dormitory.dormitoryDetails!.hasMicrowave == true && hasMicrowave) {
        return true;
      } else if (dormitory.dormitoryDetails!.hasKitchen == true && hasKitchen) {
        return true;
      } else if (dormitory.dormitoryDetails!.hasCleanService == true && hasCleanService) {
        return true;
      } else if (dormitory.dormitoryDetails!.hasShowerAndToilet == true && hasShowerAndToilet) {
        return true;
      } else if (dormitory.dormitoryDetails!.hasBalcony == true && hasBalcony) {
        return true;
      } else if (dormitory.dormitoryDetails!.hasTV == true && hasTV) {
        return true;
      } else if (dormitory.dormitoryDetails!.hasAirConditioning == true && hasAirConditioning) {
        return true;
      } else if (dormitory.dormitoryDetails!.internetSpeed!.isNotEmpty && internetSpeed) {
        return true;
      } else {
        return false;
      }
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: getCustomAppBar(context),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomDrawer(),
            Expanded(
              flex: 2,
              child: filteredDormitories.isEmpty ? const Center(
                child: Text("Dormitories not found"),
              ) : ListView(
                children: filteredDormitories.map((dormitory) {
                  double rate = 0.0;

                  if (dormitory.ratings != null) {
                    for (Rating rating in dormitory.ratings!) {
                      rate += rating.ratingNo!;
                    }
                    if (rate != 0) {
                      rate /= dormitory.ratings!.length;
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  bottomLeft: Radius.circular(15.0),
                                ),
                                child: dormitory.name == "Pop Art" ? Image.asset(
                                  'assets/images/home_img1.png',
                                  fit: BoxFit.fill,

                                  width: 350,
                                ) : dormitory.name == "Alfam Vista" ? Image.asset(
                                  'assets/images/alfam.jpeg',
                                  fit: BoxFit.fill,

                                  width: 350,
                                ) : dormitory.name == "Golden Plus" ? Image.asset(
                                  'assets/images/goldenplus.jpg',
                                  fit: BoxFit.fill,

                                  width: 350,
                                ) : Image.asset(
                                  'assets/images/home_img1.png',
                                  fit: BoxFit.contain,
                                  height: 200,
                                  width: 350,
                                ),
                              ),
                            ),
                            const SizedBox(width: 25.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 8),
                                  Text(
                                    dormitory.name!,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Rating: ${rate.toStringAsFixed(1)} stars',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  dormitory.dormitoryDetails!.description!.length > 30 ?
                                  Text("${dormitory.dormitoryDetails?.description!.substring(0,30)}...",
                                    style: const TextStyle(
                                      overflow: TextOverflow.fade,
                                    ),
                                  ) : Text("${dormitory.dormitoryDetails?.description}",
                                    style: const TextStyle(
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DormitoryDetailsPage(dormitory: dormitory)));
                                    },
                                    child: const Text('Show More'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Features',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            FilterChip(
                              label: const Text("Clean Service"),
                              selected: hasCleanService,
                              onSelected: (bool selected) {
                                setState(() {
                                  hasCleanService = !hasCleanService;
                                });
                              },
                              selectedColor: Colors.green[100],
                              checkmarkColor: Colors.black,
                              backgroundColor: hasCleanService ? Colors.green[100] : Colors.red[100],
                            ),
                            FilterChip(
                              label: const Text("TV"),
                              selected: hasTV,
                              onSelected: (bool selected) {
                                setState(() {
                                  hasTV = !hasTV;
                                });
                              },
                              selectedColor: Colors.green[100],
                              checkmarkColor: Colors.black,
                              backgroundColor: hasTV ? Colors.green[100] : Colors.red[100],
                            ),
                            FilterChip(
                              label: const Text("AC"),
                              selected: hasAirConditioning,
                              onSelected: (bool selected) {
                                setState(() {
                                  hasAirConditioning = !hasAirConditioning;
                                });
                              },
                              selectedColor: Colors.green[100],
                              checkmarkColor: Colors.black,
                              backgroundColor: hasAirConditioning ? Colors.green[100] : Colors.red[100],
                            ),
                            FilterChip(
                              label: const Text("Shower"),
                              selected: hasShowerAndToilet,
                              onSelected: (bool selected) {
                                setState(() {
                                  hasShowerAndToilet = !hasShowerAndToilet;
                                });
                              },
                              selectedColor: Colors.green[100],
                              checkmarkColor: Colors.black,
                              backgroundColor: hasShowerAndToilet ? Colors.green[100] : Colors.red[100],
                            ),
                            FilterChip(
                              label: const Text("Internet"),
                              selected: internetSpeed,
                              onSelected: (bool selected) {
                                setState(() {
                                  internetSpeed = !internetSpeed;
                                });
                              },
                              selectedColor: Colors.green[100],
                              checkmarkColor: Colors.black,
                              backgroundColor: internetSpeed ? Colors.green[100] : Colors.red[100],
                            ),
                            FilterChip(
                              label: const Text("Kitchen"),
                              selected: hasKitchen,
                              onSelected: (bool selected) {
                                setState(() {
                                  hasKitchen = !hasKitchen;
                                });
                              },
                              selectedColor: Colors.green[100],
                              checkmarkColor: Colors.black,
                              backgroundColor: hasKitchen ? Colors.green[100] : Colors.red[100],
                            ),
                            FilterChip(
                              label: const Text("Balcony"),
                              selected: hasBalcony,
                              onSelected: (bool selected) {
                                setState(() {
                                  hasBalcony = !hasBalcony;
                                });
                              },
                              selectedColor: Colors.green[100],
                              checkmarkColor: Colors.black,
                              backgroundColor: hasBalcony ? Colors.green[100] : Colors.red[100],
                            ),
                            FilterChip(
                              label: const Text("Microwave"),
                              selected: hasMicrowave,
                              onSelected: (bool selected) {
                                setState(() {
                                  hasMicrowave = !hasMicrowave;
                                });
                              },
                              selectedColor: Colors.green[100],
                              checkmarkColor: Colors.black,
                              backgroundColor: hasMicrowave ? Colors.green[100] : Colors.red[100],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}