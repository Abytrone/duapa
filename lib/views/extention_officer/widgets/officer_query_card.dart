import 'package:duapa/views/extention_officer/officer_reply_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/officer_query_class.dart';
import '../../../services/constants.dart';

class OfficerQueryCard extends StatelessWidget {
  const OfficerQueryCard({super.key, required this.query});

  final OfficerQuery query;

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat.yMMMMd();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(Get.size.width < 768 ? 8 : 16),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: Get.size.width < 768 ? 5.0 : 15,
              color: Colors.black12.withOpacity(0.1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      query.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      query.extensionOfficerName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: kLightGreyColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // IconButton(
                //   onPressed: () {},
                //   style: const ButtonStyle(
                //     foregroundColor: MaterialStatePropertyAll(kErrorColor),
                //   ),
                //   icon: const Icon(Iconsax.trash),
                // ),
              ],
            ),
            const SizedBox(height: 8),
            Text(query.description),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: query.responseDate == null
                        ? 'June 25, 2023'
                        : dateFormat.format(query.responseDate!),
                    style: const TextStyle(
                      fontSize: 12,
                      color: kLightGreyColor,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    children: [
                      const TextSpan(
                        text: ' | ',
                        style: TextStyle(
                          color: kLightGreyColor,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      query.response == 'N/A'
                          ? const TextSpan(
                              text: 'Awaiting Response',
                              style: TextStyle(
                                color: kWarninngColor,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            )
                          : const TextSpan(
                              text: 'Responded',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                    ],
                  ),
                ),
                query.response == 'N/A'
                    ? IconButton(
                        onPressed: () {
                          Get.to(() => OfficerReplyForm(query: query));
                        },
                        style: const ButtonStyle(
                          foregroundColor:
                              WidgetStatePropertyAll(kPrimaryColor),
                        ),
                        icon: const Icon(Icons.reply_rounded),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
