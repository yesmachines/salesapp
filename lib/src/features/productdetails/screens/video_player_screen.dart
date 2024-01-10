import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;
  const VideoPlayerScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool fullScreen = false;

  List<YoutubePlayerController> lYTC = [];
  Map<String, dynamic> cStates = {};
  late YoutubePlayerController _ytController;

  @override
  void initState() {
    _ytController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        enableCaption: true,
        captionLanguage: 'en',
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    for (var element in lYTC) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
        }
        return true;
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              if (MediaQuery.of(context).orientation == Orientation.landscape) {
                SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
              }
              Navigator.of(context).pop();
            },
          ),
        ),
        body: (widget.videoId.isNotEmpty)
            ? YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _ytController,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.lightGreen,
                  bottomActions: [
                    CurrentPosition(),
                    ProgressBar(isExpanded: true),
                    FullScreenButton(),
                  ],
                  onReady: () {},
                  onEnded: (YoutubeMetaData _md) {
                    _ytController.seekTo(const Duration(seconds: 0));
                  },
                ),
                builder: (context, player) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // some widgets
                        player,
                        // some other widgets
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: Text("No Videos"),
              ),
      ),
    );
  }
}
