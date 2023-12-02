import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_app/features/home/data/models/order.dart';
import 'package:skeleton_app/features/home/data/models/order_line.dart';
import 'package:skeleton_app/features/home/data/models/product.dart';
import 'package:skeleton_app/features/home/data/repositories/orders_repository.dart';

final getAllProductsNotifierProvider =
    StateNotifierProvider<GetNotesController, AsyncValue>(
  (ref) => GetNotesController(
    ref.read(ordersRepositoryProvider),
  ),
);

class GetNotesController extends StateNotifier<AsyncValue> {
  final OrdersRepository ordersRepository;
  GetNotesController(this.ordersRepository) : super(const AsyncData(null));

  Future<void> getAllProducts() async {
    state = const AsyncLoading();
    final result = await ordersRepository.getAllProducts();
    state = AsyncData(result);
  }
}

// final getAllProductsProvider = FutureProvider<List<Product>>(
//   (ref) {
//     return ref.read(ordersRepositoryProvider).getAllProducts();
//   },
// );

final getAllOrdersNotifierProvider =
    StateNotifierProvider<GetOrdersController, AsyncValue>(
  (ref) => GetOrdersController(
    ref.read(ordersRepositoryProvider),
  ),
);

class GetOrdersController extends StateNotifier<AsyncValue> {
  final OrdersRepository ordersRepository;
  GetOrdersController(this.ordersRepository) : super(const AsyncData(null));

  Future<void> getAllOrders() async {
    state = const AsyncLoading();
    final result = await ordersRepository.getAllOrders();
    state = AsyncData(result);
  }
}

final saveOrderNotifierProvider =
    StateNotifierProvider<SaveOrderController, AsyncValue>(
  (ref) => SaveOrderController(
    ref.read(ordersRepositoryProvider),
  ),
);

class SaveOrderController extends StateNotifier<AsyncValue> {
  final OrdersRepository ordersRepository;
  SaveOrderController(this.ordersRepository) : super(const AsyncData(null));

  Future<void> addOrder(Order order) async {
    state = const AsyncLoading();
    await ordersRepository.saveOrder(order);
    state = const AsyncData(null);
  }
}

final getCartItemsNotifierProvider =
    StateNotifierProvider<GetCartItemsController, AsyncValue>(
  (ref) => GetCartItemsController(
    ref.read(ordersRepositoryProvider),
  ),
);

class GetCartItemsController
    extends StateNotifier<AsyncValue<List<OrderLine>>> {
  final OrdersRepository ordersRepository;
  GetCartItemsController(this.ordersRepository) : super(const AsyncData([]));

  Future<void> getCartItems() async {
    state = const AsyncLoading();
    final result = await ordersRepository.getCartItems();
    state = AsyncData(result);
  }
}

final addProductToCartNotifierProvider =
    StateNotifierProvider<AddProductToCartController, AsyncValue>(
  (ref) => AddProductToCartController(
    ref.read(ordersRepositoryProvider),
  ),
);

class AddProductToCartController extends StateNotifier<AsyncValue> {
  final OrdersRepository ordersRepository;
  AddProductToCartController(this.ordersRepository)
      : super(const AsyncData(null));

  Future<void> addProductToCart(Product product) async {
    state = const AsyncLoading();
    await ordersRepository.addProductToCart(product);
    state = const AsyncData(null);
  }
}
