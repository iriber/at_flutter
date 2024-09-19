
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPrefUtils {
  
  final String userKey = "User";
  final String rememberedUserKey = "RememberedUser";
  final String selectedFarmKey = "SelectedFarm";

  Future<User> getUser() async {
    User user;
    dynamic jsonUser = await _read(userKey);
    if (jsonUser != null) {
      user = User.fromJson(jsonUser);
    } else {
      user = await getRememberedUser();
    }
    return user;
  }


  Future<User> getRememberedUser() async {
    User user;
    dynamic jsonUser = await _read(rememberedUserKey);
    if (jsonUser != null) {
      user = User.fromJson(jsonUser);
    } else {
      user = User.empty();
    }
    return user;
  }

  Future<void> saveUser(User user) async{
    await _remove(userKey);
    return _save(userKey, user.toMap());
  }

  Future<void> saveRememberedUser(User user) async{
    await _remove(rememberedUserKey);
    return _save(rememberedUserKey, user.toMap());
  }

  Future<void> updateUserLoggedInfo(User updatedUser) async{
    dynamic jsonUser = await _read(userKey);
    if( jsonUser!=null){
      saveUser(updatedUser);
    }

    jsonUser = await _read(rememberedUserKey);
    if( jsonUser!=null){
      saveRememberedUser(updatedUser);
    }

  }

  Future<void> userLogout() async{
    _remove(userKey);
    _remove(rememberedUserKey);
  }


  Future<void> userRemoveRemembered() async{
    _remove(rememberedUserKey);
  }

  userRemove(){
    _remove(userKey);
  }

  Future<bool> userIsLogged() async{
    User user = await getUser();
    return (await userIsRemembered()) ||  user.id>0;
  }


  Future<bool> userIsRemembered() async {
    User user = await getRememberedUser();
    return user.id > 0;
  }


  Future<void> saveSelectedFarm(Farm company) async{
    await _remove(selectedFarmKey);
    return _save(selectedFarmKey, company.toMap());
  }

  Future<Farm> getSelectedFarm() async {
    Farm farm;
    dynamic jsonFarm = await _read(selectedFarmKey);
    if (jsonFarm != null) {
      farm = Farm.fromJson(jsonFarm);
    } else{
      farm = Farm.empty();
    }
    return farm;
  }

  Future<bool> isFarmSelected() async{
    Farm company = await getSelectedFarm();
    return company.id>0;
  }

  Future<void> removeSelectedFarm() async{
    await _remove(selectedFarmKey);
  }


  Future<dynamic> _read(String key) async {
    final prefs = await SharedPreferences.getInstance();

    String jsonValue = prefs.getString(key) ?? "";

    if (jsonValue != "")
      return json.decode(jsonValue);
    else
      return null;
  }

  _save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  _remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

}
