import 'package:duapa/controllers/product_controller.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:duapa/views/widgets/empty.dart';
import 'package:duapa/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key, required this.sellerId});
  final int sellerId;

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  final ProductsController productsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Seller Profile'),
      body: LayoutBuilder(builder: (context, constraints) {
        return FutureBuilder(
            future:
                productsController.getUserById(id: widget.sellerId.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const AbyLoading();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  return Wrap(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            child: FadeInImage.assetNetwork(
                              height: constraints.maxWidth < 768 ? 230 : 450,
                              width: constraints.maxWidth,
                              placeholder:
                                  'assets/img/placeholder_landscape.png',
                              image:
                                  'https://img.freepik.com/free-photo/shallow-focus-woman-with-facemask-holding-pos-machine-market_181624-39373.jpg?w=2000&t=st=1697191861~exp=1697192461~hmac=23827809bee9e576d63aed4e798a24fa73bed476431d5134421252982ed3d916',
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Image.asset(
                                    'assets/img/placeholder_landscape.png',
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            height: constraints.maxWidth < 768 ? 230 : 450,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset.fromDirection(0.5),
                                  blurRadius: 10,
                                  color: Colors.black38,
                                ),
                              ],
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.1, 0.9],
                                colors: [
                                  Colors.white.withOpacity(0.0),
                                  const Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.5),
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      snapshot.data!.user.profilePicture == null
                                          ? CircleAvatar(
                                              maxRadius:
                                                  constraints.maxWidth < 768
                                                      ? 40
                                                      : 120,
                                              backgroundImage: const AssetImage(
                                                  'assets/icon/user.png'),
                                            )
                                          : CircleAvatar(
                                              maxRadius:
                                                  constraints.maxWidth < 768
                                                      ? 40
                                                      : 120,
                                              backgroundImage: NetworkImage(
                                                snapshot
                                                    .data!.user.profilePicture!,
                                              ),
                                            ),
                                      const SizedBox(height: 20),
                                      Text(
                                        '${snapshot.data!.user.firstName} ${snapshot.data!.user.surname}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: constraints.maxWidth < 768
                                              ? 17
                                              : 25,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        snapshot.data!.user.phoneNumber!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: constraints.maxWidth < 768
                                              ? 12
                                              : 24,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${snapshot.data!.user.country}, ${snapshot.data!.user.region}, ${snapshot.data!.user.city}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: constraints.maxWidth < 768
                                              ? 12
                                              : 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 20),
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: constraints.maxWidth < 768
                                              ? 50
                                              : 100),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                '1245',
                                                style: TextStyle(
                                                  fontSize:
                                                      constraints.maxWidth < 768
                                                          ? 12
                                                          : 24,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Posts',
                                                style: TextStyle(
                                                  fontSize:
                                                      constraints.maxWidth < 768
                                                          ? 12
                                                          : 24,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 45),
                                          Column(
                                            children: [
                                              Text(
                                                '445',
                                                style: TextStyle(
                                                  fontSize:
                                                      constraints.maxWidth < 768
                                                          ? 12
                                                          : 24,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Activities',
                                                style: TextStyle(
                                                  fontSize:
                                                      constraints.maxWidth < 768
                                                          ? 12
                                                          : 24,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Services',
                              style: TextStyle(
                                fontSize: constraints.maxWidth < 768 ? 12 : 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshot.data!.user.services!,
                              style: TextStyle(
                                fontSize: constraints.maxWidth < 768 ? 12 : 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const EmptyWidget(
                      text: 'User data not found,\nPlease try again.');
                }
              } else {
                return const EmptyWidget(text: 'Empty');
              }
            });
      }),
    );
  }
}
