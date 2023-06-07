import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c8_online/database/model/User.dart' as MyUser;
import 'package:todo_c8_online/database/my_database.dart';
class AuthProvider extends ChangeNotifier{
  MyUser.User? currentUser;
  void updateUser(MyUser.User loggedInUser){
    currentUser = loggedInUser;
    notifyListeners();
  }
  void logout(){
    FirebaseAuth.instance
        .signOut();
    currentUser = null;
  }

  Future<MyUser.User?> getUserFromDataBase()async{
    var user = await MyDataBase.readUser(FirebaseAuth.instance.currentUser?.uid ??"");
    currentUser = user;
    return user;
  }
}