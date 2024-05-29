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

  Set<String> selectedFilters = Set();

  RangeValues _currentPriceRangeValues = RangeValues(100000, 500000);
  RangeValues _currentRatingRangeValues = RangeValues(1, 5);

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
      drawer: const CustomDrawer(),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ListView(
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
                                child: Image.asset(
                                  'assets/images/home_img1.png',
                                  fit: BoxFit.contain,
                                  height: 300,
                                  width: 450,
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
                        const Text(
                          'Price Range',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RangeSlider(
                          values: _currentPriceRangeValues,
                          min: 100000,
                          max: 500000,
                          divisions: 50,
                          labels: RangeLabels(
                            '${_currentPriceRangeValues.start.round()}',
                            '${_currentPriceRangeValues.end.round()}',
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentPriceRangeValues = values;
                            });
                          },
                          activeColor: Colors.black,
                          inactiveColor: Colors.black38,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Rating',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RangeSlider(
                          values: _currentRatingRangeValues,
                          min: 1,
                          max: 5,
                          divisions: 5,
                          labels: RangeLabels(
                            '${_currentRatingRangeValues.start.round()}',
                            '${_currentRatingRangeValues.end.round()}',
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRatingRangeValues = values;
                            });
                          },
                          activeColor: Colors.black,
                          inactiveColor: Colors.black38,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}










