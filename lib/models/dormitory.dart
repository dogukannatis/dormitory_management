
class Dormitory {
  final String id;
  final String universityID;
  String? name;
  int? quota;
  DateTime? createdAt;
  DateTime? updatedAt;

  Dormitory({
    required this.id,
    required this.universityID,
    this.name,
    this.quota,
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toMap() {
    return {
      "id"        : id,
      "universityID"     : universityID,
      "name"      : name,
      "quota"  : quota,
      "createdAt" : createdAt,
      "updatedAt" : updatedAt,
    };
  }

  Dormitory.fromMap(Map<String, dynamic> map) :
        id = map["id"],
        universityID = map["universityID"],
        name = map["name"],
        quota = map["quota"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];


}
