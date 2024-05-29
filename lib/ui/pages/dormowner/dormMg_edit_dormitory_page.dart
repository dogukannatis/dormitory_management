import 'package:dio/dio.dart';
import 'package:dormitory_management/models/dormitory_details.dart';
import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/ui/widgets/button_loading.dart';
import 'package:dormitory_management/viewmodels/dorm_manager.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/dormitory.dart';
import 'dormMg_manage_room_page.dart';


class DormMGEditDorm extends ConsumerStatefulWidget {
  const DormMGEditDorm({Key? key}) : super(key: key);

  @override
  _DormMGEditDormState createState() => _DormMGEditDormState();
}

class _DormMGEditDormState extends ConsumerState<DormMGEditDorm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _statusController;
  late TextEditingController _createdDateController;
  late TextEditingController _phoneController;
  late TextEditingController _faxController;
  late TextEditingController _nameController;
  late TextEditingController _quotaController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _descriptionController;
  late TextEditingController _addressController;
  late TextEditingController _capacityController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _statusController = TextEditingController();
    _createdDateController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _faxController = TextEditingController();
    _quotaController = TextEditingController();
    _descriptionController = TextEditingController();
    _addressController = TextEditingController();
    _capacityController = TextEditingController();
    _priceController = TextEditingController();
    setInfo();
  }

  Future<void> uploadPhoto() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    final user = ref.read(userManagerProvider);

    if(image != null){

      final formData = FormData.fromMap({
        'DetailId': dormitory!.dormitoryDetails!.detailId,
        'ImageFile': MultipartFile.fromBytes(await image!.readAsBytes()),
      });

      await dormManager.uploadPhoto(formData: formData, detailId: dormitory!.dormitoryDetails!.detailId!);
    }


  }

  Dormitory? dormitory;

  bool isLoading = false;

  bool isSaving = false;

  bool hasMicrowave = true;
  bool hasKitchen = true;
  bool hasCleanService = true;
  bool hasShowerAndToilet = true;
  bool hasBalcony = true;
  bool hasTV = true;
  bool hasAirConditioning = true;
  bool internetSpeed = true;

  Future<void> setInfo() async {
    final user = ref.read(userManagerProvider);
    final dormManager = ref.read(dormManagerProvider.notifier);
    setState(() {
      isLoading = true;
    });
    dormitory = await dormManager.getDormitoryByID(dormitoryId: (user as DormitoryOwner).dormitoryId!);
    setState(() {
      isLoading = false;
    });

    hasMicrowave = dormitory!.dormitoryDetails!.hasMicrowave ?? false;
    hasKitchen = dormitory!.dormitoryDetails!.hasKitchen ?? false;
    hasCleanService = dormitory!.dormitoryDetails!.hasCleanService ?? false;
    hasShowerAndToilet = dormitory!.dormitoryDetails!.hasShowerAndToilet ?? false;
    hasBalcony = dormitory!.dormitoryDetails!.hasBalcony ?? false;
    hasTV = dormitory!.dormitoryDetails!.hasTV ?? false;
    hasAirConditioning = dormitory!.dormitoryDetails!.hasAirConditioning ?? false;
    internetSpeed = dormitory!.dormitoryDetails!.internetSpeed != null && dormitory!.dormitoryDetails!.internetSpeed!.isNotEmpty ? true : false;

    _emailController.text = user.email!;
    _nameController.text = user.name!;
    _phoneController.text = user.phoneNo!;
    _faxController.text = dormitory!.dormitoryDetails!.faxNo!;
    _quotaController.text = dormitory!.quota.toString();
    _descriptionController.text = dormitory!.dormitoryDetails!.description!;
    _createdDateController.text = dormitory!.createdAt!.toString();
    _addressController.text = dormitory!.dormitoryDetails!.address!;
    _capacityController.text = dormitory!.dormitoryDetails!.capacity.toString();
    _priceController.text = dormitory!.dormitoryDetails!.price.toString();

  }


  Future<void> updateDormitory() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    Dormitory dorm = Dormitory(
        dormitoryId: dormitory!.dormitoryId,
        universityId: dormitory!.universityId,
        name: _nameController.text.trim(),
        quota: int.parse(_quotaController.text.trim()),
      createdAt: dormitory!.createdAt,
      updatedAt: DateTime.now()
    );

    DormitoryDetails details = DormitoryDetails(
        detailId: dormitory!.dormitoryDetails!.detailId,
        dormitoryId: dormitory!.dormitoryId,
      email: _emailController.text.trim(),
      faxNo: _faxController.text.trim(),
      contactNo: _phoneController.text.trim(),
      address: _addressController.text.trim(),
      capacity: int.parse(_capacityController.text.trim()),
      description: _descriptionController.text.trim(),
      internetSpeed: internetSpeed ? "100" : "",
      hasMicrowave: hasMicrowave,
      hasKitchen: hasKitchen,
      hasCleanService: hasCleanService,
      hasShowerAndToilet: hasShowerAndToilet,
      hasBalcony: hasBalcony,
      hasTV: hasTV,
      hasAirConditioning: hasAirConditioning,
        photoUrls: [],
      createdAt: dormitory!.dormitoryDetails!.createdAt,
        price: int.parse(_priceController.text.trim()),
      updatedAt: DateTime.now()
    );

    dorm.dormitoryDetails = details;

    setState(() {
      isSaving = true;
    });
    await dormManager.updateDormitory(dormitory: dorm);
    const snackBar = SnackBar(
      content: Text('Details has been updated!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {
      isSaving = false;
    });
  }

  XFile? image;

  final ImagePicker picker = ImagePicker();


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: isLoading ? const Center(
        child: CircularProgressIndicator(),
      ) : Padding(
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
                  Form(
                    key: _formKey,
                    child: Expanded(
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
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: 'Active',
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
                                    enabled: false,
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
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  ],
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
                                  controller: _capacityController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  ],
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
                              Expanded(
                                child: TextFormField(
                                  validator: (v){
                                    if(v!.isEmpty){
                                      return "Field is required";
                                    }else{
                                      return null;
                                    }
                                  },
                                  controller: _priceController,
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
                          SizedBox(height: 16),
                          Expanded(
                            child: TextFormField(
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
                                  label: Text("Celan Service"),
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
                                  label: const Text("Internet"),
                                  backgroundColor: internetSpeed
                                      ? Colors.green[100]
                                      : Colors.red[100],
                                ),
                              ),

                            ],
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: isSaving ? null : () {
                              _formKey.currentState!.save();
                              if(_formKey.currentState!.validate()){
                                updateDormitory();
                              }
                            },
                            child: isSaving ? const ButtonLoading(buttonText: "Saving") : const Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(10),
                      child: VerticalDivider(thickness: 1, color: Colors.grey)),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Room Management',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGManageRoom()));

                          },
                          child: Text('Go To Room Management'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () async {
                            image = await picker.pickImage(source: ImageSource.gallery);
                            setState(() {});
                             await uploadPhoto();
                          },
                          child: const Text('Upload Profile Photo'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
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