
class Booking {
  final String id;
  final String userID;
  final String dormitoryID;
  final String roomID;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Booking({
    required this.id,
    required this.userID,
    required this.dormitoryID,
    required this.roomID,
    this.status,
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toMap() {
    return {
      "id"        : id,
      "userID"     : userID,
      "dormitoryID"      : dormitoryID,
      "roomID"   : roomID,
      "status"  : status,
      "createdAt" : createdAt,
      "updatedAt" : updatedAt,
    };
  }

  Booking.fromMap(Map<String, dynamic> map) :
        id = map["id"],
        userID = map["userID"],
        dormitoryID = map["dormitoryID"],
        roomID = map["roomID"],
        status = map["status"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];

  
}
