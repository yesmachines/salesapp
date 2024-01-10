import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yesmachinery/src/features/productdetails/screens/video_player_screen.dart';
import 'package:yesmachinery/src/global_widget.dart/common_image_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> productVideos;
  const VideosListScreen({Key? key, required this.productVideos}) : super(key: key);

  @override
  State<VideosListScreen> createState() => _VideosListScreenState(productVideos);
}

class _VideosListScreenState extends State<VideosListScreen> {
  final List<Map<String, dynamic>> videoLists;
  _VideosListScreenState(this.videoLists);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (MediaQuery.of(context).orientation == Orientation.landscape) {
              SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
            }
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Application Videos'),
        elevation: 2.0,
      ),
      body: (videoLists.length > 0)
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: videoLists.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  String videoUrl = videoLists[index]["video_url"];
                  String videoId = YoutubePlayer.convertUrlToId(videoUrl) ?? '';

                  return InkWell(
                    onTap: () {
                      Get.to(() => VideoPlayerScreen(
                            videoId: videoId,
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 220.0,
                            width: MediaQuery.sizeOf(context).width * .9,
                            decoration: BoxDecoration(
                              color: Color(0xfff5f5f5),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                child: CommonImageView(
                                  url: 'https://img.youtube.com/vi/$videoId/0.jpg',
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Icon(
                            Icons.play_circle_filled,
                            size: 50,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(
              child: Text("No Videos"),
            ),
    );
  }
}
