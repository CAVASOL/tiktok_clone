// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/data/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String? profileImage;

  void register() {
    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;
    signUpWithEmailAndImage(
        email, password, name, File(profileImage!), context);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        profileImage = pickedImage.path;
        Logger().d(profileImage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Register',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: profileImage != null
                    ? FileImage(File(profileImage!))
                    : null,
                child: profileImage == null
                    ? const Icon(Icons.add_a_photo,
                        size: 40, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: register,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
