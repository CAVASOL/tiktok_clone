// ignore_for_file: constant_identifier_names, must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/data/services/video.controll.dart';
import 'package:tiktok_clone/util/tiktok_theme.dart';

class BottomBar extends StatelessWidget {
  static const double NavigationIconSize = 20;
  static const double CreateButtonWidth = 36;

  ViedeoControll viedeoControl = ViedeoControll();

  BottomBar({Key? key}) : super(key: key);

  Widget get customCreateIcon => SizedBox(
        width: 46,
        height: 28,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              width: CreateButtonWidth,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 250, 45, 108),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              width: CreateButtonWidth,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 32, 211, 234),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Center(
              child: Container(
                height: double.infinity,
                width: CreateButtonWidth,
                decoration: BoxDecoration(
                  color: viedeoControl.currentScreen == 0
                      ? Colors.white
                      : Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.add,
                  color: viedeoControl.currentScreen == 0
                      ? Colors.black
                      : Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black12),
        ),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              menuButton('Home', TikTokIcons.home, 0),
              const SizedBox(
                width: 16,
              ),
              customCreateIcon,
              const SizedBox(
                width: 16,
              ),
              menuButton('Profile', TikTokIcons.profile, 3)
            ],
          ),
          SizedBox(
            height: Platform.isIOS ? 40 : 10,
          )
        ],
      ),
    );
  }

  Widget menuButton(String text, IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        viedeoControl.setActualScreen(index);
      },
      child: SizedBox(
        height: 45,
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon,
                color: viedeoControl.currentScreen == 0
                    ? viedeoControl.currentScreen == index
                        ? Colors.white
                        : Colors.white70
                    : viedeoControl.currentScreen == index
                        ? Colors.black
                        : Colors.black54,
                size: NavigationIconSize),
            const SizedBox(
              height: 8,
            ),
            Text(
              text,
              style: TextStyle(
                  fontWeight: viedeoControl.currentScreen == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: viedeoControl.currentScreen == 0
                      ? viedeoControl.currentScreen == index
                          ? Colors.white
                          : Colors.white70
                      : viedeoControl.currentScreen == index
                          ? Colors.black
                          : Colors.black54,
                  fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
