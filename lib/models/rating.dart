
class Rating {
  final String id;
  final String dormitoryID;
  final String userID;
  final int rating;
  DateTime? createdAt;
  DateTime? updatedAt;

  Rating({
    required this.id,
    required this.dormitoryID,
    required this.userID,
    required this.rating,
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toMap() {
    return {
      "id"        : id,
      "dormitoryID"     : dormitoryID,
      "userID"      : userID,
      "rating"   : rating,
      "createdAt" : createdAt,
      "updatedAt" : updatedAt,
    };
  }

  Rating.fromMap(Map<String, dynamic> map) :
        id = map["id"],
        dormitoryID = map["dormitoryID"],
        userID = map["userID"],
        rating = map["rating"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];

  @override
  String toString() {
    return 'Rating{id: $id, dormitoryID: $dormitoryID, userID: $userID, rating: $rating, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
