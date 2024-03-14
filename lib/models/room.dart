
class Room {
  final String id;
  final String dormitoryID;
  String? roomType;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  Room({
    required this.id,
    required this.dormitoryID,
    this.roomType,
    this.price,
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toMap() {
    return {
      "id"        : id,
      "dormitoryID"     : dormitoryID,
      "roomType"      : roomType,
      "price"   : price,
      "createdAt" : createdAt,
      "updatedAt" : updatedAt,
    };
  }

  Room.fromMap(Map<String, dynamic> map) :
        id = map["id"],
        dormitoryID = map["dormitoryID"],
        roomType = map["roomType"],
        price = map["price"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];

  @override
  String toString() {
    return 'Room{id: $id, dormitoryID: $dormitoryID, roomType: $roomType, price: $price, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
