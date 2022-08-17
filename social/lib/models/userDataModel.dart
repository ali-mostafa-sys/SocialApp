class UserDataModel{
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  bool? isEmailVerified;
  String? bio;
  String? cover;
  UserDataModel({required this.name,required this.email,required this.phone,required this.uId,required this.isEmailVerified,required this.image,required this.bio,required this.cover});

  factory UserDataModel.fromJson(Map<String,dynamic>json){
    final name= json['name'];
    final email=json['email'];
    final phone=json['phone'];
    final uId=json['uId'];
    final image=json['image'];
    final isEmailVerified=json['isEmailVerified'];
    final bio=json['bio'];
    final cover=json['cover'];
    return UserDataModel(name: name, email: email, phone: phone, uId: uId,isEmailVerified: isEmailVerified,image: image,bio: bio,cover: cover);

  }
  Map<String,dynamic> toMap(){
    return {
      'name':name as String,
      'email':email as String,
      'phone':phone as String,
      'uId':uId as String,
      'isEmailVerified':isEmailVerified,
      'image':image,
      'bio':bio,
      'cover':cover,
    };
  }
}