/*
import 'package:dormitory_management/models/dormitory.dart';
import 'package:dormitory_management/ui/pages/dormitory_details_page.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/dorm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/rating.dart';


/// Sayfalar State yönetimi riverpod ile yapıldığından dolayı ConsumerStatefulWidget olarak yapılandırılmalı.
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

  Set<String> selectedFilters = Set();


  RangeValues _currentPriceRangeValues = RangeValues(100000, 500000);
  RangeValues _currentRatingRangeValues = RangeValues(1, 5);

  List<Dormitory> dormitories = [];

  bool isLoading = false;


  @override
  void initState() {
    getAllDormitories();
    super.initState();
  }

  /// Sayfa yüklendiğinde tüm yurtlar dormitories içine gelecek.
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
    ref.watch(dormManagerProvider); // State otomatik yenilenecek

    List<Dormitory> filteredDormitories = dormitories.where((dormitory){
      if(dormitory.dormitoryDetails!.hasMicrowave == true && hasMicrowave){
        return true;
      }else if(dormitory.dormitoryDetails!.hasKitchen == true && hasKitchen){
        return true;
      }else if(dormitory.dormitoryDetails!.hasCleanService == true && hasCleanService){
        return true;
      }else if(dormitory.dormitoryDetails!.hasShowerAndToilet == true && hasShowerAndToilet){
        return true;
      }else if(dormitory.dormitoryDetails!.hasBalcony == true && hasBalcony){
        return true;
      }else if(dormitory.dormitoryDetails!.hasTV == true && hasTV){
        return true;
      }else if(dormitory.dormitoryDetails!.hasAirConditioning == true && hasAirConditioning){
        return true;
      }else if(dormitory.dormitoryDetails!.internetSpeed!.isNotEmpty && internetSpeed ){
        return true;
      }else{
        return false;
      }

    }).toList();




    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: isLoading ? const Center(child: CircularProgressIndicator(),) : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ListView(
                children: filteredDormitories.map((dormitory) {
                  double rate = 0.0;

                  if(dormitory.ratings != null){
                    for(Rating rating in dormitory.ratings!){
                      rate += rating.ratingNo!;
                    }
                    if(rate != 0){
                      rate / dormitory.ratings!.length;
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
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  bottomLeft: Radius.circular(15.0),
                                ),
                                child: Image.asset(
                                  'assets/images/home_img1.png',
                                  fit: BoxFit.contain,
                                  height: 300,
                                  width: 450,
                                ),
                              ),
                            ),
                            SizedBox(width: 25.0),
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
                                    'Rating: $rate stars',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
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
            SizedBox(width: 20.0),
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
                        SizedBox(height: 10),
                        FilterChip(
                          label: Text("Clean Service"),
                          selected: hasCleanService,
                          onSelected: (bool selected) {
                            setState(() {
                              hasCleanService = !hasCleanService;
                            });
                          },
                          selectedColor: Colors.green,
                          checkmarkColor: Colors.black,
                          backgroundColor:
                          hasCleanService ? Colors.green : Colors.red,
                        ),
                        FilterChip(
                          label: Text("TV"),
                          selected: hasTV,
                          onSelected: (bool selected) {
                            setState(() {
                              hasTV = !hasTV;
                            });
                          },
                          selectedColor: Colors.green,
                          checkmarkColor: Colors.black,
                          backgroundColor:
                          hasTV ? Colors.green : Colors.red,
                        ),
                        FilterChip(
                          label: Text("AC"),
                          selected: hasAirConditioning,
                          onSelected: (bool selected) {
                            setState(() {
                              hasAirConditioning = !hasAirConditioning;
                            });
                          },
                          selectedColor: Colors.green,
                          checkmarkColor: Colors.black,
                          backgroundColor:
                          hasAirConditioning ? Colors.green : Colors.red,
                        ),
                        FilterChip(
                          label: Text("Shower"),
                          selected: hasShowerAndToilet,
                          onSelected: (bool selected) {
                            setState(() {
                              hasShowerAndToilet = !hasShowerAndToilet;
                            });
                          },
                          selectedColor: Colors.green,
                          checkmarkColor: Colors.black,
                          backgroundColor:
                          hasShowerAndToilet ? Colors.green : Colors.red,
                        ),
                        FilterChip(
                          label: Text("Internet"),
                          selected: internetSpeed,
                          onSelected: (bool selected) {
                            setState(() {
                              internetSpeed = !internetSpeed;
                            });
                          },
                          selectedColor: Colors.green,
                          checkmarkColor: Colors.black,
                          backgroundColor:
                          internetSpeed ? Colors.green : Colors.red,
                        ),
                        FilterChip(
                          label: Text("Kitchen"),
                          selected: hasKitchen,
                          onSelected: (bool selected) {
                            setState(() {
                              hasKitchen = !hasKitchen;
                            });
                          },
                          selectedColor: Colors.green,
                          checkmarkColor: Colors.black,
                          backgroundColor:
                          hasKitchen ? Colors.green : Colors.red,
                        ),
                        FilterChip(
                          label: Text("Balcony"),
                          selected: hasBalcony,
                          onSelected: (bool selected) {
                            setState(() {
                              hasBalcony = !hasBalcony;
                            });
                          },
                          selectedColor: Colors.green,
                          checkmarkColor: Colors.black,
                          backgroundColor:
                          hasBalcony ? Colors.green : Colors.red,
                        ),
                        FilterChip(
                          label: Text("Microwave"),
                          selected: hasMicrowave,
                          onSelected: (bool selected) {
                            setState(() {
                              hasMicrowave = !hasMicrowave;
                            });
                          },
                          selectedColor: Colors.green,
                          checkmarkColor: Colors.black,
                          backgroundColor:
                          hasMicrowave ? Colors.green : Colors.red,
                        ),
                        /*
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            for (var filter in filters)
                              FilterChip(
                                label: Text(filter),
                                selected: selectedFilters.contains(filter),
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedFilters.add(filter);
                                    } else {
                                      selectedFilters.remove(filter);
                                    }
                                  });
                                },
                                selectedColor: Colors.green,
                                checkmarkColor: Colors.black,
                                backgroundColor:
                                selectedFilters.contains(filter) ? Colors.green : Colors.red,
                              ),
                          ],
                        ),
                         */
                        SizedBox(height: 20),
                        Text(
                          'Price Range: ${_currentPriceRangeValues.start.toInt()} TL - ${_currentPriceRangeValues.end.toInt()} TL',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        RangeSlider(
                          values: _currentPriceRangeValues,
                          min: 100000,
                          max: 500000,
                          divisions: 40,
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentPriceRangeValues = values;
                            });
                          },
                          activeColor: Colors.black,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Rating Range: ${_currentRatingRangeValues.start.toInt()} stars - ${_currentRatingRangeValues.end.toInt()} stars',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        RangeSlider(
                          values: _currentRatingRangeValues,
                          min: 1,
                          max: 5,
                          divisions: 4,
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRatingRangeValues = values;
                            });
                          },
                          activeColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  /*
  @override
  Widget build(BuildContext context) {
    ref.watch(dormManagerProvider); // State otomatik yenilenecek


    List<DormitorySilinecek> filteredDormitories = dormitoriesMock.where((dormitory) {
      return dormitoryMatchesFilters(dormitory) &&
          dormitory.price >= _currentPriceRangeValues.start &&
          dormitory.price <= _currentPriceRangeValues.end &&
          dormitory.rating >= _currentRatingRangeValues.start &&
          dormitory.rating <= _currentRatingRangeValues.end;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: isLoading ? const Center(child: CircularProgressIndicator(),) : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ListView(
                children: filteredDormitories.map((dormitory) {
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
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  bottomLeft: Radius.circular(15.0),
                                ),
                                child: Image.asset(
                                  'assets/images/home_img1.png',
                                  fit: BoxFit.contain,
                                  height: 300,
                                  width: 450,
                                ),
                              ),
                            ),
                            SizedBox(width: 25.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                    dormitory.name,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Price: ${dormitory.price} TL',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Rating: ${dormitory.rating} stars',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 4,
                                    children: dormitory.features.map((feature) {
                                      return Chip(
                                        label: Text(feature),
                                        backgroundColor: Colors.green[100],
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Show More'),
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
            SizedBox(width: 20.0),
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
                        SizedBox(height: 10),
                        Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Features',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            for (var filter in filters)
                              FilterChip(
                                label: Text(filter),
                                selected: selectedFilters.contains(filter),
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedFilters.add(filter);
                                    } else {
                                      selectedFilters.remove(filter);
                                    }
                                  });
                                },
                                selectedColor: Colors.green,
                                checkmarkColor: Colors.black,
                                backgroundColor:
                                selectedFilters.contains(filter) ? Colors.green : Colors.red,
                              ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Price Range: ${_currentPriceRangeValues.start.toInt()} TL - ${_currentPriceRangeValues.end.toInt()} TL',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        RangeSlider(
                          values: _currentPriceRangeValues,
                          min: 100000,
                          max: 500000,
                          divisions: 40,
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentPriceRangeValues = values;
                            });
                          },
                          activeColor: Colors.black,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Rating Range: ${_currentRatingRangeValues.start.toInt()} stars - ${_currentRatingRangeValues.end.toInt()} stars',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        RangeSlider(
                          values: _currentRatingRangeValues,
                          min: 1,
                          max: 5,
                          divisions: 4,
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRatingRangeValues = values;
                            });
                          },
                          activeColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
   */
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CompareDormitoriesPage(),
  ));
}
 */