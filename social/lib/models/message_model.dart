class MessageModel{
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.text,
});
  factory MessageModel.fromJson(Map<String,dynamic> json){
    final senderId=json['senderId'];
    final receiverId=json['receiverId'];
    final dateTime=json['dateTime'];
    final text=json['text'];
    return MessageModel(senderId: senderId, receiverId: receiverId, dateTime: dateTime, text: text);
  }
  Map<String,dynamic> toMap(){
    return {
      'senderId':senderId,
      'receiverId':receiverId,
      'dateTime':dateTime,
      'text':text,
    };
}

}