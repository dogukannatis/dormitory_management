import 'package:dormitory_management/models/dormitory.dart';
import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/room.dart';
import '../../../ui/widgets/button_loading.dart';
import '../../../viewmodels/dorm_manager.dart';
import '../../../viewmodels/user_manager.dart';
import '../../../ui/widgets/custom_drawer.dart';

class DormMGManageRoom extends ConsumerStatefulWidget {
  final Dormitory? dormitory;
  const DormMGManageRoom({Key? key, this.dormitory}) : super(key: key);

  @override
  ConsumerState<DormMGManageRoom> createState() => _DormMGManageRoomState();
}

class _DormMGManageRoomState extends ConsumerState<DormMGManageRoom> {
  final _formKey = GlobalKey<FormState>();
  final _formUpdateKey = GlobalKey<FormState>();
  final roomIdController = TextEditingController();
  final updateRoomIdController = TextEditingController();
  final roomTypeController = TextEditingController();
  final priceController = TextEditingController();
  final updateRoomTypeController = TextEditingController();
  final updatePriceController = TextEditingController();

  bool isLoading = false;
  bool isUpdateLoading = false;

  List<Room?> rooms = [];

  @override
  void initState() {
    getRooms();
    super.initState();
  }

  Future<void> saveRoom() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    final user = ref.read(userManagerProvider);

    Room _room = Room(
      roomId: null,
      dormitoryId: widget.dormitory != null ? widget.dormitory!.dormitoryId : (user as DormitoryOwner).dormitoryId,
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
    roomTypeController.clear();
    roomIdController.clear();
    priceController.clear();

    setState(() {
      rooms.add(_room);
      isLoading = false;
    });
  }

  Future<void> deleteRoom(int roomId) async {
    final dormManager = ref.read(dormManagerProvider.notifier);

    debugPrint("roomId: $roomId");

    setState(() {
      isLoading = true;
    });

    await dormManager.deleteRoom(roomId: roomId);
    const snackBar = SnackBar(
      content: Text('Room has been deleted!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    roomTypeController.clear();
    roomIdController.clear();
    priceController.clear();

    setState(() {
      rooms.removeWhere((element) => element!.roomId == roomId);
      isLoading = false;
    });
  }

  Future<void> updateRoom() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    final user = ref.read(userManagerProvider);

    Room _room = Room(
      roomId: int.parse(updateRoomIdController.text.trim()),
      dormitoryId: widget.dormitory != null ? widget.dormitory!.dormitoryId : (user as DormitoryOwner).dormitoryId,
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
    selectedRoom = false;

    var i = rooms.indexWhere((element) => element!.roomId == _room.roomId);
    rooms[i] = _room;

    setState(() {
      isUpdateLoading = false;
    });
  }

  Future<void> getRooms() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    final user = ref.read(userManagerProvider);
    if(widget.dormitory != null){
      rooms = widget.dormitory!.rooms!;
    }else{
      rooms = await dormManager.getRoomByDormitoryId(dormitoryId: (user as DormitoryOwner).dormitoryId!);
    }

    setState(() {});
  }

  bool selectedRoom = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDrawer(activePage: ActivePages.dormMGmanageRoom,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    rooms.isNotEmpty
                        ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SizedBox(
                                                width: MediaQuery.of(context).size.width,
                                                height: 200,
                                                child: ListView.builder(
                          itemCount: rooms.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 200,
                              width: 200,
                              child: Card(
                                color: Colors.white,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Room",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(rooms[index]!.roomType!),
                                      SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedRoom = true;
                                            updateRoomTypeController.text = rooms[index]!.roomType!;
                                            updatePriceController.text = rooms[index]!.price.toString();
                                            updateRoomIdController.text = rooms[index]!.roomId.toString();
                                          });
                                        },
                                        child: Text('Edit'),
                                      ),
                                      SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          deleteRoom(rooms[index]!.roomId!);
                                        },
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                         ),
                         ),
                        )
                        : Container(),
                    selectedRoom == false
                        ? SizedBox(
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
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              buildNewRoomForm(),
                            ],
                          ),
                        ),
                      ),
                    )
                        : SizedBox(
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
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          ),
        ],
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
            validator: (v) {
              if (v!.isEmpty) {
                return "Field is required.";
              } else {
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
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            validator: (v) {
              if (v!.isEmpty) {
                return "Field is required.";
              } else {
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
            onPressed: isLoading
                ? null
                : () {
              _formKey.currentState!.save();
              if (_formKey.currentState!.validate()) {
                saveRoom();
              }
            },
            child: isLoading ? ButtonLoading(buttonText: 'Creating') : Text('Save'),
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
            validator: (v) {
              if (v!.isEmpty) {
                return "Field is required.";
              } else {
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
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            validator: (v) {
              if (v!.isEmpty) {
                return "Field is required.";
              } else {
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
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedRoom = false;
                  });
                },
                child: Text('Back'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: isUpdateLoading
                    ? null
                    : () {
                  _formUpdateKey.currentState!.save();
                  if (_formUpdateKey.currentState!.validate()) {
                    updateRoom();
                  }
                },
                child: isUpdateLoading ? ButtonLoading(buttonText: 'Saving') : Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}









/*

import 'package:dormitory_management/models/users/dormitory_owner.dart';
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
  final updateRoomIdController = TextEditingController();
  final roomTypeController = TextEditingController();
  final priceController = TextEditingController();
  final updateRoomTypeController = TextEditingController();
  final updatePriceController = TextEditingController();


  bool isLoading = false;
  bool isUpdateLoading = false;

  List<Room> rooms = [];

  Future<void> saveRoom() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    final user = ref.read(userManagerProvider);

    debugPrint("price: ${priceController.text.trim()}");

    Room _room = Room(
      roomId: null,
      dormitoryId: (user as DormitoryOwner).dormitoryId,
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
    roomTypeController.clear();
    roomIdController.clear();
    priceController.clear();

    setState(() {
      rooms.add(_room);
      isLoading = false;
    });
  }

  Future<void> updateRoom() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    final user = ref.read(userManagerProvider);

    Room _room = Room(
      roomId: int.parse(updateRoomIdController.text.trim()),
      dormitoryId: (user as DormitoryOwner).dormitoryId,
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
    selectedRoom = false;

    var i = rooms.indexWhere((element) => element.roomId == _room.roomId);
    rooms[i] = _room;

    setState(() {
      isUpdateLoading = false;
    });
  }



  Future<void> getRooms() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    final user = ref.read(userManagerProvider);
    rooms = await dormManager.getRoomByDormitoryId(dormitoryId: (user as DormitoryOwner).dormitoryId!);
    setState(() {

    });
  }
  @override
  void initState() {
    getRooms();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final user = ref.read(userManagerProvider);
    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rooms.isNotEmpty ?
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: ListView.builder(
                    itemCount: rooms.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return SizedBox(
                        height: 150,
                        width: 150,
                        child: Card(
                          color: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Room", style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Text(rooms[index].roomType!),
                                SizedBox(height: 10,),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedRoom = true;
                                      updateRoomTypeController.text = rooms[index].roomType!;
                                      updatePriceController.text = rooms[index].price.toString();
                                      updateRoomIdController.text = rooms[index].roomId.toString();
                                    });
                                  },
                                  child: Text('Edit'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ) : Container(),
              selectedRoom == false ?
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
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
              ) : Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
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
              ),

            ],
          ),
        ),
      ),
    );
  }

  bool selectedRoom = false;

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
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedRoom = false;
                  });

                },
                child: Text('Back'),
              ),
              const SizedBox(width: 20),
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
        ],
      ),
    );
  }
}

*/