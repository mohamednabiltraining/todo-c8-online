import 'package:flutter/material.dart';
import 'package:todo_c8_online/database/model/User.dart';
class AuthProvider extends ChangeNotifier{
  User? currentUser;
  void updateUser(User loggedInUser){
    currentUser = loggedInUser;
    notifyListeners();
  }
}