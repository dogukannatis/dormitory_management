
class Message {
  final String id;
  final String senderID;
  final String receiverID;
  final String content;
  DateTime? createdAt;
  DateTime? updatedAt;

  Message({
    required this.id,
    required this.senderID,
    required this.receiverID,
    required this.content,
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toMap() {
    return {
      "id"        : id,
      "senderID"     : senderID,
      "receiverID"      : receiverID,
      "content"   : content,
      "createdAt" : createdAt,
      "updatedAt" : updatedAt,
    };
  }

  Message.fromMap(Map<String, dynamic> map) :
        id = map["id"],
        senderID = map["senderID"],
        receiverID = map["receiverID"],
        content = map["content"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];

  @override
  String toString() {
    return 'Message{id: $id, senderID: $senderID, receiverID: $receiverID, content: $content, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
