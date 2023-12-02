import 'package:flutter/material.dart';
import 'package:skeleton_app/core/widgets/spacers.dart';
import 'package:skeleton_app/features/home/data/models/order.dart';

class OrderItemWidget extends StatelessWidget {
  final Order order;
  const OrderItemWidget({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inkWell = InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _onProductTap,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(order.clientId),
                      hSpace(),
                      Text('€${order.total}'),
                    ],
                  ),
                  vSpace(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: order.orderlines.length,
                    itemBuilder: (context, index) {
                      return Text(order.orderlines[index].productName);
                    },
                  ),
                  vSpace(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return inkWell;
  }

  void _onProductTap() {}
}
