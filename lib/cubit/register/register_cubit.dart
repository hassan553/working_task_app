import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebas_storage;

import '../../models/user_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  File? profileImage;
  var pickerGallery = ImagePicker();

  Future getImageGallery() async {
    var pickerImageGallery = await pickerGallery.pickImage(
      source: ImageSource.gallery,
    );
    if (pickerImageGallery != null) {
      profileImage = File(pickerImageGallery.path);
      uploadUserImage();
    } else {
      emit(GetPictureErrorState());
    }
  }

  String userImageUri = '';

  void uploadUserImage() {
    firebas_storage.FirebaseStorage.instance
        .ref()
        .child('images/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('image ${value.toString()}');
        userImageUri = value;
        emit(UploadPictureSuccessfullyState());
      }).catchError((onError) {
        print(onError.toString());
        emit(UploadPictureErrorState());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(UploadPictureErrorState());
    });
  }

  UserModel? userModel;


  void registerUser({
    name,
    email,
    password,
    phone,
    jobTitle,
  }) async {
    emit(RegisterUserLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print('register success');

      createUser(
        jobTitle: jobTitle,
        id: value.user?.uid,
        phone: phone,
        name: name,
        email: email,
        password: password,
      );
    }).catchError((onError) {
      print(onError.toString());
      emit(RegisterUserErrorState(onError.toString()));
    });
  }

  void createUser({
    name,
    email,
    password,
    phone,
    id,
    jobTitle,
  }) async {
    userModel = UserModel(
      password: password,
      email: email,
      name: name,
      phone: phone,
      id: id,
      jobTitle: jobTitle,
      image: userImageUri,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userModel!.toMap())
        .then((value) {

      emit(RegisterUserSuccessState(id));
    }).catchError((onError) {
      print(onError.toString());
      emit(RegisterUserErrorState(onError));
    });
  }
}
