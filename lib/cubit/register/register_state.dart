part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

// get user image state
class GetPictureSuccessfullyState extends RegisterState {}

class GetPictureErrorState extends RegisterState {}

//upload user image state
class UploadPictureSuccessfullyState extends RegisterState {}

class UploadPictureErrorState extends RegisterState {}

// Register user states
class RegisterUserLoadingState extends RegisterState {}

class RegisterUserSuccessState extends RegisterState {
  dynamic id;
  RegisterUserSuccessState(this.id);
}

class RegisterUserErrorState extends RegisterState {
  String error;

  RegisterUserErrorState(this.error);
}
