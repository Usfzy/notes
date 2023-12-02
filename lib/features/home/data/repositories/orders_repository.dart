import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_app/features/home/data/models/order.dart';
import 'package:skeleton_app/features/home/data/models/order_line.dart';
import 'package:skeleton_app/features/home/data/models/product.dart';
import 'package:skeleton_app/features/home/data/service/notes_service.dart';

final ordersRepositoryProvider = Provider<OrdersRepository>(
  (ref) => OrdersRepository(ref.read(notesServiceProvider)),
);

class OrdersRepository {
  final NotesService notesService;
  OrdersRepository(this.notesService);

  final orders = <Order>[];
  final cart = <OrderLine>[];

  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return products;
  }

  Future<List<Order>> getAllOrders() async {
    await Future.delayed(const Duration(seconds: 2));
    return orders;
  }

  Future<void> saveOrder(Order order) async {
    await Future.delayed(const Duration(seconds: 2));
    orders.add(order);
    cart.clear();
  }

  Future<void> addProductToCart(Product product) async {
    cart.add(
      OrderLine(
        id: 'id',
        productId: product.id,
        productName: product.title,
        quantity: product.productQty,
        productPrice: product.price,
      ),
    );
  }

  Future<List<OrderLine>> getCartItems() async {
    await Future.delayed(const Duration(seconds: 2));
    return cart;
  }

  var products = [
    const Product(
      id: 'product_id',
      title: 'T-Shirt',
      description: 'T-Shirt For men',
      price: 10,
      stockQty: 100,
      productQty: 10,
    ),
    const Product(
      id: 'product_id',
      title: 'Shoes',
      description: 'Shoes for women',
      price: 10,
      stockQty: 100,
      productQty: 10,
    ),
    const Product(
      id: 'product_id',
      title: 'Purse',
      description: 'purse for women',
      price: 10,
      stockQty: 100,
      productQty: 10,
    ),
    const Product(
      id: 'product_id',
      title: 'Belt',
      description: 'Belt for men',
      price: 10,
      stockQty: 100,
      productQty: 10,
    ),
    const Product(
      id: 'product_id',
      title: 'Jeans',
      description: 'Jeans for men and women',
      price: 10,
      stockQty: 100,
      productQty: 10,
    ),
    const Product(
      id: 'product_id',
      title: 'Dress',
      description: 'Dress for men and women',
      price: 10,
      stockQty: 100,
      productQty: 10,
    ),
    const Product(
      id: 'product_id',
      title: 'Skirt',
      description: 'Skirt for women',
      price: 10,
      stockQty: 100,
      productQty: 10,
    ),
  ];
}
