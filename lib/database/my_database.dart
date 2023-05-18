import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_c8_online/database/model/User.dart';
import 'package:todo_c8_online/database/model/task.dart';

class MyDataBase{

  static CollectionReference<User> getUsersCollection(){
    return FirebaseFirestore.instance.collection(User.collectionName)
        .withConverter<User>(
      fromFirestore: (snapshot, options) => User.fromFireStore(snapshot.data()),
      toFirestore: (user, options) => user.toFireStore(),
    );
  }
  static CollectionReference<Task> getTasksCollection(String uid){
    return getUsersCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter<Task>(fromFirestore: (snapshot, options) => Task.fromFireStore(snapshot.data()),
        toFirestore: (task, options) => task.toFireStore(),);
  }


  static Future<void> addUser(User user){
    var collection = getUsersCollection();
    return collection.doc(user.id).set(user);
  }
  static Future<User?> readUser(String id)async{
    var collection = getUsersCollection();
    var docSnapshot = await collection.doc(id).get();
    return docSnapshot.data();
  }
}