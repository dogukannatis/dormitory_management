import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';

final dormitoryDetailsProvider = Provider((ref) {
  return DormitoryDetails(
    detailId: 1,
    dormitoryId: 1,
    contactNo: '+90 1111111110',
    email: 'universe@dorm.com',
    faxNo: '+90 1111111110',
    address: 'Universe A Block',
    capacity: 400,
    description: 'Sample Description',
    internetSpeed: '100 Mbps',
    hasKitchen: true,
    hasCleanService: true,
    hasShowerAndToilet: true,
    hasBalcony: false,
    hasTV: true,
    hasMicrowave: true,
    hasAirConditioning: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});

class DormMGEditDorm extends ConsumerStatefulWidget {
  const DormMGEditDorm({Key? key}) : super(key: key);

  @override
  _DormMGEditDormState createState() => _DormMGEditDormState();
}

class _DormMGEditDormState extends ConsumerState<DormMGEditDorm> {
  late TextEditingController _statusController;
  late TextEditingController _createdDateController;
  late TextEditingController _phoneController;
  late TextEditingController _faxController;
  late TextEditingController _nameController;
  late TextEditingController _quotaController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _statusController = TextEditingController(text: 'Creating');
    _createdDateController = TextEditingController(text: 'May 1, 2023');
    _emailController = TextEditingController();
    _passwordController = TextEditingController(text: '********');
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _faxController = TextEditingController();
    _quotaController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final dormitoryDetails = ref.watch(dormitoryDetailsProvider);

    _emailController.text = dormitoryDetails.email ?? '';
    _nameController.text = dormitoryDetails.address ?? '';
    _phoneController.text = dormitoryDetails.contactNo ?? '';
    _faxController.text = dormitoryDetails.faxNo ?? '';
    _quotaController.text = dormitoryDetails.capacity.toString();
    _descriptionController.text = dormitoryDetails.description ?? '';

    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          //width: MediaQuery.of(context).size.height,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Edit Dormitory',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _statusController,
                                decoration: InputDecoration(
                                  labelText: 'Status',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _createdDateController,
                                decoration: InputDecoration(
                                  labelText: 'Created Date',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  labelText: 'Phone',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _faxController,
                                decoration: InputDecoration(
                                  labelText: 'Fax',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _quotaController,
                                decoration: InputDecoration(
                                  labelText: 'Quota',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            for (var feature in dormitoryFeatures)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    feature.toggleSelection();
                                  });
                                },
                                child: Chip(
                                  label: Text(feature.name),
                                  backgroundColor: feature.isSelected ? Colors.green[100] : Colors.red[100],
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: VerticalDivider(thickness: 1, color: Colors.grey)),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Room Management',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Add Room'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: Text(
                            'or',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Select Room',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Edit Room'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _statusController.dispose();
    _createdDateController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _faxController.dispose();
    _quotaController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

class DormitoryDetails {
  final int? detailId;
  final int? dormitoryId;
  final String? contactNo;
  final String? email;
  final String? faxNo;
  final String? address;
  final int? capacity;
  final String? description;
  final String? internetSpeed;
  final bool? hasKitchen;
  final bool? hasCleanService;
  final bool? hasShowerAndToilet;
  final bool? hasBalcony;
  final bool? hasTV;
  final bool? hasMicrowave;
  final bool? hasAirConditioning;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DormitoryDetails({
    required this.detailId,
    required this.dormitoryId,
    this.contactNo,
    this.email,
    this.faxNo,
    this.address,
    this.capacity,
    this.description,
    this.internetSpeed,
    this.hasKitchen,
    this.hasCleanService,
    this.hasShowerAndToilet,
    this.hasBalcony,
    this.hasTV,
    this.hasMicrowave,
    this.hasAirConditioning,
    this.createdAt,
    this.updatedAt,
  });
}

class DormitoryFeature {
  final String name;
  bool isSelected;

  DormitoryFeature(this.name, {this.isSelected = false});

  void toggleSelection() {
    isSelected = !isSelected;
  }
}

final List<DormitoryFeature> dormitoryFeatures = [
  DormitoryFeature('Clean Service', isSelected: true),
  DormitoryFeature('Shower'),
  DormitoryFeature('Balcony', isSelected: true),
  DormitoryFeature('TV'),
  DormitoryFeature('Internet'),
  DormitoryFeature('Microwave'),
  DormitoryFeature('AC'),
  DormitoryFeature('Kitchen', isSelected: true),
];