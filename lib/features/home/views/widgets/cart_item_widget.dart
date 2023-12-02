import 'package:flutter/material.dart';
import 'package:skeleton_app/core/widgets/spacers.dart';
import 'package:skeleton_app/features/home/data/models/order_line.dart';

class CartItemWidget extends StatelessWidget {
  final OrderLine orderline;
  const CartItemWidget({Key? key, required this.orderline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inkWell = InkWell(
      child: InkWell(
        onTap: _onProductTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(orderline.productName),
                  hSpace(),
                  Text('€${orderline.productPrice}'),
                  const Spacer(),
                  Text('${orderline.quantity}Piece'),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Total ${orderline.total}€',
                ),
              ),
              vSpace(),
            ],
          ),
        ),
      ),
    );
    return inkWell;
  }

  void _onProductTap() {}
}
