import 'package:dio/dio.dart';
import 'package:e_commerce/core/database/cachehelper.dart';
import 'package:e_commerce/core/home/cubit/state.dart';
import 'package:e_commerce/core/home/model/categoryModel.dart';
import 'package:e_commerce/core/home/model/productModel.dart';
import 'package:e_commerce/core/home/screens/cart.dart';
import 'package:e_commerce/core/home/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  // Screens
  List screens = [Home(), Cart()];
  int currentIndex = 0;
  void changeScreen(int index) {
    currentIndex = index;
    emit(ScreenChanged());
  }

  // Dio
  var dio = Dio();

  // Future search() async {
  //   emit(HomeSearchLoading());
  //   try {
  //     var response = await dio.get('');
  //     emit(HomeSearchSuccess());
  //     return response;
  //   } catch (e) {
  //     emit(HomeSearchError(message: e.toString()));
  //   }
  // }

  // get products
  List<ProductModel> listOfProducts = [];
  Future products(String category) async {
    emit(HomeLoading());
    try {
      Response<dynamic> response;
      if (category == 'All') {
        response = await dio.get('https://dummyjson.com/products');
      } else {
        response = await dio.get(
          'https://dummyjson.com/products/category/$category',
        );
      }
      listOfProducts.clear();
      for (var item in response.data['products']) {
        listOfProducts.add(ProductModel.fromJson(item));
      }
      emit(HomeSuccess());
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  // --------------------------------------------------------------------------------

  // get categories
  List<CategoryModel> listOfCategories = [];
  String selectedCategory = 'All';
  Future<void> categories() async {
    emit(GetCategoriesLoading());
    try {
      var response = await dio.get('https://dummyjson.com/products/categories');
      listOfCategories.clear();
      listOfCategories = (response.data as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList();
      listOfCategories.insert(0, CategoryModel(name: 'All'));
      debugPrint(listOfCategories.length.toString());
      emit(GetCategoriesSuccess());
    } catch (e) {
      emit(GetCategoriesError(message: e.toString()));
    }
  }

  // change category
  void changeCategory(String category) {
    selectedCategory = category;
    products(category);
    emit(CategoryChanged());
  }

  // ------------------------------------------------------------------------

  // change quantity
  // 1- Increase
  void increaseQuantity(ProductModel product, BuildContext context) {
    int index = listOfCartForUser.indexOf(product);
    if (listOfCartForUser[index].quantity < 10) {
      listOfCartForUser[index].quantity += 1;
    } else {
      customSnackBar(
        context,
        'You can not add more than 10 items',
        Colors.redAccent,
      );
    }
    emit(CategoryChanged());
  }

  // 2- Decrease
  void decreaseQuantity(ProductModel product, BuildContext context) {
    int index = listOfCartForUser.indexOf(product);
    if (listOfCartForUser[index].quantity > 1) {
      listOfCartForUser[index].quantity -= 1;
    } else {
      customSnackBar(
        context,
        'You can not order less than 1 item',
        Colors.redAccent,
      );
    }
    emit(CategoryChanged());
  }

  // -----------------------------------------------------------------------

  // cart
  // get cart for user
  List<ProductModel> listOfCartForUser = [];
  Future cartForUser(int id) async {
    try {
      emit(CartLoading());
      listOfCartForUser.clear();
      var response = await dio.get('https://dummyjson.com/carts/user/$id');
      final cartId = response.data['carts'][0]['id'];
      await Cachehelper.saveData(key: 'cartId', value: cartId);
      for (var item in response.data['carts'][0]['products']) {
        listOfCartForUser.add(ProductModel.fromJson(item));
      }
      emit(CartSuccess());
    } on DioException catch (e) {
      emit(CartError(message: '${e.response!.data['message']}'));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  // Add Cart
  // دا الصح بس ال api مش بيضيف ع السيرفر
  // void addCart(ProductModel product, int cartId, int quantity) async {
  //   final exists = listOfCartForUser.any((e) => e.id == product.id);

  //   if (!exists) {
  //     await dio.post(
  //       'https://dummyjson.com/carts/$cartId/add',
  //       data: {
  //         'products': [
  //           {'id': product.id, 'quantity': quantity},
  //         ],
  //       },
  //     );
  //     cartForUser(cartId);
  //     emit(UpdateCart());
  //   }
  // }

  void addCart(ProductModel product) {
    if (!listOfCartForUser.contains(product)) {
      listOfCartForUser.add(product);
      emit(UpdateCart());
    }
  }

  // Remove from Cart
  // دا الصح بس ال api مش بيحذف ع السيرفر
  // void removeFromCart(int index, int id) async {
  //   await dio.delete('https://dummyjson.com/carts/$id/products/$index');
  //   cartForUser(id);
  //   emit(UpdateCart());
  // }

  void removeFromCart(ProductModel product) {
    int index = listOfCartForUser.indexOf(product);
    listOfCartForUser.removeAt(index);
    emit(UpdateCart());
  }


//---------------------------------------------------------------------

  // calculate subtotal
  double calculateSubTotal() {
    double subTotal = 0;
    for (var item in listOfCartForUser) {
      subTotal += item.price * item.quantity;
    }
    return subTotal;
  }

  // calculate total
  double calculateTotal() {
    double total = 0;
    total = calculateSubTotal() * 0.9;
    return total;
  }

  // --------------------------------------------------

  // insert to love
  List<ProductModel> listOfLove = [];
  void insertToLove(ProductModel product) {
    if (!listOfLove.contains(product)) {
      listOfLove.add(product);
    }
    emit(InsertToLove());
  }

  // remove from love
  void removeFromLove(ProductModel product) {
    int index = listOfLove.indexOf(product);
    listOfLove.removeAt(index);
    emit(RemoveFromLove());
  }

  // custom snack bar
  void customSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
