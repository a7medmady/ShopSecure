abstract class AuthState {}

class AuthInitial extends AuthState {}

// sign in
class SignInSuccess extends AuthState {}
class SignInError extends AuthState {
  final String message;
  SignInError({required this.message});
}
class SignInLoading extends AuthState {}

// sign up
class SignUpSuccess extends AuthState {}
class SignUpError extends AuthState {
  final String message;
  SignUpError({required this.message});
}
class SignUpLoading extends AuthState {}
