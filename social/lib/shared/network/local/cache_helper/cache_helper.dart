import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

static late  SharedPreferences shared;

static init() async {
  shared = await SharedPreferences.getInstance();
}

static Future<bool> putStringData({required String key,required String value})async{

  return await shared.setString(key, value);
}
static getStringData({
  required String key,
}) {
  return shared.getString(key);
}



}