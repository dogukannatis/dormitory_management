
class University {
  final String id;
  String? name;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;

  University({
    required this.id,
    this.name,
    this.address,
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toMap() {
    return {
      "id"        : id,
      "name"     : name,
      "address"      : address,
      "createdAt" : createdAt,
      "updatedAt" : updatedAt,
    };
  }

  University.fromMap(Map<String, dynamic> map) :
        id = map["id"],
        name = map["name"],
        address = map["address"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];

  @override
  String toString() {
    return 'University{id: $id, name: $name, address: $address, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
