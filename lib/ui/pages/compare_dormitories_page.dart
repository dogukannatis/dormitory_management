import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class Dormitory {
  final String name;
  final List<String> features;
  final int price;
  final int rating;

  Dormitory(this.name, this.features, this.price, this.rating);
}

class CompareDormitoriesPage extends StatefulWidget {
  const CompareDormitoriesPage({Key? key}) : super(key: key);

  @override
  State<CompareDormitoriesPage> createState() => _CompareDormitoriesPageState();
}

class _CompareDormitoriesPageState extends State<CompareDormitoriesPage> {
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

  Set<String> selectedFilters = Set();

  List<Dormitory> dormitories = [
    Dormitory('Dormitory 1', ['Clean Service', 'TV', 'AC', 'Shower'], 150000, 4),
    Dormitory('Dormitory 2', ['Internet', 'Kitchen', 'Balcony'], 200000, 3),
    Dormitory('Dormitory 3', ['Clean Service', 'TV', 'Internet', 'Microwave'], 250000, 5),
    Dormitory('Dormitory 4', ['AC', 'Shower', 'Balcony'], 180000, 2),
    Dormitory('Dormitory 5', ['TV', 'AC', 'Internet'], 300000, 4),
  ];

  bool dormitoryMatchesFilters(Dormitory dormitory) {
    for (var filter in selectedFilters) {
      if (!dormitory.features.contains(filter)) {
        return false;
      }
    }
    return true;
  }

  RangeValues _currentPriceRangeValues = RangeValues(100000, 500000);
  RangeValues _currentRatingRangeValues = RangeValues(1, 5);

  @override
  Widget build(BuildContext context) {
    List<Dormitory> filteredDormitories = dormitories.where((dormitory) {
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
        body: Padding(
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
    checkmarkColor: Colors.white,
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
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CompareDormitoriesPage(),
  ));
}