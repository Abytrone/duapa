// import 'package:animate_do/animate_do.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:duapa/services/constants.dart';
// import 'package:duapa/services/remote_services.dart';
// import 'package:duapa/services/theme.dart';
// import 'package:duapa/views/AcountUIComponent/Account.dart';
// import 'package:flutter/material.dart';
// import 'package:loading_indicator/loading_indicator.dart';
// import 'package:shimmer/shimmer.dart';

// class BlogCategoryCard extends StatefulWidget {
//   const BlogCategoryCard({Key? key}) : super(key: key);

//   @override
//   State<BlogCategoryCard> createState() => _BlogCategoryCardState();
// }

// class _BlogCategoryCardState extends State<BlogCategoryCard> {
//   @override
//   Widget build(BuildContext context) {
//     return ElasticInRight(
//       child: Container(
//         height: 130,
//         child: FutureBuilder<List<Category>?>(
//           future: RemoteServices.fetchCategories(),
//           builder: (context, AsyncSnapshot<List<Category>?> snapshot) {
//             switch (snapshot.connectionState) {
//               case ConnectionState.waiting:
//                 return const Center(
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       top: 20,
//                       left: 160.0,
//                       right: 160,
//                     ),
//                     child: LoadingIndicator(
//                       indicatorType: Indicator.ballBeat,
//                     ),
//                   ),
//                 );
//               case ConnectionState.none:
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 10),
//                   child: Center(
//                     child: Text(
//                       'No Items yet!',
//                       style: TextStyle(
//                         color: Theme.of(context).brightness ==
//                                 lightThemeData(context).brightness
//                             ? Colors.white
//                             : kContentColorLightTheme,
//                       ),
//                     ),
//                   ),
//                 );
//               case ConnectionState.active:
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               case ConnectionState.done:
//                 if (snapshot.hasError) {
//                   print(snapshot.hasError);
//                   return Container(
//                     child: Center(
//                       child: Text(
//                         'Error loading Categories!',
//                         style: TextStyle(
//                           color: Theme.of(context).brightness ==
//                                   lightThemeData(context).brightness
//                               ? kContentColorDarkTheme
//                               : kContentColorLightTheme,
//                         ),
//                       ),
//                     ),
//                   );
//                 } else if (snapshot.data == null) {
//                   return Container(
//                     child: Center(
//                       child: Text(
//                         'No Categories!',
//                         style: TextStyle(
//                           color: Theme.of(context).brightness ==
//                                   lightThemeData(context).brightness
//                               ? kContentColorLightTheme
//                               : kContentColorDarkTheme,
//                         ),
//                       ),
//                     ),
//                   );
//                 } else
//                   return ListView.separated(
//                     itemCount: snapshot.data!.length,
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     separatorBuilder: (context, index) {
//                       return Container(
//                         width: 10,
//                         color: Theme.of(context).brightness ==
//                                 lightThemeData(context).brightness
//                             ? Colors.white
//                             : kContentColorLightTheme,
//                       );
//                     },
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).pushNamed('coomingsoon');
//                         },
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(5),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                                 border:
//                                     Border.all(width: 5, color: kPrimaryColor),
//                               ),
//                               child: CachedNetworkImage(
//                                 imageUrl: snapshot.data![index].picture!,
//                                 imageBuilder: (context, imageProvider) =>
//                                     Container(
//                                   height: 70,
//                                   width: 70,
//                                   padding: const EdgeInsets.all(8),
//                                   child: Image(image: imageProvider),
//                                 ),
//                                 placeholder: (context, url) =>
//                                     Shimmer.fromColors(
//                                   baseColor: const Color(0xFFDFDFDF),
//                                   highlightColor: Colors.white,
//                                   child: Container(
//                                     height: 90,
//                                     width: 90,
//                                     padding: const EdgeInsets.all(8),
//                                     child: Image(
//                                       image: AssetImage(
//                                           'assets/img/broken-image.png'),
//                                     ),
//                                   ),
//                                 ),
//                                 errorWidget: (context, url, error) => Container(
//                                   height: 90,
//                                   width: 90,
//                                   padding: const EdgeInsets.all(8),
//                                   child: Image(
//                                     image: AssetImage(
//                                         'assets/img/broken-image.png'),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Text(
//                               snapshot.data![index].categoryName,
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: kContentColorLightTheme,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
