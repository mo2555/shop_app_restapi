import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

  static late SharedPreferences sharedPreferences ;

  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required String key,
    required bool value,
})async{
    await CacheHelper.init();
    return await sharedPreferences.setBool(key, value);
  }

  static getData({
    required String key,
  })async{
    await CacheHelper.init();
    if(sharedPreferences.containsKey(key)) {
      return sharedPreferences.getBool(key);
    }
    return false;
  }

  static Future<bool> setToken({
    required String key,
    required String value,
  })async{
    await CacheHelper.init();
    return await sharedPreferences.setString(key, value);
  }

  static Future<String?>? getToken({
    required String key,
  })async{
    await CacheHelper.init();
    if(sharedPreferences.containsKey(key)) {
      return sharedPreferences.getString(key);
    }
    return null;
  }

  static Future<bool> removeData({
    required String key,
  })async{
    await CacheHelper.init();
if(sharedPreferences.containsKey(key)){
  return await sharedPreferences.remove(key);
}
  return false;
  }

}