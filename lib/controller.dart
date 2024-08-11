import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoController {
  TextEditingController title1 = TextEditingController();
  CollectionReference todos = FirebaseFirestore.instance.collection('todos');
  final Stream<QuerySnapshot> userStream =
      FirebaseFirestore.instance.collection('todos').snapshots();

  void addUser(String text) {
    // Your code to add the todo to Firestore, e.g.,:
    FirebaseFirestore.instance.collection('todos').add({
      'data': text,
    });
  }

  void deleteUser(String id) {
    todos.doc(id).delete().then((_) {
      print('Todo deleted');
    }).catchError((error) {
      print('Failed to delete todo: $error');
    });
  }
}
