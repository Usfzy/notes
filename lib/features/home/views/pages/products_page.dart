import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_app/config/routes_generator.dart';
import 'package:skeleton_app/core/utils/extensions.dart';
import 'package:skeleton_app/core/widgets/app_bar_widget.dart';
import 'package:skeleton_app/core/widgets/custom_error_widget.dart';
import 'package:skeleton_app/core/widgets/custom_progress_indicator.dart';
import 'package:skeleton_app/features/home/controller/orders_controller.dart';
import 'package:skeleton_app/features/home/views/widgets/product_item_widget.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductsPage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<ProductsPage> {
  @override
  void initState() {
    super.initState();

    _getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Products',
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(getAllProductsNotifierProvider);

          return state.when(
            data: (products) {
              if (products == null || products.isEmpty) {
                return const Center(child: Text('No products found'));
              }
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductItemWidget(product: products[index]);
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
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  void _getAllProducts() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(getAllProductsNotifierProvider.notifier).getAllProducts();
    });
  }

  void _onFabPressed() {
    context.pushNamed(RouteGenerator.kCartPage);
  }
}
