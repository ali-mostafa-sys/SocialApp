class UserAddPostModel{
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  UserAddPostModel({required this.name,required this.uId,required this.image,required this.dateTime,required this.text,required this.postImage});

  factory UserAddPostModel.fromJson(Map<String,dynamic>json){
    final name= json['name'];
    final uId=json['uId'];
    final image=json['image'];
    final dateTime=json['dateTime'];
    final text=json['text'];
    final postImage=json['postImage'];
    return UserAddPostModel(name: name, uId: uId,image: image,dateTime: dateTime,text: text,postImage: postImage);

  }
  Map<String,dynamic> toMap(){
    return {
      'name':name as String,
      'uId':uId as String,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,

    };
  }
}