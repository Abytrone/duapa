import 'package:duapa/models/farms_class.dart';
import 'package:duapa/views/account/farm/farm_location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'farm_detail.dart';

class FarmCard extends StatelessWidget {
  const FarmCard({super.key, required this.farm, required this.constraints});
  final Farms farm;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: InkWell(
        onTap: () {
          Get.to(() => FarmLocationScreen(
                latitude: double.parse(farm.latitude),
                longitude: double.parse(farm.longitude),
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 10.0,
                color: Colors.black12,
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      FadeInImage.assetNetwork(
                        width: double.infinity,
                        height: 200,
                        placeholderCacheHeight: 200,
                        placeholder: 'assets/img/placeholder.png',
                        image: farm.farmPicture,
                        fit: BoxFit.cover,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(15),
                      //   child: Container(
                      //     padding: const EdgeInsets.all(10),
                      //     width: 150,
                      //     decoration: const BoxDecoration(
                      //       color: Colors.green,
                      //       borderRadius: BorderRadius.all(Radius.circular(10)),
                      //     ),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           'Farm worth',
                      //           style: TextStyle(
                      //             fontSize: constraints.maxWidth < 768 ? 12 : 17,
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //         Row(
                      //           children: [
                      //             const Icon(
                      //               Iconsax.money_3,
                      //               color: Colors.white,
                      //             ),
                      //             const SizedBox(width: 10),
                      //             Text(
                      //               farm.farmWorth,
                      //               style: TextStyle(
                      //                 fontSize:
                      //                     constraints.maxWidth < 768 ? 20 : 30,
                      //                 color: Colors.white,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //             // const Text(
                      //             //   ' usdt',
                      //             //   style: TextStyle(
                      //             //     color: Colors.white,
                      //             //   ),
                      //             // ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: constraints.maxWidth < 768 ? 10 : 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FarmDetail(
                    icon: const Icon(
                      Iconsax.size,
                      color: Colors.blue,
                    ),
                    color: Colors.blue,
                    title: ' Number of Acres ',
                    data: farm.numberOfAcres,
                    constraints: constraints,
                  ),
                  FarmDetail(
                    icon: const Icon(
                      Iconsax.size5,
                      color: Colors.red,
                    ),
                    color: Colors.red,
                    title: ' Number of Acres Produced ',
                    data: farm.numberOfAcresProduced,
                    constraints: constraints,
                  ),
                  FarmDetail(
                    icon: const Icon(
                      Iconsax.location,
                      color: Colors.orange,
                    ),
                    color: Colors.orange,
                    title: ' Farm Location ',
                    data: farm.farmLocation,
                    constraints: constraints,
                  ),
                  FarmDetail(
                    icon: const Icon(
                      Iconsax.crop,
                      color: Colors.green,
                    ),
                    color: Colors.green,
                    title: ' Crop ',
                    data: farm.productsGrown,
                    constraints: constraints,
                  ),
                  FarmDetail(
                    icon: const Icon(
                      Iconsax.money,
                      color: Colors.indigo,
                    ),
                    color: Colors.indigo,
                    title: ' Farm Worth ',
                    data: farm.farmWorth,
                    constraints: constraints,
                  ),
                  farm.description == 'null'
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          child: Text(
                            farm.description,
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ),

                  // Expanded(
                  //   child: ListView.builder(
                  //       itemCount: 5,
                  //       scrollDirection: Axis.horizontal,
                  //       shrinkWrap: true,
                  //       itemBuilder: (context, index) {
                  //         return Row(
                  //           children: [
                  //             Text('data'),
                  //           ],
                  //         );
                  //       }),
                  // ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
