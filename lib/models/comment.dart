
class Comment {
  final String id;
  final String userID;
  final String dormitoryID;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;

  Comment({
    required this.id,
    required this.userID,
    required this.dormitoryID,
    this.content,
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toMap() {
    return {
      "id"        : id,
      "userID"     : userID,
      "dormitoryID"      : dormitoryID,
      "content"  : content,
      "createdAt" : createdAt,
      "updatedAt" : updatedAt,
    };
  }

  Comment.fromMap(Map<String, dynamic> map) :
        id = map["id"],
        userID = map["userID"],
        dormitoryID = map["dormitoryID"],
        content = map["content"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];


}
