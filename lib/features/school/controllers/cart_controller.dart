import 'package:get/get.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';

class CartController extends GetxController {
  final _cart = <Product, int>{}.obs; // Make it observable

  Map<Product, int> get cart => _cart.value;

  void addToCart(Product product, int quantity) {
    _cart.update(
      product,
      (value) => value + quantity,
      ifAbsent: () => quantity,
    );
  }

  void removeFromCart(Product product) {
    _cart.remove(product);
  }

  void clearCart() {
    _cart.clear();
  }

  double get totalPrice => _cart.entries.fold(0, (sum, entry) {
    return sum + (double.tryParse(entry.key.price ?? '0')!) * entry.value;
  });

  int get itemCount => _cart.values.fold(0, (sum, quantity) => sum + quantity);
}


class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController(), fenix: true);
  }
}