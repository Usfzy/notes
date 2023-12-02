import 'package:skeleton_app/features/home/data/models/order_line.dart';

class Order {
  final String id;
  final String clientId;
  final String date;
  final double total;
  final List<OrderLine> orderlines;

  const Order({
    required this.id,
    required this.clientId,
    required this.date,
    required this.total,
    required this.orderlines,
  });
}
