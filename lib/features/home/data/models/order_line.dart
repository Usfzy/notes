class OrderLine {
  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final double productPrice;

  double get total => productPrice * quantity;

  const OrderLine({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.productPrice,
  });
}
