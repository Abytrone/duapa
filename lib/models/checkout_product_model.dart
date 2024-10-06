class CheckoutProductModel {
  final String productId;
  final String picture;
  final String name;
  final String price;
  final String quantity;
  final String shippingCost;
  final String currencyCode;

  CheckoutProductModel({
    required this.productId,
    required this.picture,
    required this.name,
    required this.price,
    required this.quantity,
    required this.shippingCost,
    required this.currencyCode,
  });
}
