import 'package:dormitory_management/models/dormitory.dart';
import 'package:dormitory_management/models/dormitory_details.dart';
import 'package:dormitory_management/ui/widgets/button_loading.dart';
import 'package:dormitory_management/viewmodels/dorm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';

import '../../../models/room.dart';

class AdminAddDorm extends ConsumerStatefulWidget {
  const AdminAddDorm({Key? key}) : super(key: key);

  @override
  _AdminAddDormState createState() => _AdminAddDormState();
}

class _AdminAddDormState extends ConsumerState<AdminAddDorm> {
  final _dormFormKey = GlobalKey<FormState>();
  final _roomFormKey = GlobalKey<FormState>();

  late TextEditingController _statusController;
  late TextEditingController _createdDateController;
  late TextEditingController _nameController;
  late TextEditingController _quotaController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _descriptionController;
  late TextEditingController _roomTypeController;
  late TextEditingController _roomPriceController;
  late TextEditingController _faxController;
  late TextEditingController _addressController;
  late TextEditingController _capacityController;
  late TextEditingController _phoneController;
  late TextEditingController _roomIdController;
  late TextEditingController _dormitoryIdController;



  bool isDormSaving = false;
  bool isRoomSaving = false;

  bool hasMicrowave = true;
  bool hasKitchen = true;
  bool hasCleanService = true;
  bool hasShowerAndToilet = true;
  bool hasBalcony = true;
  bool hasTV = true;
  bool hasAirConditioning = true;
  bool internetSpeed = true;


  @override
  void initState() {
    super.initState();
    _statusController = TextEditingController();
    _createdDateController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _quotaController = TextEditingController();
    _descriptionController = TextEditingController();
    _roomTypeController = TextEditingController();
    _roomPriceController = TextEditingController();
    _faxController = TextEditingController();
    _addressController = TextEditingController();
    _capacityController = TextEditingController();
    _phoneController = TextEditingController();
    _roomIdController = TextEditingController();
    _dormitoryIdController = TextEditingController();

    getDormitories();
  }

  bool addRoom = false;
  String dormName = "";

