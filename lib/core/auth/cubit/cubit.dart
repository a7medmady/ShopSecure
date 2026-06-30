import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce/core/auth/cubit/state.dart';
import 'package:e_commerce/core/auth/model/userModel.dart';
import 'package:e_commerce/core/database/cachehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  // dio instance
  final Dio dio = Dio();

  // restore initial state
  void restore() => emit(AuthInitial());

  //---------------------------------------------------------

  // close sign up
  void clearSignUp() {
    fullName.clear();
    userName.clear();
    phone.clear();
    pass.clear();
    passUp.clear();

    emit(AuthInitial());
  }

  // close login
  void clearLogin() {
    userName.clear();
    password.clear();

    emit(AuthInitial());
  }

  // ----------------------------------------------------------------------

  // save information about user

  void saveUserInfo(UserModel model) async {
    await Cachehelper.saveData(key: 'username', value: model.username);
    await Cachehelper.saveData(key: 'fullname', value: model.fname + ' ' + model.lname);
    await Cachehelper.saveData(key: 'id', value: model.uId);
    await Cachehelper.saveData(key: 'email', value: model.email);
  }

  // ----------------------------------------------------------------

  // sign in
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  void signIn() async {
    try {
      emit(SignInLoading());
      var response = await dio.post(
        'https://dummyjson.com/auth/login',
        data: {'username': email.text, 'password': password.text},
      );
      UserModel user = UserModel.fromJson(response.data);
      saveUserInfo(user);
      var cartResponse = await dio.get(
      'https://dummyjson.com/carts/user/${user.uId}',
    );

    if (cartResponse.data['carts'].isNotEmpty) {
      await Cachehelper.saveData(
        key: 'cartId',
        value: cartResponse.data['carts'][0]['id'],
      );
    }
      emit(SignInSuccess());
    } on DioException catch (e) {
      emit(
        SignInError(
          message:
              '${e.response!.data['message']}: Error of username or password',
        ),
      );
    } catch (e) {
      emit(SignInError(message: e.toString()));
    }
  }

  // -----------------------------------------------------------------

  // sign up
  TextEditingController fullName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController passUp = TextEditingController();
  List<String> names = [];
  void signUp() async {
    names.clear();
    fullName.text.split(' ').forEach((element) {
      names.add(element);
    });
    try {
      emit(SignUpLoading());
      await dio.post(
        'https://dummyjson.com/users/add',
        data: {
          'username': userName.text,
          'firstName': names[0],
          'lastName': names[1],
          'phone': phone.text,
          'password': pass.text,
        },
      );
      emit(SignUpSuccess());
    } on DioException catch (e) {
      emit(SignUpError(message: '${e.response!.data['message']}'));
    } catch (e) {
      emit(SignUpError(message: e.toString()));
    }
  }
}
