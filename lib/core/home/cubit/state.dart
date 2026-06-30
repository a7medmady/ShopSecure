abstract class HomeState {}

class HomeInitial extends HomeState {}

// Category Changed
class CategoryChanged extends HomeState {}

// Screen Changed
class ScreenChanged extends HomeState {}

// Home State
class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}

// Search
class HomeSearchLoading extends HomeState {}

class HomeSearchSuccess extends HomeState {}

class HomeSearchError extends HomeState {
  final String message;
  HomeSearchError({required this.message});
}

// categories
class GetCategoriesLoading extends HomeState {}

class GetCategoriesSuccess extends HomeState {}

class GetCategoriesError extends HomeState {
  final String message;
  GetCategoriesError({required this.message});
}

// quantity
class QuantityIncreased extends HomeState {}

class QuantityDecreased extends HomeState {}

// update Cart
class UpdateCart extends HomeState {}

// love state
class InsertToLove extends HomeState {}

class RemoveFromLove extends HomeState {}

// cart state
class CartLoading extends HomeState {}

class CartSuccess extends HomeState {}

class CartError extends HomeState {
  final String message;
  CartError({required this.message});
}
