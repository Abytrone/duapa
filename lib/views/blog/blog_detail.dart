import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:duapa/controllers/posts_controller.dart';
import 'package:duapa/models/posts_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/blog_services.dart';

class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({
    super.key,
    required this.post,
    required this.index,
    required this.keyWords,
  });
  final PostData post;
  final int index;
  final List keyWords;
  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  final TextEditingController comment = TextEditingController();
  final BlogServices blogServices = BlogServices();
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final PostsController _postsController = Get.put(PostsController());
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      _postsController.fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Blog Page'),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: LayoutBuilder(builder: (context, constraints) {
        return Obx(
          () => Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/img/profile.jpg'),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _postsController.postsList[widget.index]
                                      .attributes.postedBy,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        constraints.maxWidth < 768 ? 12 : 17,
                                  ),
                                ),
                                Text(
                                  'Tamale, Ghana',
                                  style: TextStyle(
                                    fontSize:
                                        constraints.maxWidth < 768 ? 10 : 14,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  _postsController.postsList[widget.index]
                                      .attributes.createdAt,
                                  style: TextStyle(
                                    fontSize:
                                        constraints.maxWidth < 768 ? 12 : 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: constraints.maxWidth < 768 ? 50 : 70,
                        child: ListView.separated(
                          itemCount: widget.keyWords.length,
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Text(
                                  widget.keyWords[index],
                                  style: TextStyle(
                                    fontSize:
                                        constraints.maxWidth < 768 ? 10 : 14,
                                    fontWeight: FontWeight.bold,
                                    color: kSecondaryColor,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CachedNetworkImage(
                          imageUrl: widget.post.attributes.picture,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: 350,
                              width: 500,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    constraints.maxWidth < 768 ? 15 : 25)),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) {
                            return Shimmer.fromColors(
                              direction: ShimmerDirection.btt,
                              baseColor: Colors.grey.shade50,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 350,
                                width: 500,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(constraints.maxWidth < 768
                                          ? 15
                                          : 25)),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(url),
                                  ),
                                ),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                      Html(
                        data: widget.post.attributes.description,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 5, bottom: 15),
                      //   child: Text(
                      //     parse(widget.post.attributes.description).toString(),
                      //     textAlign: TextAlign.left,
                      //     style: TextStyle(
                      //       fontSize: constraints.maxWidth < 768 ? 15 : 20,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                      Row(
                        children: [
                          LikeButton(
                            size: constraints.maxWidth < 768 ? 20 : 30,
                            onTap: (isLiked) {
                              _postsController.fetchPosts();
                              return blogServices.onLikeButtonTapped(
                                isLiked,
                                _postsController.postsList[widget.index].id,
                                context,
                              );
                            },
                            circleColor: const CircleColor(
                                start: Color(0xff00ddff),
                                end: Color(0xff0099cc)),
                            bubblesColor: const BubblesColor(
                              dotPrimaryColor: Color(0xff33b5e5),
                              dotSecondaryColor: Color(0xff0099cc),
                            ),
                            likeBuilder: (bool isLiked) {
                              return _postsController.postsList[widget.index]
                                          .attributes.hasLiked ==
                                      '0'
                                  ? Icon(
                                      isLiked
                                          ? FontAwesomeIcons.solidHeart
                                          : FontAwesomeIcons.heart,
                                      color: isLiked ? Colors.red : Colors.grey,
                                      size:
                                          constraints.maxWidth < 768 ? 20 : 30,
                                    )
                                  : Icon(
                                      isLiked
                                          ? FontAwesomeIcons.heart
                                          : FontAwesomeIcons.solidHeart,
                                      color: isLiked ? Colors.grey : Colors.red,
                                      size:
                                          constraints.maxWidth < 768 ? 20 : 30,
                                    );
                            },
                          ),
                          Text(
                            _postsController
                                .postsList[widget.index].attributes.likes,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: constraints.maxWidth < 768 ? 12 : 17,
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
                            size: constraints.maxWidth < 768 ? 20 : 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            _postsController.postsList[widget.index].attributes
                                .commentsCount,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: constraints.maxWidth < 768 ? 12 : 17,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: 3,
                          width: 500,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      _postsController.postsList[widget.index].attributes
                                  .comments[0].comment ==
                              'No comment'
                          ? Center(
                              child: Column(
                                children: [
                                  const Icon(
                                    Iconsax.message_remove,
                                    size: 50,
                                    color: kLightGreyColor,
                                  ),
                                  Text(
                                    'No Comments',
                                    style: TextStyle(
                                        fontSize: constraints.maxWidth < 768
                                            ? 12
                                            : 17),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: _postsController
                                  .postsList[widget.index]
                                  .attributes
                                  .comments
                                  .length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor.withOpacity(0.1),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    'assets/img/profile.jpg'),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                _postsController
                                                    .postsList[widget.index]
                                                    .attributes
                                                    .comments[index]
                                                    .user![0]
                                                    .username,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 60),
                                          child: Text(
                                            '${_postsController.postsList[widget.index].attributes.comments[index].comment}',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10, top: 5, bottom: 5),
                                              child: Text(
                                                '${_postsController.postsList[widget.index].attributes.comments[index].postedAt}',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black38,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: constraints.maxWidth < 768 ? 40 : 80,
                    decoration: const BoxDecoration(
                        // color: Colors.grey,
                        ),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 50,
                        controller: comment,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return null;
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.sentences,
                        scrollPadding: const EdgeInsets.all(5),
                        decoration: InputDecoration(
                          hintText: 'Type something',
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: constraints.maxWidth < 768 ? 12 : 17,
                          ),
                          suffixIcon: IconButton(
                            color: kSecondaryColor,
                            padding: const EdgeInsets.all(5),
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: kPrimaryColor,
                              ),
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (comment.text != '') {
                                if (formKey!.currentState!.validate()) {
                                  blogServices.comment(
                                      widget.post.id, comment.text, context);
                                  _postsController.fetchPosts();
                                  comment.clear();
                                }
                              }
                            },
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          fillColor: Colors.grey.withOpacity(0.2),
                          filled: true,
                          isCollapsed: true,
                          isDense: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
