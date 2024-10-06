class TrackingDetails {
  final String svg;
  final String title;
  final String text;
  final bool isFirst;
  final bool isLast;

  TrackingDetails({
    required this.svg,
    required this.title,
    required this.text,
    required this.isFirst,
    required this.isLast,
  });

  static List<TrackingDetails> trackingList = [
    TrackingDetails(
      svg: 'assets/svg/place_order.svg',
      title: 'Order Placed',
      text: 'We have received your order.',
      isFirst: true,
      isLast: false,
    ),
    TrackingDetails(
      svg: 'assets/svg/order_confirmed.svg',
      title: 'Order Confirmed',
      text: 'We have confirmed your order.',
      isFirst: false,
      isLast: false,
    ),
    TrackingDetails(
      svg: 'assets/svg/order_processed.svg',
      title: 'Processing Order',
      text: 'Your order is being processed.',
      isFirst: false,
      isLast: false,
    ),
    TrackingDetails(
      svg: 'assets/svg/order_shipped.svg',
      title: 'Order Shipped',
      text: 'Your order is on the way.',
      isFirst: false,
      isLast: false,
    ),
    TrackingDetails(
      svg: 'assets/svg/order_arrived.svg',
      title: 'Order Arrived',
      text: 'Your order has arrived.',
      isFirst: false,
      isLast: true,
    ),
  ];
}
