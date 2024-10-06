import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/service_providers_stores.dart';
import '../../../services/constants.dart';
import '../store_products.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({super.key, required this.store, required this.constraints});
  final Store store;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return StoreProductsScreen(
                  productId: store.userID.toString(),
                  storeName: store.companyName,
                  storeImage: store.profilePicture,
                );
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(5, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'TitleTag${store.userID}',
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: FadeInImage.assetNetwork(
                          height: constraints.maxWidth < 768 ? 70 : 130,
                          width: constraints.maxWidth < 768 ? 70 : 130,
                          placeholderCacheHeight:
                              constraints.maxWidth < 768 ? 70 : 130,
                          placeholderCacheWidth:
                              constraints.maxWidth < 768 ? 70 : 130,
                          placeholder: 'assets/img/placeholder.png',
                          image: store.profilePicture,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 250,
                            child: Text(
                              store.companyName,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: constraints.maxWidth < 768 ? 17 : 24,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Text(
                            store.email,
                            style: TextStyle(
                              fontSize: constraints.maxWidth < 768 ? 14 : 17,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: kPrimaryColor.withOpacity(0.2),
                            ),
                            child: Text(
                              store.phoneNumber,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: constraints.maxWidth < 768 ? 14 : 20,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Icon(
                            FontAwesomeIcons.heart,
                            size: constraints.maxWidth < 768 ? 24 : 27,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  store
                      .services, //this is just a sample of text am experimenting with. Okay so far I like whats happening with my UI, I think it\'s great.',
                  style: TextStyle(
                    fontSize: constraints.maxWidth < 768 ? 14 : 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
