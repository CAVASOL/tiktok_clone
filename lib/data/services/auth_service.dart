// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/view/auth/login.dart';
import 'package:tiktok_clone/view/post/post.dart';

Future<void> signInWithEmail(
    String email, String password, BuildContext context) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PostScreen()),
      );
    }
  } catch (e) {
    print('Error signing in with email: $e');
  }
}

Future<void> signUpWithEmailAndImage(
  String email,
  String password,
  String name,
  File imageFile,
  BuildContext context,
) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    if (userCredential.user != null) {
      String userId = userCredential.user!.uid;

      String? imageUrl = await uploadProfileImage(userId, imageFile);

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'uuid': userId,
        'name': name,
        'image_url': imageUrl,
      });

      await userCredential.user!.updateDisplayName(name);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  } catch (e) {
    print('Error signing up with email and image: $e');
  }
}

Future<String?> uploadProfileImage(String userId, File imageFile) async {
  try {
    Reference storageRef =
        FirebaseStorage.instance.ref().child('profile_/images/$userId.jpg');
    UploadTask uploadTask = storageRef.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    String downloardUrl = await snapshot.ref.getDownloadURL();
    return downloardUrl;
  } catch (e) {
    print('Error: $e');
  }
  return null;
}

Future<String?> getCurrentUserName() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await user.reload();
    user = FirebaseAuth.instance.currentUser;
    return user!.displayName;
  }
  return null;
}

Future<String?> getCurrentUserUuid() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await user.reload();
    user = FirebaseAuth.instance.currentUser;
    return user!.uid;
  }
  return null;
}

Future<String?> getProfileImageUrl() async {
  User? user = FirebaseAuth.instance.currentUser;
  String uid = user!.uid;
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('uuid', isEqualTo: uid)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      print('No user found with uuid: $uid');
      return null;
    }

    DocumentSnapshot snapshot = querySnapshot.docs.first;

    if (snapshot.exists) {
      String? imageUrl = snapshot.get("image_url");
      return imageUrl;
    }
  } catch (e) {
    print('Error getting profile image URL: $e');
  }
  return null;
}
