import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_app/core/widgets/app_bar_widget.dart';
import 'package:skeleton_app/core/widgets/custom_error_widget.dart';
import 'package:skeleton_app/core/widgets/custom_progress_indicator.dart';
import 'package:skeleton_app/features/home/controller/orders_controller.dart';
import 'package:skeleton_app/features/home/views/widgets/order_item.widget.dart';

class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<OrdersPage> {
  @override
  void initState() {
    super.initState();

    _getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Orders',
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(getAllOrdersNotifierProvider);

          return state.when(
            data: (orders) {
              if (orders == null || orders.isEmpty) {
                return const Center(child: Text('No products found'));
              }
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderItemWidget(order: orders[index]);
                },
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

  void _getAllOrders() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(getAllOrdersNotifierProvider.notifier).getAllOrders();
    });
  }
}
