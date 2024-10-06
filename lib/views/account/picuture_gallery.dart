import 'package:duapa/models/gallery_picture_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/account/gallery_photo_view.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/gallery_services.dart';

class PictureGalleryScreen extends StatefulWidget {
  const PictureGalleryScreen({super.key});
  @override
  State<PictureGalleryScreen> createState() => _PictureGalleryScreenState();
}

class _PictureGalleryScreenState extends State<PictureGalleryScreen> {
  final GalleryServices _galleryServices = GalleryServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Picture Gallery',
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
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: FutureBuilder<GalleryPictures>(
        future: _galleryServices.getPictures(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
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
                });
          } else if (snapshot.hasData) {
            if (snapshot.data!.data.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              return GridView.builder(
                padding: const EdgeInsets.all(2),
                itemCount: snapshot.data!.data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryPhotoViewWrapper(
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            galleryItems: snapshot.data!.data,
                            initialIndex: snapshot.data!.data
                                .indexOf(snapshot.data!.data[index]),
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'someTag$index',
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/img/placeholder.png',
                        image: snapshot.data!.data[index].url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: Text(
                  'No Products at the moment!',
                  style: TextStyle(
                    color: Theme.of(context).brightness ==
                            lightThemeData(context).brightness
                        ? Colors.white
                        : kContentColorLightTheme,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
