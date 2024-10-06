import 'package:flutter/material.dart';

import '../../../models/ads_class.dart';
import '../../../services/constants.dart';
import '../../../services/theme.dart';

// List adImages = [
//   'https://img.freepik.com/free-vector/hand-drawn-flat-design-farmers-market-banner_23-2149347482.jpg?w=1800&t=st=1647812435~exp=1647813035~hmac=6dbb2d84e1041dcb71eab01a2d0ac811d3f77aaf7d7d8765c913016c719dfe2d',
//   'https://img.freepik.com/free-vector/watercolor-farmers-market-banner-design_23-2149356081.jpg?t=st=1647810955~exp=1647811555~hmac=1e416df80c521c5693cd4ffbe3ef2ed628d8b15d53dbd2668b85a48a4638b00e&w=1480',
//   'https://img.freepik.com/free-vector/hand-drawn-flat-design-farmers-market-banner_23-2149346461.jpg?t=st=1647810955~exp=1647811555~hmac=f9f4b1e4958fbb5b06fa725aa9e09e2c0c162adf43e38031107fda85f2d71401&w=1480',
// ];

class AdsWidget extends StatelessWidget {
  const AdsWidget({super.key, required this.ads});
  final List<Dater> ads;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: ads.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) {
        return Container(
          width: 10,
          color:
              Theme.of(context).brightness == lightThemeData(context).brightness
                  ? kContentColorDarkTheme
                  : kContentColorLightTheme,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/img/placeholder_landscape.png',
              image: ads[index].url,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

// CachedNetworkImage(
//   imageUrl: '${adImages[index]}',
//   imageBuilder: (context, imageProvider) =>
//       Container(
//     width: 340,
//     decoration: const BoxDecoration(
//       borderRadius: BorderRadius.all(
//         Radius.circular(20),
//       ),
//     ),
//     child: Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           fit: BoxFit.cover,
//           image: imageProvider,
//         ),
//         borderRadius: const BorderRadius.all(
//           Radius.circular(20),
//         ),
//       ),
//     ),
//   ),
//   placeholder: (context, url) =>
//       Shimmer.fromColors(
//     baseColor: const Color(0xFFDFDFDF),
//     highlightColor: Colors.white,
//     child: Container(
//       width: 340,
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.all(
//           Radius.circular(20),
//         ),
//       ),
//       child: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             fit: BoxFit.contain,
//             image: AssetImage(
//                 'assets/img/broken-image.png'),
//           ),
//           borderRadius: BorderRadius.all(
//             Radius.circular(20),
//           ),
//         ),
//       ),
//     ),
//   ),
//   errorWidget: (context, url, error) =>
//       Container(
//     width: 340,
//     decoration: const BoxDecoration(
//       borderRadius: BorderRadius.all(
//         Radius.circular(20),
//       ),
//     ),
//     child: Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           fit: BoxFit.contain,
//           image: AssetImage(
//               'assets/img/broken-image.png'),
//         ),
//         borderRadius: BorderRadius.all(
//           Radius.circular(20),
//         ),
//       ),
//     ),
//   ),
// ),
