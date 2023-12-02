import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_app/core/utils/extensions.dart';
import 'package:skeleton_app/core/widgets/app_bar_widget.dart';
import 'package:skeleton_app/core/widgets/custom_button.dart';
import 'package:skeleton_app/core/widgets/custom_divider.dart';
import 'package:skeleton_app/core/widgets/custom_error_widget.dart';
import 'package:skeleton_app/core/widgets/custom_progress_indicator.dart';
import 'package:skeleton_app/core/widgets/custom_snackbar.dart';
import 'package:skeleton_app/features/home/controller/orders_controller.dart';
import 'package:skeleton_app/features/home/data/models/order.dart';
import 'package:skeleton_app/features/home/data/models/order_line.dart';
import 'package:skeleton_app/features/home/views/widgets/cart_item_widget.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  final orderlines = <OrderLine>[];

  @override
  void initState() {
    super.initState();

    _getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Cart',
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(getCartItemsNotifierProvider);

          return state.when(
            data: (orderLines) {
              if (orderLines == null || orderLines.isEmpty) {
                return const Center(child: Text('No items in cart'));
              }

              orderlines.clear;
              orderlines.addAll(orderLines);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const CustomDivider();
                      },
                      itemCount: orderLines.length,
                      itemBuilder: (context, index) {
                        return CartItemWidget(orderline: orderLines[index]);
                      },
                    ),
                  ),
                  Consumer(builder: (context, ref, child) {
                    final state = ref.watch(saveOrderNotifierProvider);

                    _listenToRef(ref);

                    return state.when(
                      data: (data) => _saveButton(),
                      error: (error, stackTrace) => CustomErrorWidget(
                        error: error.toString(),
                      ),
                      loading: () => const Center(
                        child: CustomProgressIndicator(),
                      ),
                    );
                  })
                ],
              );
            },
            error: (error, stackTrace) => CustomErrorWidget(
              error: error.toString(),
            ),
            loading: () => const Center(
              child: CustomProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget _saveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: CustomButton(
        text: 'Save',
        onPressed: _saveOrder,
      ),
    );
  }

  void _getCartItems() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(getCartItemsNotifierProvider.notifier).getCartItems();
    });
  }

  void _saveOrder() {
    final order = Order(
      id: 'order_id',
      clientId: 'client_id',
      date: DateTime.now().toIso8601String(),
      total: orderlines.fold(
        0,
        (previousValue, element) => previousValue + element.total,
      ),
      orderlines: orderlines,
    );

    ref.read(saveOrderNotifierProvider.notifier).addOrder(order);
  }

  void _listenToRef(WidgetRef ref) {
    ref.listen(saveOrderNotifierProvider, (previous, next) {
      next.when(
        data: (data) {
          showCustomSnackBar(context, 'Order Saved');
          context.pop();
        },
        error: (e, s) => null,
        loading: () => null,
      );
    });
  }
}