  List<Dormitory> dormitories = [];


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
                controller: _roomTypeController,
                decoration: const InputDecoration(
                  labelText: 'Room Type',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: _roomPriceController,
                decoration: const InputDecoration(
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
          child: const Text('Save'),
        ),
      ],
    );
  }


  Future<void> saveDormitory() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    Dormitory dorm = Dormitory(
        dormitoryId: null,
        universityId: 1,
        name: _nameController.text.trim(),
        quota: int.parse(_quotaController.text.trim()),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()
    );

    DormitoryDetails details = DormitoryDetails(
        detailId: null,
        dormitoryId: null,
        email: _emailController.text.trim(),
        faxNo: _faxController.text.trim(),
        address: _addressController.text.trim(),
        capacity: int.parse(_capacityController.text.trim()),
        description: _descriptionController.text.trim(),
        internetSpeed: internetSpeed ? "100" : "",
        hasKitchen: hasKitchen,
        hasCleanService: hasCleanService,
        hasShowerAndToilet: hasShowerAndToilet,
        hasBalcony: hasBalcony,
        hasTV: hasTV,
        contactNo: _phoneController.text.trim(),
        hasMicrowave: hasMicrowave,
        hasAirConditioning: hasAirConditioning,
        photoUrls: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()
    );

    dorm.dormitoryDetails = details;

    setState(() {
      isDormSaving = true;
    });
    await dormManager.saveDormitory(dormitory: dorm);

    const snackBar = SnackBar(
      content: Text('Dormitory has been created!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() {
      isDormSaving = false;
    });

    _emailController.clear();
    _nameController.clear();
    _passwordController.clear();
    _quotaController.clear();
    _descriptionController.clear();
    _phoneController.clear();
    _faxController.clear();
    _capacityController.clear();
    _addressController.clear();


  }

  Future<void> saveRoom() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    Room room = Room(
      roomId: null,
        dormitoryId: int.parse(_dormitoryIdController.text.trim()),
        roomType: _roomTypeController.text.trim(),
      price: int.parse(_roomPriceController.text.trim()),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now()
    );


    setState(() {
      isRoomSaving = true;
    });
    await dormManager.saveRoom(room: room);
    const snackBar = SnackBar(
      content: Text('Room has been created!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() {
      isRoomSaving = false;
    });

    _roomTypeController.clear();
    _roomPriceController.clear();


  }

  Future<void> getDormitories() async {
    final dormManager = ref.read(dormManagerProvider.notifier);

    dormitories = await dormManager.getAllDormitories();
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: getCustomAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
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
                    child: Form(
                      key: _dormFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Add Dormitory',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Creating',
                                    filled: true,
                                    enabled: false,
                                    fillColor: Colors.white,
                                    hintText: "Creating",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                               hintText: DateTime.now().toString(),
                                    filled: true,
                                    enabled: false,
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
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  validator: (v){
                                    if(v!.isEmpty){
                                      return "Field is required";
                                    }else{
                                      return null;
                                    }
                                  },
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
                                  validator: (v){
                                    if(v!.isEmpty){
                                      return "Field is required";
                                    }else{
                                      return null;
                                    }
                                  },
                                  controller: _quotaController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  ],
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
                                  validator: (v){
                                    if(v!.isEmpty){
                                      return "Field is required";
                                    }else{
                                      return null;
                                    }
                                  },
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
                                  validator: (v){
                                    if(v!.isEmpty){
                                      return "Field is required";
                                    }else{
                                      return null;
                                    }
                                  },
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
                            validator: (v){
                              if(v!.isEmpty){
                                return "Field is required";
                              }else{
                                return null;
                              }
                            },
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
                          TextFormField(
                            validator: (v){
                              if(v!.isEmpty){
                                return "Field is required";
                              }else{
                                return null;
                              }
                            },
                            controller: _addressController,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),

                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  validator: (v){
                                    if(v!.isEmpty){
                                      return "Field is required";
                                    }else{
                                      return null;
                                    }
                                  },
                                  controller: _phoneController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  ],
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
                                  validator: (v){
                                    if(v!.isEmpty){
                                      return "Field is required";
                                    }else{
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  ],
                                  controller: _faxController,
                                  decoration: InputDecoration(
                                    labelText: 'Fax No',
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
                                  validator: (v){
                                    if(v!.isEmpty){
                                      return "Field is required";
                                    }else{
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  ],
                                  controller: _capacityController,
                                  decoration: InputDecoration(
                                    labelText: 'Capacity',
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

                            ],
                          ),
                          SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hasCleanService = !hasCleanService;
                                  });
                                },
                                child: Chip(
                                  label: Text("Clean Service"),
                                  backgroundColor: hasCleanService
                                      ? Colors.green[100]
                                      : Colors.red[100],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hasMicrowave = !hasMicrowave;
                                  });
                                },
                                child: Chip(
                                  label: Text("Microwave"),
                                  backgroundColor: hasMicrowave
                                      ? Colors.green[100]
                                      : Colors.red[100],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hasKitchen = !hasKitchen;
                                  });
                                },
                                child: Chip(
                                  label: Text("Kitchen"),
                                  backgroundColor: hasKitchen
                                      ? Colors.green[100]
                                      : Colors.red[100],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hasShowerAndToilet = !hasShowerAndToilet;
                                  });
                                },
                                child: Chip(
                                  label: Text("Shower and Toilet"),
                                  backgroundColor: hasShowerAndToilet
                                      ? Colors.green[100]
                                      : Colors.red[100],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hasBalcony = !hasBalcony;
                                  });
                                },
                                child: Chip(
                                  label: Text("Balcony"),
                                  backgroundColor: hasBalcony
                                      ? Colors.green[100]
                                      : Colors.red[100],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hasTV = !hasTV;
                                  });
                                },
                                child: Chip(
                                  label: Text("TV"),
                                  backgroundColor: hasTV
                                      ? Colors.green[100]
                                      : Colors.red[100],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hasAirConditioning = !hasAirConditioning;
                                  });
                                },
                                child: Chip(
                                  label: Text("AC"),
                                  backgroundColor: hasAirConditioning
                                      ? Colors.green[100]
                                      : Colors.red[100],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    internetSpeed = !internetSpeed;
                                  });
                                },
                                child: Chip(
                                  label: Text("Internet"),
                                  backgroundColor: internetSpeed
                                      ? Colors.green[100]
                                      : Colors.red[100],
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: isDormSaving ? null : () {
                              _dormFormKey.currentState!.save();
                              if(_dormFormKey.currentState!.validate()){
                                saveDormitory();
                              }
                            },
                            child: isDormSaving ? ButtonLoading(buttonText: "Saving") : Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              dormitories.isNotEmpty ? SizedBox(
                width: double.infinity,
                height: 100,
                child: ListView.builder(
                  itemCount: dormitories.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return Card(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(dormitories[index].name!),
                              ElevatedButton(
                                onPressed: () {
                                  _dormitoryIdController.text = dormitories[index].dormitoryId.toString();
                                  dormName = dormitories[index].name!;
                                  setState(() {
                                    addRoom = true;
                                  });
                                },
                                child: Text("Add Room"),
                              ),
                            ],
                          )
                      ),
                    );
                  },
                ),
              ) : Container(),
              const SizedBox(height: 16),
              addRoom ? SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _roomFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add Room  - $dormName',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  validator: (v){
                                    if(v!.isEmpty){
                                      return "Field is required";
                                    }else{
                                      return null;
                                    }
                                  },
                                  controller: _roomTypeController,
                                  decoration: InputDecoration(
                                    labelText: 'Room Type',
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: _roomPriceController,
                                  validator: (v){
                                    if(v!.isEmpty){
                                      return "Field is required";
                                    }else{
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'Price',
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
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: isRoomSaving ? null : () {
                              _roomFormKey.currentState!.save();
                              if(_roomFormKey.currentState!.validate()){
                                saveRoom();
                              }
                            },
                            child: isRoomSaving ? const ButtonLoading(buttonText: "Saving") : const Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ) : Container(),
            ],
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
    _quotaController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
