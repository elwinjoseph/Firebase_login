import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistratioPageController {
  TextEditingController userTXT =
      TextEditingController(text: 'elwin1@gmail.com');
  TextEditingController passTXT = TextEditingController(text: 'vge2gp0gui');
  TextEditingController conpassTXT = TextEditingController(text: 'vge2gp0gui');

  FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('todos');

  void register({required BuildContext context}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: userTXT.text, password: passTXT.text);
      print(userCredential.user!.uid);
      addUser(email: userTXT.text, uid: userCredential.user!.uid); //tostring
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              elevation: 16,
              behavior: SnackBarBehavior.floating,
              content: Text('use strong password')),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              elevation: 16,
              behavior: SnackBarBehavior.floating,
              content: Text('Email already exist')),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addUser({required String email, required String uid}) {
    return users
        .add({'email': email, 'uid': uid})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
