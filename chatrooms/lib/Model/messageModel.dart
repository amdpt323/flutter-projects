
class Message{

  final String ? uid;
  final String ? message;
  final DateTime ? createdAt;

  Message({
    this.message,
    this.createdAt,
    this.uid,
  });

  factory Message.fromJson(dynamic json){
    if(json==null){
      return Message();
    }

    return Message(
      uid:json["uid"],
      message: json["message"],
      createdAt: json["createdAt"].toDate(),
    );
  }
}