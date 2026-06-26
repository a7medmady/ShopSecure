import 'package:dio/dio.dart';
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

  Future search() async {
    emit(HomeSearchLoading());
    try {
      var response = await dio.get('');
      emit(HomeSearchSuccess());
      return response;
    } catch (e) {
      emit(HomeSearchError(message: e.toString()));
    }
  }

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

  // change quantity
  // 1- Increase
  void increaseQuantity(ProductModel product, BuildContext context) {
    int index = listOfCart.indexOf(product);
    if (listOfCart[index].quantity < 10) {
      listOfCart[index].quantity += 1;
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
    int index = listOfCart.indexOf(product);
    if (listOfCart[index].quantity > 1) {
      listOfCart[index].quantity -= 1;
    } else {
      customSnackBar(
        context,
        'You can not order less than 1 item',
        Colors.redAccent,
      );
    }
    emit(CategoryChanged());
  }

  // Add Cart
  List<ProductModel> listOfCart = [];
  void addCart(ProductModel product) {
    if (!listOfCart.contains(product)) {
      listOfCart.add(product);
    }
    emit(AddCart());
  }

  // Remove from Cart
  void removeFromCart(int index) {
    listOfCart.removeAt(index);
    emit(RemoveFromCart());
  }

  // calculate subtotal
  double calculateSubTotal() {
    double subTotal = 0;
    for (var item in listOfCart) {
      subTotal += item.price * item.quantity;
    }
    return subTotal;
  }

  // calculate total
  double calculateTotal() {
    double total = 0;
    total = calculateSubTotal() * 1.15;
    return total;
  }

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
