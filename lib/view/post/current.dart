import 'package:flutter/material.dart';
import 'package:tiktok_clone/data/services/video.controll.dart';
import 'package:tiktok_clone/view/mypage/mypage.dart';
import 'package:tiktok_clone/view/post/videoFeed.dart';
import 'package:tiktok_clone/view/upload/upload.dart';

Widget currentScreen() {
  ViedeoControll viedeoControl = ViedeoControll();
  switch (viedeoControl.currentScreen) {
    case 0:
      return feedVideos();
    case 1:
      return const ProfileScreen();
    case 2:
      return const UploadScreen();
    default:
      return feedVideos();
  }
}
