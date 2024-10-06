import 'package:duapa/models/user_queries_class.dart';
import 'package:duapa/views/extention_officer/query_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../services/constants.dart';

class QueryCard extends StatelessWidget {
  const QueryCard({super.key, required this.query});

  final Query query;

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
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(() => QueryResponseScreen(query: query));
                      },
                      style: const ButtonStyle(
                        foregroundColor:
                            WidgetStatePropertyAll(kLightGreyColor),
                      ),
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                    IconButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(kErrorColor),
                      ),
                      icon: const Icon(Iconsax.trash),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(query.description),
            const SizedBox(height: 8),
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
          ],
        ),
      ),
    );
  }
}
