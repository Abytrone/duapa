import 'dart:io';

import 'package:duapa/controllers/orders_controller.dart';
import 'package:duapa/views/account/orders/widgets/order_item_card.dart';
import 'package:duapa/views/widgets/empty.dart';
import 'package:duapa/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/constants.dart';
import '../../../services/theme.dart';
import '../../widgets/app_bar.dart';
import 'order_detail.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({
    super.key,
    required this.tabIndex,
    required this.isCheckout,
  });
  final int tabIndex;
  final bool isCheckout;

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.animateTo(widget.tabIndex);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final OrdersController ordersController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: appBar(
            context: context,
            title: 'My Orders',
            leading: IconButton(
              icon: Icon(
                  Platform.isAndroid ? Icons.arrow_back : Icons.chevron_left),
              onPressed: () {
                if (widget.isCheckout) {
                  // Pop back to cart screen if from checkout
                  Navigator.popUntil(context, (route) => route.isFirst);
                } else {
                  // Pop back to account screen if from account
                  Navigator.pop(context);
                }
              },
            ),
          ),
          backgroundColor:
              Theme.of(context).brightness == lightThemeData(context).brightness
                  ? kContentColorDarkTheme
                  : kContentColorLightTheme,
          body: SizedBox(
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  dividerHeight: 1,
                  dividerColor: Colors.black12,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  labelColor: Colors.white,
                  isScrollable: true,
                  indicator: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        'Paid',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: constraints.maxWidth < 768 ? 12 : 17,
                          fontFamily: 'Gotik',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        'Pending',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: constraints.maxWidth < 768 ? 12 : 17,
                          fontFamily: 'Gotik',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        'Completed',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: constraints.maxWidth < 768 ? 12 : 17,
                          fontFamily: 'Gotik',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        'Cancelled',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: constraints.maxWidth < 768 ? 12 : 17,
                          fontFamily: 'Gotik',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SizedBox(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // ---------------PAID-ORDERS---------------
                        FutureBuilder(
                          future: ordersController.getUserOrders(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const AbyLoading();
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data != null) {
                                final paid =
                                    ordersController.paidOrders.value.value;
                                return RefreshIndicator(
                                  onRefresh: () {
                                    return ordersController.getUserOrders();
                                  },
                                  child: paid == null
                                      ? const EmptyWidget(text: 'Empty List')
                                      : ListView.builder(
                                          itemCount: paid.data!.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () async {
                                                await Get.to(
                                                    () => OrderDetailScreen(
                                                          orderid: paid
                                                              .data![index].id,
                                                          paymentStatus: paid
                                                              .data![index]
                                                              .status,
                                                        ));
                                                setState(() {});
                                              },
                                              child: OrderItemCard(
                                                constraints: constraints,
                                                order: paid.data![index],
                                              ),
                                            );
                                          },
                                        ),
                                );
                              } else {
                                return const Center(child: Text('Empty'));
                              }
                            } else {
                              return const Center(
                                child: Text('Error loading data!'),
                              );
                            }
                          },
                        ),

                        // ---------------PENDING-ORDERS---------------
                        FutureBuilder(
                          future: ordersController.getUserOrders(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const AbyLoading();
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data != null) {
                                final pending =
                                    ordersController.pendingOrders.value.value;
                                return RefreshIndicator(
                                  onRefresh: () {
                                    return ordersController.getUserOrders();
                                  },
                                  child: pending == null
                                      ? const EmptyWidget(text: 'Empty List')
                                      : ListView.builder(
                                          itemCount: pending.data!.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () async {
                                                await Get.to(
                                                    () => OrderDetailScreen(
                                                          orderid: pending
                                                              .data![index].id,
                                                          paymentStatus: pending
                                                              .data![index]
                                                              .status,
                                                        ));
                                                setState(() {});
                                              },
                                              child: OrderItemCard(
                                                constraints: constraints,
                                                order: pending.data![index],
                                              ),
                                            );
                                          },
                                        ),
                                );
                              } else {
                                return const Center(child: Text('Empty'));
                              }
                            } else {
                              return const Center(
                                child: Text('Error loading data!'),
                              );
                            }
                          },
                        ),
                        // ---------------COMPLETED-ORDERS---------------
                        FutureBuilder(
                          future: ordersController.getUserOrders(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const AbyLoading();
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data != null) {
                                final completed = ordersController
                                    .completedOrders.value.value;
                                return RefreshIndicator(
                                  onRefresh: () {
                                    return ordersController.getUserOrders();
                                  },
                                  child: completed == null
                                      ? const EmptyWidget(text: 'Empty List')
                                      : ListView.builder(
                                          itemCount: completed.data!.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () async {
                                                await Get.to(
                                                    () => OrderDetailScreen(
                                                          orderid: completed
                                                              .data![index].id,
                                                          paymentStatus:
                                                              completed
                                                                  .data![index]
                                                                  .status,
                                                        ));
                                                setState(() {});
                                              },
                                              child: OrderItemCard(
                                                constraints: constraints,
                                                order: completed.data![index],
                                              ),
                                            );
                                          },
                                        ),
                                );
                              } else {
                                return const Center(child: Text('Empty'));
                              }
                            } else {
                              return const Center(
                                  child: Text('Error loading data!'));
                            }
                          },
                        ),
                        // ---------------CANCELLED-ORDERS---------------
                        FutureBuilder(
                          future: ordersController.getUserOrders(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const AbyLoading();
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data != null) {
                                final cancelled = ordersController
                                    .cancelledOrders.value.value;
                                return RefreshIndicator(
                                  onRefresh: () {
                                    return ordersController.getUserOrders();
                                  },
                                  child: cancelled == null
                                      ? const EmptyWidget(text: 'Empty List')
                                      : cancelled.data == null
                                          ? const EmptyWidget(
                                              text: 'Empty List')
                                          : ListView.builder(
                                              itemCount: cancelled.data!.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () async {
                                                    await Get.to(() =>
                                                        OrderDetailScreen(
                                                          orderid: cancelled
                                                              .data![index].id,
                                                          paymentStatus:
                                                              cancelled
                                                                  .data![index]
                                                                  .status,
                                                        ));
                                                    setState(() {});
                                                  },
                                                  child: OrderItemCard(
                                                    constraints: constraints,
                                                    order:
                                                        cancelled.data![index],
                                                  ),
                                                );
                                              },
                                            ),
                                );
                              } else {
                                return const Center(child: Text('Empty'));
                              }
                            } else {
                              return const Center(
                                child: Text('Error loading data!'),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
