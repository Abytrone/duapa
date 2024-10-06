import 'package:duapa/services/gallery_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../models/gallery_video_class.dart';
import '../../services/constants.dart';
import '../../services/theme.dart';

class VideoGallery extends StatefulWidget {
  const VideoGallery({super.key});

  @override
  State<VideoGallery> createState() => _VideoGalleryState();
}

class _VideoGalleryState extends State<VideoGallery> {
  // final YoutubePlayerController _videoController = YoutubePlayerController(initialVideoId: '');
  final GalleryServices _galleryServices = GalleryServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Video Gallery',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).brightness ==
                    lightThemeData(context).brightness
                ? kContentColorLightTheme
                : kContentColorDarkTheme,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            Theme.of(context).brightness == lightThemeData(context).brightness
                ? kContentColorDarkTheme
                : kContentColorLightTheme,
        iconTheme: IconThemeData(
          color:
              Theme.of(context).brightness == lightThemeData(context).brightness
                  ? kContentColorLightTheme
                  : kContentColorDarkTheme,
        ),
      ),
      body: FutureBuilder<List<GalleryVideo>>(
        future: _galleryServices.getVideos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.waiting:
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade100,
                      highlightColor: Colors.grey.shade200,
                      child: Container(
                        height: 230,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.green,
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  );
                },
              );
            case ConnectionState.none:
              return const Center(
                child: Text('No Data'),
              );
            case ConnectionState.done:
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('There are no videos yet'),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: YoutubePlayer(
                          progressColors: ProgressBarColors(
                            playedColor: kPrimaryColor,
                            handleColor: kPrimaryColor,
                            bufferedColor: Colors.white70,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                          ),
                          controller: YoutubePlayerController(
                            initialVideoId: snapshot.data![index].code,
                            flags: const YoutubePlayerFlags(
                              autoPlay: false,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
