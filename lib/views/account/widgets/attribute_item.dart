import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/constants.dart';

class AttributeItem extends StatelessWidget {
  const AttributeItem({
    super.key,
    required this.image,
    required this.name,
    required this.url,
  });

  final String image;
  final String name;
  final String url;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: kPrimaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            // Image.asset(
            //   image,
            //   width: 70,
            // ),
            FadeInImage.assetNetwork(
              placeholder: 'assets/img/placeholder.png',
              image: image,
              width: 70,
              imageErrorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Text('NO'),
                );
              },
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Name: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(name),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'URL: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Html(
                      data: url.toString(),
                      shrinkWrap: true,
                      // style: {
                      //   'a': Style(
                      //     maxLines: 2,
                      //     lineHeight: LineHeight.number(2),
                      //     width: Width.auto(),
                      //     textOverflow: TextOverflow.ellipsis,
                      //   )
                      // },
                      onLinkTap: (url, attributes, element) async {
                        final uri = Uri.parse(url!);
                        await launchUrl(uri);
                        // Get.to(() => AttributesWebView(url: url!));
                      },
                    ),
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
