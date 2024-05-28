import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';

class Room {
  final String id;
  final String dormitoryID;
  String? roomType;
  int? price;

  Room({
    required this.id,
    required this.dormitoryID,
    this.roomType,
    this.price,
  });

  Room.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        dormitoryID = map["dormitoryID"],
        roomType = map["roomType"],
        price = map["price"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "dormitoryID": dormitoryID,
      "roomType": roomType,
      "price": price,
    };
  }

  @override
  String toString() {
    return 'Room{id: $id, dormitoryID: $dormitoryID, roomType: $roomType, price: $price}';
  }
}

final roomProvider = Provider<List<Room>>((ref) {
  return [
    Room(id: '1', dormitoryID: 'A', roomType: 'A101', price: 500),
    Room(id: '2', dormitoryID: 'B', roomType: 'B101', price: 750),
  ];
});

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

class AdminManageDorm extends ConsumerStatefulWidget {
  const AdminManageDorm({Key? key}) : super(key: key);

  @override
  _AdminManageDormState createState() => _AdminManageDormState();
}

class _AdminManageDormState extends ConsumerState<AdminManageDorm> {
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

  Widget buildNewRoomForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'ID',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Dormitory ID',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Room Type',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: Text('Save'),
        ),
      ],
    );
  }

  Widget buildEditRoomForm(Room room) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    Row(
    children: [
    Expanded(
    child: TextFormField(
      initialValue: room.id,
      decoration: InputDecoration(
        labelText: 'ID',
        border: OutlineInputBorder(),
      ),
    ),
    ),
    const SizedBox(width: 10),
    Expanded(
    child: TextFormField(
    initialValue: room.dormitoryID,
    decoration: InputDecoration(
    labelText: 'Dormitory ID',
    border: OutlineInputBorder(),
    ),
    ),
    ),
    ],
    ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: room.roomType,
                decoration: InputDecoration(
                  labelText: 'Room Type',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                initialValue: room.price?.toString(),
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: Text('Save'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final dormitoryDetails = ref.watch(dormitoryDetailsProvider);
    final rooms = ref.watch(roomProvider);
    Room existingRoom = rooms[0];

    _emailController.text = dormitoryDetails.email ?? '';
    _nameController.text = dormitoryDetails.address ?? '';
    _phoneController.text = dormitoryDetails.contactNo ?? '';
    _faxController.text = dormitoryDetails.faxNo ?? '';
    _quotaController.text = dormitoryDetails.capacity.toString();
    _descriptionController.text = dormitoryDetails.description ?? '';

    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: Row(
        children: [
          Container(
            width: 250,
            child: const CustomDrawer(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Create New Room',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  buildNewRoomForm(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Edit Room',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  buildEditRoomForm(existingRoom),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
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
                                        backgroundColor: feature.isSelected
                                            ? Colors.green[100]
                                            : Colors.red[100],
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
  final List? photoUrls;
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
    this.photoUrls,
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