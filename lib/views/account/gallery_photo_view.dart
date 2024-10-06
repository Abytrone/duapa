import 'package:duapa/models/gallery_picture_class.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../services/constants.dart';
import '../../services/theme.dart';

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    super.key,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    required this.initialIndex,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  })  : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<Datum> galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(widget.galleryItems[index].url),
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  heroAttributes: PhotoViewHeroAttributes(tag: 'someTag$index'),
                );
              },
              itemCount: widget.galleryItems.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            // Container(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Text(
            //     "Image ${currentIndex + 1}",
            //     // '${widget.galleryItems[0].description}',
            //     style: const TextStyle(
            //       color: Colors.white,
            //       fontSize: 17.0,
            //       decoration: null,
            //     ),
            //   ),
            // ),
            Positioned(
              top: 50,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness ==
                          lightThemeData(context).brightness
                      ? kContentColorDarkTheme
                      : kContentColorLightTheme,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(context);
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    color: Theme.of(context).brightness ==
                            lightThemeData(context).brightness
                        ? kContentColorLightTheme
                        : kContentColorDarkTheme,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// class HeroPhotoViewRouteWrapper extends StatelessWidget {
//   const HeroPhotoViewRouteWrapper({
//     Key? key,
//     required this.imageProvider,
//     this.backgroundDecoration,
//     this.minScale,
//     this.maxScale,
//     required this.index,
//     this.description,
//   }) : super(key: key);

//   final ImageProvider imageProvider;
//   final BoxDecoration? backgroundDecoration;
//   final dynamic minScale;
//   final dynamic maxScale;
//   final int index;
//   final String? description;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           Container(
//             constraints: BoxConstraints.expand(
//               height: MediaQuery.of(context).size.height / 2,
//             ),
//             child: PhotoView(
//               imageProvider: imageProvider,
//               backgroundDecoration: backgroundDecoration,
//               minScale: minScale, 
//               maxScale: maxScale,
//               heroAttributes: PhotoViewHeroAttributes(tag: "someTag$index"),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Text(description!),
//           )
//         ],
//       ),
//     );
//   }
// }
