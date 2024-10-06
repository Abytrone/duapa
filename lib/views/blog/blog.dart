import 'dart:async';

import 'package:duapa/responsive_helper.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/blog/widgets/blog_card.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../controllers/posts_controller.dart';
import '../../models/posts_class.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () => _controller.fetchPosts());
    super.initState();
  }

  final PostsController _controller = Get.put(PostsController());
  List<String> keyWords = ['Agric', 'Farming', 'Crops', 'Tamale'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Duapa Blog'),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: LayoutBuilder(builder: (context, constraints) {
        return

            // Container(
            //   padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            //   child: ListView(
            //     physics: const ScrollPhysics(),
            //     children: const [

            //       // Blog post items
            //       PostCard(),
            //     ],
            //   ),
            // );
            FutureBuilder<List<PostData>?>(
          future: _controller.fetchPosts(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: constraints.maxWidth < 768 ? 160.0 : 450,
                      right: constraints.maxWidth < 768 ? 160 : 450,
                    ),
                    child: const LoadingIndicator(
                      indicatorType: Indicator.ballBeat,
                    ),
                  ),
                );
              case ConnectionState.none:
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      'No Items yet!',
                      style: TextStyle(
                        color: Theme.of(context).brightness ==
                                lightThemeData(context).brightness
                            ? Colors.white
                            : kContentColorLightTheme,
                      ),
                    ),
                  ),
                );
              case ConnectionState.active:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                return Obx(
                  () => ResponsiveHelper(
                    mobile: ListView.builder(
                      itemCount: _controller.postsList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlogCard(
                            post: _controller.postsList[index],
                            keywords: keyWords,
                            constraints: constraints,
                          ),
                        );
                      },
                    ),
                    tablet: SingleChildScrollView(
                      child: MasonryGridView.count(
                        padding: const EdgeInsets.all(10),
                        crossAxisCount: 2,
                        itemCount: _controller.postsList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return BlogCard(
                            post: _controller.postsList[index],
                            keywords: keyWords,
                            constraints: constraints,
                          );
                        },
                      ),
                    ),
                  ),
                );
            }
          },
        );
      }),
    );
  }
}

// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Text(
//       'See by',
//       style: TextStyle(
//         color: kPrimaryColor,
//       ),
//     ),
//     Icon(
//       Icons.chevron_right,
//       color: kPrimaryColor,
//     ),
//   ],
// ),
// Category section
// BlogCategoryCard(),

// Padding(
//   padding: const EdgeInsets.symmetric(vertical: 10.0),
//   child: Container(
//     height: 5,
//     width: 500,
//     color: Colors.grey.withOpacity(0.2),
//   ),
// ),
