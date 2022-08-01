part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginChangeIcon extends LoginState {}
class LoginUserLoadingState extends LoginState {}
class LoginUserSuccessState extends LoginState {}
class LoginUserErrorState extends LoginState {
  String error;
  LoginUserErrorState(this.error);
}
