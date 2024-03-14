
class DormitoryDetails {
  final String id;
  final String dormitoryID;
  String? phoneNumber;
  String? email;
  String? faxNumber;
  String? address;
  int? capacity;
  String? description;
  String? internetSpeed;
  bool? hasKitchen;
  bool? hasCleanService;
  bool? hasShowerAndToilet;
  bool? hasBalcony;
  bool? hasTV;
  bool? hasMicrowave;
  bool? hasAC;
  DateTime? createdAt;
  DateTime? updatedAt;

  DormitoryDetails({
    required this.id,
    required this.dormitoryID,
    this.phoneNumber,
    this.email,
    this.faxNumber,
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
    this.hasAC,
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toMap() {
    return {
      "id"        : id,
      "dormitoryID"     : dormitoryID,
      "phoneNumber"      : phoneNumber,
      "email"  : email,
      "faxNumber"  : faxNumber,
      "address"  : address,
      "capacity"  : capacity,
      "description"  : description,
      "internetSpeed"  : internetSpeed,
      "hasKitchen"  : hasKitchen,
      "hasCleanService"  : hasCleanService,
      "hasShowerAndToilet"  : hasShowerAndToilet,
      "hasTV"  : hasTV,
      "hasMicrowave"  : hasMicrowave,
      "hasBalcony"  : hasBalcony,
      "hasAC"  : hasAC,
      "createdAt" : createdAt,
      "updatedAt" : updatedAt,
    };
  }

  DormitoryDetails.fromMap(Map<String, dynamic> map) :
        id = map["id"],
        dormitoryID = map["dormitoryID"],
        phoneNumber = map["phoneNumber"],
        email = map["email"],
        faxNumber = map["faxNumber"],
        address = map["address"],
        capacity = map["capacity"],
        description = map["description"],
        internetSpeed = map["internetSpeed"],
        hasKitchen = map["hasKitchen"],
        hasCleanService = map["hasCleanService"],
        hasShowerAndToilet = map["hasShowerAndToilet"],
        hasTV = map["hasTV"],
        hasMicrowave = map["hasMicrowave"],
        hasBalcony = map["hasBalcony"],
        hasAC = map["hasAC"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];

  @override
  String toString() {
    return 'DormitoryDetails{id: $id, dormitoryID: $dormitoryID, phoneNumber: $phoneNumber, email: $email, faxNumber: $faxNumber, address: $address, capacity: $capacity, description: $description, internetSpeed: $internetSpeed, hasKitchen: $hasKitchen, hasCleanService: $hasCleanService, hasShowerAndToilet: $hasShowerAndToilet, hasBalcony: $hasBalcony, hasTV: $hasTV, hasMicrowave: $hasMicrowave, hasAC: $hasAC, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
