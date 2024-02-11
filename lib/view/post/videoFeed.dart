// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tiktok_clone/data/services/video.controll.dart';
import 'package:tiktok_clone/view/post/videoCard.dart';
import '../../data/model/video.dart';

Widget feedVideos() {
  ViedeoControll viedeoControl = ViedeoControll();

  return FutureBuilder<List<Video>>(
    future: viedeoControl.initializeVideoList(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        );
      } else if (snapshot.hasError) {
        return const Center(
          child: Text('Error loading videos'),
        );
      } else {
        return Stack(
          children: [
            PageView.builder(
              controller: PageController(
                initialPage: 0,
                viewportFraction: 1,
              ),
              itemCount: snapshot.data!.length,
              onPageChanged: (index) {
                index = index % snapshot.data!.length;
                viedeoControl.changeVideo(index);
              },
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                index = index % snapshot.data!.length;
                return videoCard(snapshot.data![index]);
              },
            ),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      '팔로잉',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white70),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      color: Colors.white70,
                      height: 10,
                      width: 1,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      '❤️',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }
    },
  );
}
