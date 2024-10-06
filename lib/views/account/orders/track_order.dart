import 'package:duapa/controllers/orders_controller.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../services/constants.dart';
import '../../../services/theme.dart';
import '../../widgets/app_bar.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key, required this.orderId});
  final String orderId;

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  final OrdersController ordersController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Track Order'),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: FutureBuilder(
        future: ordersController.getOrderTracking(orderId: widget.orderId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              return Column(
                children: [
                  RefreshIndicator(
                    onRefresh: () {
                      return ordersController.getOrderTracking(
                          orderId: widget.orderId);
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data!.data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.1,
                          isFirst: snapshot.data!.data[index].isFirst == 1,
                          isLast: snapshot.data!.data[index].isLast == 1,
                          beforeLineStyle: const LineStyle(
                            thickness: 2,
                            color: kPrimaryColor,
                          ),
                          indicatorStyle: const IndicatorStyle(
                            width: 15,
                            color: kPrimaryColor,
                            padding: EdgeInsets.only(right: 10),
                          ),
                          endChild: TrackItem(
                            svg: snapshot.data!.data[index].svg,
                            title: snapshot.data!.data[index].title,
                            text: snapshot.data!.data[index].message,
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: PrimaryButton(
                      text: 'Confirm Arrival',
                      onPressed: () {},
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: Text('Empty'));
            }
          } else {
            return const Center(child: Text('Error loading data'));
          }
        },
      ),
      // Obx(
      //   () =>
      // ordersController.isLoading.isTrue
      //     ? const Center(child: CircularProgressIndicator())
      //     : ordersController.orderTracking.value.value == null
      //         ? const Center(
      //             child: Text('Empty'),
      //           )
      //         :
      // ),
    );
  }
}

class TrackItem extends StatelessWidget {
  const TrackItem({
    super.key,
    required this.svg,
    required this.title,
    required this.text,
  });
  final String svg;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Opacity(
            opacity: 1, // disabled ? 0.5 : 1,
            child: SvgPicture.network(svg, width: 30),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF636564),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF636564),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
