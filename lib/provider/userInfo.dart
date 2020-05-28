import 'package:flutter/material.dart';

class UserInfoState with  ChangeNotifier{
  bool _isLogin = false;
  Map _userInfo; 

  Map get userInfo => _userInfo;

  bool get value => _isLogin;


  void updateData(Map userInfo) {
    _userInfo = userInfo;
    notifyListeners();
  }

  void  updateLoginState(bool val){
    _isLogin = val;
    notifyListeners();
  }
}