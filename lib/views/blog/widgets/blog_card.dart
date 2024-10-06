import 'package:cached_network_image/cached_network_image.dart';
import 'package:duapa/controllers/posts_controller.dart';
import 'package:duapa/models/posts_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/views/blog/blog_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../../../services/blog_services.dart';

class BlogCard extends StatefulWidget {
  const BlogCard(
      {super.key,
      required this.post,
      required this.keywords,
      required this.constraints});
  final PostData post;
  final List<String> keywords;

  final BoxConstraints constraints;

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  final PostsController _controller = Get.put(PostsController());
  final BlogServices blogServices = BlogServices();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10.0,
              color: Colors.black12,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/img/profile.jpg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.attributes.postedBy,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  widget.constraints.maxWidth < 768 ? 12 : 17,
                            ),
                          ),
                          Text(
                            'Tamale, Ghana',
                            style: TextStyle(
                              fontSize:
                                  widget.constraints.maxWidth < 768 ? 10 : 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.post.attributes.createdAt,
                            style: TextStyle(
                              fontSize:
                                  widget.constraints.maxWidth < 768 ? 12 : 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.more_vert),
              ],
            ),
            SizedBox(
              height: widget.constraints.maxWidth < 768 ? 50 : 70,
              child: ListView.separated(
                itemCount: widget.keywords.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                separatorBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    width: 10,
                  );
                },
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        widget.keywords[index],
                        style: TextStyle(
                          fontSize: widget.constraints.maxWidth < 768 ? 10 : 14,
                          fontWeight: FontWeight.bold,
                          color: kSecondaryColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return BlogDetailScreen(
                        post: widget.post,
                        keyWords: widget.keywords,
                        index: _controller.postsList.indexOf(widget.post),
                      );
                    },
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl: widget.post.attributes.picture,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: 200,
                    width: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          widget.constraints.maxWidth < 768 ? 15 : 25)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                // progressIndicatorBuilder: (context, url, downloadProgress) {
                //   return Shimmer.fromColors(
                //     direction: ShimmerDirection.btt,
                //     baseColor: Colors.grey[200]!,
                //     highlightColor: Colors.grey[50]!,
                //     child: Container(
                //       height: 200,
                //       width: 500,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(
                //             widget.constraints.maxWidth < 768 ? 15 : 25)),
                //         image: DecorationImage(
                //           fit: BoxFit.cover,
                //           image: NetworkImage(url),
                //         ),
                //       ),
                //     ),
                //   );
                // },
                placeholder: (context, url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(
                        widget.constraints.maxWidth < 768 ? 15 : 25),
                    child: Image.asset(
                      'assets/img/placeholder.png',
                      width: 500,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  // return Container(
                  //   height: 200,
                  //   width: 500,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(
                  //         widget.constraints.maxWidth < 768 ? 15 : 25)),
                  //     image: DecorationImage(
                  //       image: imageProvider,
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // );
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(
                        widget.constraints.maxWidth < 768 ? 15 : 25),
                    child: Image.asset(
                      'assets/img/placeholder.png',
                      width: 500,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text.rich(
                TextSpan(
                  text: '',
                  children: [
                    WidgetSpan(
                      child: SizedBox(
                        height: 65,
                        child: Html(
                          data: widget.post.attributes.description,
                        ),
                      ),
                    ),
                    const TextSpan(text: '...'),
                  ],
                ),
                textAlign: TextAlign.left,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: widget.constraints.maxWidth < 768 ? 15 : 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    LikeButton(
                      size: widget.constraints.maxWidth < 768 ? 20 : 30,
                      onTap: (isLiked) {
                        _controller.fetchPosts();
                        return blogServices.onLikeButtonTapped(
                          isLiked,
                          widget.post.id,
                          context,
                        );
                      },
                      circleColor: const CircleColor(
                          start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Color(0xff33b5e5),
                        dotSecondaryColor: Color(0xff0099cc),
                      ),
                      likeBuilder: (bool isLiked) {
                        return widget.post.attributes.hasLiked == '0'
                            ? Icon(
                                isLiked
                                    ? FontAwesomeIcons.solidHeart
                                    : FontAwesomeIcons.heart,
                                color: isLiked ? Colors.red : Colors.grey,
                                size:
                                    widget.constraints.maxWidth < 768 ? 20 : 30,
                              )
                            : Icon(
                                isLiked
                                    ? FontAwesomeIcons.heart
                                    : FontAwesomeIcons.solidHeart,
                                color: isLiked ? Colors.grey : Colors.red,
                                size:
                                    widget.constraints.maxWidth < 768 ? 20 : 30,
                              );
                      },
                    ),
                    Text(
                      widget.post.attributes.likes,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: widget.constraints.maxWidth < 768 ? 12 : 17,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 25,
                      width: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      FontAwesomeIcons.message,
                      color: Colors.grey,
                      size: widget.constraints.maxWidth < 768 ? 20 : 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.post.attributes.commentsCount,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: widget.constraints.maxWidth < 768 ? 12 : 17,
                      ),
                    ),
                    // const SizedBox(width: 10),
                    // Container(
                    //   height: 25,
                    //   width: 1,
                    //   color: Colors.grey,
                    // ),
                    // const SizedBox(width: 10),
                    // Icon(
                    //   FontAwesomeIcons.shareNodes,
                    //   color: Colors.grey,
                    //   size: 20,
                    // ),
                    // const SizedBox(width: 10),
                    // Text(
                    //   '0',
                    //   style: TextStyle(color: Colors.grey),
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
