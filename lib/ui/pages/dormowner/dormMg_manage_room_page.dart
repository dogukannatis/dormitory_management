import 'package:dormitory_management/ui/widgets/button_loading.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/dorm_manager.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/room.dart';


class DormMGManageRoom extends ConsumerStatefulWidget {
  const DormMGManageRoom({Key? key}) : super(key: key);

  @override
  ConsumerState<DormMGManageRoom> createState() =>
      _DormMGManageRoomState();
}

class _DormMGManageRoomState extends ConsumerState<DormMGManageRoom> {

  final _formKey = GlobalKey<FormState>();
  final _formUpdateKey = GlobalKey<FormState>();
  final roomIdController = TextEditingController();
  final roomTypeController = TextEditingController();
  final priceController = TextEditingController();
  final updateRoomTypeController = TextEditingController();
  final updatePriceController = TextEditingController();


  bool isLoading = false;
  bool isUpdateLoading = false;


  Future<void> saveRoom() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    final user = ref.read(userManagerProvider);

    debugPrint("price: ${priceController.text.trim()}");

    Room _room = Room(
      roomId: null,
      dormitoryId: user!.userId!,
      roomType: roomTypeController.text.trim(),
      price: int.parse(priceController.text.trim()),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    setState(() {
      isLoading = true;
    });

    await dormManager.saveRoom(room: _room);
    const snackBar = SnackBar(
      content: Text('Room has been created!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> updateRoom() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    final user = ref.read(userManagerProvider);

    Room _room = Room(
      roomId: int.parse(roomIdController.text.trim()),
      dormitoryId: user!.userId!,
      roomType: updateRoomTypeController.text.trim(),
      price: int.parse(updatePriceController.text.trim()),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    setState(() {
      isUpdateLoading = true;
    });

    await dormManager.updateRoom(room: _room);
    const snackBar = SnackBar(
      content: Text('Room has been updated!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {
      isUpdateLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
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
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        buildNewRoomForm(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
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
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        buildEditRoomForm(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNewRoomForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: roomTypeController,
            validator: (v){
              if(v!.isEmpty){
                return "Field is required.";
              }else{
                return null;
              }
            },
            decoration: InputDecoration(
              labelText: 'Room Type',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: priceController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              // for below version 2 use this
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), ],
            validator: (v){
              if(v!.isEmpty){
                return "Field is required.";
              }else{
                return null;
              }
            },

            decoration: InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isLoading ? null : () {
              _formKey.currentState!.save();
              if(_formKey.currentState!.validate()){
                saveRoom();
              }
            },
            child: isLoading ? ButtonLoading(buttonText: 'Creating',) : Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget buildEditRoomForm() {
    return Form(
      key: _formUpdateKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: (v){
              if(v!.isEmpty){
                return "Field is required.";
              }else{
                return null;
              }
            },
            controller: roomIdController,
            decoration: InputDecoration(
              labelText: 'ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            validator: (v){
              if(v!.isEmpty){
                return "Field is required.";
              }else{
                return null;
              }
            },
            controller: updateRoomTypeController,
            decoration: InputDecoration(
              labelText: 'Room Type',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              // for below version 2 use this
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), ],
            validator: (v){
              if(v!.isEmpty){
                return "Field is required.";
              }else{
                return null;
              }
            },
            controller: updatePriceController,
            decoration: InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isUpdateLoading ? null : () {
              _formUpdateKey.currentState!.save();
              if(_formUpdateKey.currentState!.validate()){
                updateRoom();
              }

            },
            child: isUpdateLoading ? ButtonLoading(buttonText: 'Saving',) : Text('Save'),
          ),
        ],
      ),
    );
  }
}