import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user_model.dart';

class AuthController{
  static String _accessTokenKey = 'token';
  static String _userModelKay = 'user-data';

  static String ? accessToken;
  static UserModel ? userModel;

  static Future<void> saveUserData(UserModel model,String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey,token);
    await sharedPreferences.setString(_userModelKay,jsonEncode(model.toJson()));
    accessToken = token;
    userModel = model;
  }

  static Future getUserData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String ? token = sharedPreferences.getString(_accessTokenKey);

    if(token != null){
      String ? userData = sharedPreferences.getString(_userModelKay);
      userModel = UserModel.fromJson(jsonDecode(userData!)) as UserModel?;
    }
  }

  static Future<bool> isUserLoggedIn() async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     String ? token = sharedPreferences.getString(_accessTokenKey);
     if(token != null){
       accessToken = token;
       String ? userData = sharedPreferences.getString(_userModelKay);
       if(userData != null) {
         userModel = UserModel.fromJson(jsonDecode(userData));
       }
       return true;
     }
     return false;
  }
  static Future<void>clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}