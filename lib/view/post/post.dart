// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/data/services/video.controll.dart';
import 'package:tiktok_clone/view/mypage/mypage.dart';
import 'package:tiktok_clone/view/post/scrollPost.dart';
import 'package:tiktok_clone/view/upload/upload.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  ViedeoControll vdController = ViedeoControll();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          vdController.currentScreen == 0 ? Colors.black : Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            itemCount: 3,
            onPageChanged: (value) {
              print(value);
              if (value == 1) {
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
              } else {
                SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light);
              }
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                return scrollPost();
              } else if (index == 1) {
                return const ProfileScreen();
              } else {
                return const UploadScreen();
              }
            },
          )
        ],
      ),
    );
  }
}
