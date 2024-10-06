import 'package:duapa/models/support_ticket_class.dart';
import 'package:duapa/services/support_ticket_services.dart';
import 'package:duapa/views/account/support/support.dart';
import 'package:duapa/views/account/support/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../services/constants.dart';
import '../../../services/theme.dart';

class SupportTicketsScreen extends StatefulWidget {
  const SupportTicketsScreen({super.key});

  @override
  State<SupportTicketsScreen> createState() => _SupportTicketsScreenState();
}

class _SupportTicketsScreenState extends State<SupportTicketsScreen> {
  final SupportTicketServices supportTicketServices = SupportTicketServices();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) {
        Get.back();
        Get.back();
        Get.back();
        return;
      },
      child: LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Support Center',
              style: TextStyle(
                fontSize: constraints.maxWidth < 768 ? 12 : 17,
                color: Theme.of(context).brightness ==
                        lightThemeData(context).brightness
                    ? kContentColorLightTheme
                    : kContentColorDarkTheme,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(() => const SupportCenter());
                },
                icon: const Icon(
                  Iconsax.add_square,
                ),
              ),
            ],
            centerTitle: true,
            backgroundColor: Theme.of(context).brightness ==
                    lightThemeData(context).brightness
                ? kContentColorDarkTheme
                : kContentColorLightTheme,
            iconTheme: IconThemeData(
              color: Theme.of(context).brightness ==
                      lightThemeData(context).brightness
                  ? kContentColorLightTheme
                  : kContentColorDarkTheme,
            ),
          ),
          backgroundColor:
              Theme.of(context).brightness == lightThemeData(context).brightness
                  ? kContentColorDarkTheme
                  : kContentColorLightTheme,
          body: Center(
            child: FutureBuilder<List<SupportTicket>?>(
              future: supportTicketServices.getTickets(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error getting data!'));
                  } else if (snapshot.data!.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Center(
                        child: Text(
                          'You currently do not have any support ticket responses.\nYou can submit a ticket by tapping on the + button on the top right.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: constraints.maxWidth < 768 ? 12 : 17),
                        ),
                      ),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () {
                        return supportTicketServices.getTickets();
                      },
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final date = DateFormat.yMMMMd()
                              .format(snapshot.data![index].createdAt);
                          return InkWell(
                            onTap: () {
                              Get.generalDialog(
                                pageBuilder: (_, __, ___) {
                                  return DialogWidget(
                                    supportTicket: snapshot.data![index],
                                    constraints: constraints,
                                  );
                                },
                                transitionDuration:
                                    const Duration(milliseconds: 700),
                                transitionBuilder: (_, anim, __, child) {
                                  Tween<Offset> tween;
                                  if (anim.status == AnimationStatus.reverse) {
                                    tween = Tween(
                                        begin: const Offset(-1, 0),
                                        end: Offset.zero);
                                  } else {
                                    tween = Tween(
                                        begin: const Offset(1, 0),
                                        end: Offset.zero);
                                  }

                                  return SlideTransition(
                                    position: tween.animate(anim),
                                    child: FadeTransition(
                                      opacity: anim,
                                      child: child,
                                    ),
                                  );
                                },
                                barrierDismissible: true,
                                barrierLabel: 'Dialog',
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index].topic,
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize:
                                                  constraints.maxWidth < 768
                                                      ? 17
                                                      : 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: constraints.maxWidth < 768
                                                ? 250
                                                : 750,
                                            child: Text(
                                              snapshot.data![index].concern,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize:
                                                    constraints.maxWidth < 768
                                                        ? 14
                                                        : 20,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              // Container(
                                              //   height: 25,
                                              //   padding: const EdgeInsets.symmetric(
                                              //       horizontal: 10),
                                              //   decoration: BoxDecoration(
                                              //     color: kWarninngColor
                                              //         .withOpacity(0.3),
                                              //     borderRadius:
                                              //         const BorderRadius.all(
                                              //             Radius.circular(20)),
                                              //   ),
                                              //   child: Center(
                                              //     child: Text(
                                              //       snapshot.data![index].status,
                                              //       style: const TextStyle(
                                              //         fontWeight: FontWeight.w600,
                                              //         color: kWarninngColor,
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                              Text(
                                                snapshot.data![index].status,
                                                style: TextStyle(
                                                  color: snapshot.data![index]
                                                              .status ==
                                                          'pending'
                                                      ? Colors.orangeAccent
                                                      : Colors.green,
                                                  fontSize:
                                                      constraints.maxWidth < 768
                                                          ? 12
                                                          : 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                ' • $date',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize:
                                                      constraints.maxWidth < 768
                                                          ? 12
                                                          : 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        FontAwesomeIcons.angleRight,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  // case ConnectionState.waiting:
                  //   return const Center(child: CircularProgressIndicator());
                  // case ConnectionState.none:
                  //   return const Center(
                  //       child: Text('No data on found at the moment'));
                  // default:
                  //   return const Center(child: Text('wat the heck this'));
                } else {
                  return const Center(
                    child: Text('Error occured please try again'),
                  );
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
