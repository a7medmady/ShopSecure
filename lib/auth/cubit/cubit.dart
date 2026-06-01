import 'package:e_commerce/auth/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  // sign in
  void signIn() {}

  // sign up
  void signUp() {}

  
}
