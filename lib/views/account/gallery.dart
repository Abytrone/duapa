import 'package:duapa/views/account/picuture_gallery.dart';
import 'package:duapa/views/account/video_gallery.dart';
import 'package:flutter/material.dart';

import '../../services/constants.dart';
import '../../services/theme.dart';

class GalleryHome extends StatefulWidget {
  const GalleryHome({super.key});

  @override
  State<GalleryHome> createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gallery',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GalleryItem(
              image: 'assets/icon/gallery.png',
              name: 'Picture Gallery',
              color: Colors.blue,
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const PictureGalleryScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            GalleryItem(
              image: 'assets/icon/play.png',
              name: 'Video Gallery',
              color: Colors.red,
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, firstAnimation, secondAnimation) =>
                        const VideoGallery(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryItem extends StatelessWidget {
  const GalleryItem({
    super.key,
    required this.image,
    required this.name,
    required this.color,
    required this.onTap,
  });
  final String image, name;
  final Color color;
  final void Function()? onTap;
  //  'assets/icon/gallery.png'

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.green,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                width: 100,
                color: color,
                image: AssetImage(image),
              ),
              const SizedBox(height: 10),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
