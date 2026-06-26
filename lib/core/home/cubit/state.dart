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

// add Cart
class AddCart extends HomeState {}

// remove from cart 
class RemoveFromCart extends HomeState {}

// love state
class InsertToLove extends HomeState {}
class RemoveFromLove extends HomeState {}






