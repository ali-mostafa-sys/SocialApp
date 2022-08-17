class LikesModel{
  bool Likes;
  LikesModel({required this.Likes});
  factory LikesModel.fromJson(Map<String,dynamic>json){
    final likes=json['likes'];
    return LikesModel(Likes: likes);
  }

  Map<String,dynamic>toJson(){
    return {
      'likes':Likes,
    };
  }
}