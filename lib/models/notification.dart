
class Notification {
  final String id;
  final String title;
  final String description;
  final String? senderID;
  final String? receiverID;
  String? imageURL;
  bool? seen;
  DateTime? createdAt;
  DateTime? updatedAt;

  Notification({
    required this.id,
    required this.title,
    required this.description,
    required this.senderID,
    required this.receiverID,
    this.imageURL,
    this.seen,
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toMap() {
    return {
      "id"        : id,
      "title"     : title,
      "description"      : description,
      "senderID"   : senderID,
      "receiverID"  : receiverID,
      "imageURL"  : imageURL,
      "seen"  : seen,
      "createdAt" : createdAt,
      "updatedAt" : updatedAt,
    };
  }

  Notification.fromMap(Map<String, dynamic> map) :
        id = map["id"],
        title = map["title"],
        description = map["description"],
        senderID = map["senderID"],
        receiverID = map["receiverID"],
        imageURL = map["imageURL"],
        seen = map["seen"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];

  @override
  String toString() {
    return 'Notification{id: $id, title: $title, description: $description, senderID: $senderID, receiverID: $receiverID, imageURL: $imageURL, seen: $seen, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
