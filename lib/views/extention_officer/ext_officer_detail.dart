import 'package:duapa/models/extension_officer_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/views/extention_officer/service_query_form.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExtOfficerDetailScreen extends StatefulWidget {
  const ExtOfficerDetailScreen({super.key, required this.officer});
  final Officer officer;

  @override
  State<ExtOfficerDetailScreen> createState() => _ExtOfficerDetailScreenState();
}

class _ExtOfficerDetailScreenState extends State<ExtOfficerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: TextButton(
        onPressed: () {
          Get.to(
            () => ServiceQueryForm(officerID: widget.officer.userID.toString()),
          );
        },
        style: const ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
        ),
        child: const Text(
          'Send Query',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      appBar: appBar(context: context, title: 'Profile'),
      body: LayoutBuilder(builder: (context, constraints) {
        return Wrap(
          children: [
            Stack(
              children: [
                ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: FadeInImage.assetNetwork(
                    height: constraints.maxWidth < 768 ? 230 : 450,
                    width: constraints.maxWidth,
                    placeholder: 'assets/img/placeholder_landscape.png',
                    image:
                        'https://img.freepik.com/free-photo/lifestyle-people-office_23-2149173738.jpg?w=2000&t=st=1695776962~exp=1695777562~hmac=821b512f5c8f26a9830b1f28dd9328c6e87471d10fb409adaa94c8e452b8be91',
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
                  height: 230,
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
                        const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              maxRadius: 40,
                              backgroundImage:
                                  NetworkImage(widget.officer.profilePicture),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              widget.officer.fullname,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.officer.phoneNumber,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Country, Region, City', // '${widget.officer.country}, ${widget.officer.region}, ${widget.officer.city}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 20),
                        width: MediaQuery.of(context).size.width / 2,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 50),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '1245',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Posts',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 45),
                                Column(
                                  children: [
                                    Text(
                                      '445',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Activities',
                                      style: TextStyle(
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Services',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.officer.services,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
