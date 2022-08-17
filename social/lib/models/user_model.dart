class UserModel {
  int id;
  String name;
  String phone;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
});
  factory UserModel.fromJson(Map<String,dynamic>json){
    final id=json['id'];
    final name=json['name'];
    final phone=json['phone'];
    return UserModel(id: id, name: name, phone: phone);

  }


}