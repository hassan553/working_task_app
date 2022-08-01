import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../constants/constants.dart';
import '../../models/comment_model.dart';
import '../../models/task_model.dart';
import '../../models/user_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  static TaskCubit get(context) => BlocProvider.of(context);
  DateTime? dateTime;

  void choiceDateTime(DateTime? value) {
    try {
      dateTime = value;
      emit(ChoiceDateTimeSuccessState());
    } catch (error) {
      print(error.toString());
      emit(ChoiceDateTimeErrorState());
    }
  }

  String? categoryItem;

  void choiceCategoryItem(String? value) {
    try {
      categoryItem = value;
      emit(ChoiceCategorySuccessState());
    } catch (error) {
      print(error.toString());
      emit(ChoiceCategoryErrorState());
    }
  }

  bool isComment = false;

  void changeCommentState() {
    isComment = !isComment;
    emit(ChangeCommentState());
  }

  TaskModel? taskModel;

  void uploadTask({
    dynamic title,
    dynamic description,
    dynamic date,
    dynamic category,
  }) async {
    String taskId = const Uuid().v4();
    taskModel = TaskModel(
      category: category,
      date: date,
      description: description,
      title: title,
      id: taskId,
      isDone: false,
    );
    emit(UploadTaskLoadingState());
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskId)
        .set(taskModel!.toMap())
        .then((value) {
          getAllTasks();
      emit(UploadTaskSuccessState());
    }).catchError((onError) {
      print('error in upload');
      emit(UploadTaskErrorState());
    });
  }

  List<TaskModel> tasks = [];

  void getAllTasks() async {

    emit(GetTaskLoadingState());
    await FirebaseFirestore.instance.collection('tasks').get().then((value) {
      tasks = [];
      value.docs.forEach((element) {

        tasks.add(TaskModel.fromJson(element.data()));
        emit(GetTaskLoadingState());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(GetTaskLoadingState());
    });
  }

  List<UserModel> users = [];
  bool isCurrentUser = false;
  UserModel userModel = UserModel();

  void getAllUsers() async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    emit(GetUsersLoadingState());
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if(userID!=element.id) {
          users.add(UserModel.fromJson(element.data()));
        } else {
          userModel=UserModel.fromJson(element.data());
        }
      });

      emit(GetUsersSuccessState());
    }).catchError((onError) {
      emit(GetUsersErrorState());
    });
  }

  void deleteTask(id) async {
    emit(DeleteTaskLoadingState());
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(id)
        .delete()
        .then((value) {
          tasks=[];
          getAllTasks();
      print('success delete');

      emit(DeleteTaskSuccessState());
      print('success delete DONE ');
    }).catchError((onError) {
      print(onError.toString());
      emit(DeleteTaskErrorState());
    });
  }

  CommentModel? commentModel;

  void taskComments({
    index,
    description,
  }) async {
    commentModel = CommentModel(
      description: description,
      image: users[index].image,
      name: users[index].name,
    );
    emit(WriteCommentsLoadingState());
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(tasks[index].id)
        .collection('comments')
        .add(commentModel!.toMap())
        .then((value) {
      comments = [];
      getAllComments(index);
      print('done comment ');
      emit(WriteCommentsSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(WriteCommentsErrorState());
    });
  }

  List<CommentModel> comments = [];

  void getAllComments(index) async {
    emit(GetCommentsLoadingState());
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(tasks[index].id)
        .collection('comments')
        .get()
        .then((value) {
      comments = [];
      value.docs.forEach((element) {
        comments.add(CommentModel.fromJson(element.data()));
      });
      emit(GetCommentsSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetCommentsErrorState());
    });
  }

  String name = '';
  String email = '';
  String phone = '';
  String image = '';
  String jobTitle = '';
  String id = FirebaseAuth.instance.currentUser!.uid;

  void getUser() async {
    emit(GetUsersLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) {
      email = value.get('email');
      image = value.get('image');
      name = value.get('name');
      jobTitle = value.get('jobTitle');
      phone = value.get('phone');
      print(email);
      emit(GetUsersSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetUserErrorState());
    });
  }

  void updateTask({taskId, value}) async {
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
      'isDone': value,
    }).then((value) {
      print('update');

      getAllTasks();
      emit(UpdateTaskSuccessfullyState());
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateTaskErrorState());
    });
  }
}
