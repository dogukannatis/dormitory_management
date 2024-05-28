import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class DormMGManageRoom extends ConsumerStatefulWidget {
  const DormMGManageRoom({Key? key}) : super(key: key);

  @override
  ConsumerState<DormMGManageRoom> createState() =>
      _DormMGManageRoomState();
}

class _DormMGManageRoomState extends ConsumerState<DormMGManageRoom> {
  @override
  Widget build(BuildContext context) {
    final rooms = ref.watch(roomProvider);
    Room existingRoom = rooms[0];

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
                        buildEditRoomForm(existingRoom),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'ID',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Dormitory ID',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Room Type',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Price',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: Text('Create'),
        ),
      ],
    );
  }

  Widget buildEditRoomForm(Room room) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: room.id,
          decoration: InputDecoration(
            labelText: 'ID',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: room.dormitoryID,
          decoration: InputDecoration(
            labelText: 'Dormitory ID',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: room.roomType,
          decoration: InputDecoration(
            labelText: 'Room Type',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: room.price?.toString(),
          decoration: InputDecoration(
            labelText: 'Price',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: Text('Save'),
        ),
      ],
    );
  }
}