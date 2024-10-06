// import 'package:duapa/views/widgets/app_bar.dart';
// import 'package:flutter/material.dart';

// import '../../models/product_details_class.dart';

// class ProductDriverScreen extends StatefulWidget {
//   const ProductDriverScreen({Key? key, required this.driver}) : super(key: key);
//   final Within driver;

//   @override
//   State<ProductDriverScreen> createState() => _ProductDriverScreenState();
// }

// class _ProductDriverScreenState extends State<ProductDriverScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(context: context, title: 'Profile'),
//       body: Wrap(
//         children: [
//           Stack(
//             children: [
//               Container(
//                 height: 230,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     fit: BoxFit.fill,
//                     image: AssetImage(
//                         'assets/img/brian-stalter-arotxe540N4-unsplash.jpg'),
//                   ),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 230,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       offset: Offset.fromDirection(0.5),
//                       blurRadius: 10,
//                       color: Colors.black38,
//                     ),
//                   ],
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30),
//                   ),
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     stops: const [0.1, 0.9],
//                     colors: [
//                       Colors.white.withOpacity(0.0),
//                       const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
//                     ],
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width / 2,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 20),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CircleAvatar(
//                             maxRadius: 40,
//                             backgroundImage:
//                                 NetworkImage('${widget.driver.profilePicture}'),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Text(
//                             '${widget.driver.firstName} ${widget.driver.surname}',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17,
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             '${widget.driver.phoneNumber}',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             '${widget.driver.country}, ${widget.driver.region}, ${widget.driver.city}',
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width / 2,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 5, vertical: 20),
//                       child: const Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 50),
//                           Row(
//                             children: [
//                               Column(
//                                 children: [
//                                   Text(
//                                     '1245',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Posts',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(width: 45),
//                               Column(
//                                 children: [
//                                   Text(
//                                     '445',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Activities',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'BIO',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 widget.driver.dob == null
//                     ? Text(
//                         '@${widget.driver.firstName} has not updated his/her bio yet.')
//                     : Text('${widget.driver}'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
