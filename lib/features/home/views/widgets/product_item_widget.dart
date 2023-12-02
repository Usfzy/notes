import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_app/core/widgets/custom_snackbar.dart';
import 'package:skeleton_app/core/widgets/spacers.dart';
import 'package:skeleton_app/features/home/controller/orders_controller.dart';
import 'package:skeleton_app/features/home/data/models/product.dart';

class ProductItemWidget extends ConsumerStatefulWidget {
  final Product product;
  const ProductItemWidget({Key? key, required this.product}) : super(key: key);

  @override
  ConsumerState<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends ConsumerState<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    var inkWell = InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => _onProductTap(widget.product),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.product.title),
                      hSpace(),
                      Text('€${widget.product.price}'),
                      const Spacer(),
                      Text('${widget.product.stockQty}Pieces'),
                    ],
                  ),
                  vSpace(),
                  Text(widget.product.description),
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

  void _onProductTap(Product product) {
    ref.read(addProductToCartNotifierProvider.notifier).addProductToCart(
          Product(
            id: product.id,
            title: product.title,
            description: product.description,
            price: product.price,
            stockQty: product.stockQty,
            productQty: 1,
          ),
        );

    showCustomSnackBar(context, 'Product added to cart');
  }
}
