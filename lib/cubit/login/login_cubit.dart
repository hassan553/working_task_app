import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  bool obscure = true;

  void changeIcon() {
    obscure = !obscure;
    emit(LoginChangeIcon());
  }

  void loginUser({
    dynamic email,
    dynamic password,
  }) async {
    emit(LoginUserLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) {
          print('login success');
          emit(LoginUserSuccessState());
    })
        .catchError(
          (onError) {
            print(onError.toString());
            emit(LoginUserErrorState(onError));
          },
        );
  }

}
