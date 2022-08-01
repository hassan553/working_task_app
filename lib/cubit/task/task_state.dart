part of 'task_cubit.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class ChoiceDateTimeSuccessState extends TaskState {}

class ChoiceDateTimeErrorState extends TaskState {}

class ChoiceCategorySuccessState extends TaskState {}

class ChoiceCategoryErrorState extends TaskState {}

class ChangeCommentState extends TaskState {}

// upload task states
class UploadTaskSuccessState extends TaskState {}

class UploadTaskLoadingState extends TaskState {}

class UploadTaskErrorState extends TaskState {}

// get task states
class GetTaskSuccessState extends TaskState {}

class GetTaskLoadingState extends TaskState {}

class GetTaskErrorState extends TaskState {}

// Delete task states
class DeleteTaskSuccessState extends TaskState {}

class DeleteTaskLoadingState extends TaskState {}

class DeleteTaskErrorState extends TaskState {}

// get users states
class GetUsersSuccessState extends TaskState {}

class GetUsersLoadingState extends TaskState {}

class GetUsersErrorState extends TaskState {}

// write comments states
class WriteCommentsSuccessState extends TaskState {}

class WriteCommentsLoadingState extends TaskState {}

class WriteCommentsErrorState extends TaskState {}

// get comments states
class GetCommentsSuccessState extends TaskState {}

class GetCommentsLoadingState extends TaskState {}

class GetCommentsErrorState extends TaskState {}

// get user  state
class GetUserSuccessfullyState extends TaskState {}

class GetUserLoadingState extends TaskState {}

class GetUserErrorState extends TaskState {}

// update task  state
class UpdateTaskSuccessfullyState extends TaskState {}

class UpdateTaskErrorState extends TaskState {}
