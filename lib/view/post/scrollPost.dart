// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tiktok_clone/view/post/current.dart';
import 'package:tiktok_clone/view/post/widgets/bottomBar.dart';

Widget scrollPost() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Expanded(child: currentScreen()),
      BottomBar(),
    ],
  );
}
