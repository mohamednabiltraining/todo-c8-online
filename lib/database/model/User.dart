import 'package:firebase_auth/firebase_auth.dart';

class User{// data class
  static const String collectionName = 'users';
  String? id;
  String? name;
  String? email;


  User({this.id,this.name,this.email});

  User.fromFireStore(Map<String,dynamic>? data):
        this(id: data?['id'],
          name: data?['name'],
          email: data?['email']);
  // {
  //   id = data['id'];
  //   name = data['name'];
  //   email = data['email'];
  // }
  Map<String,dynamic> toFireStore(){
   return {
     'id':id,
     'name':name,
     'email':email
   };
  }
}