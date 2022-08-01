import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/task/task_cubit.dart';
import '../widgets/widget.dart';

class AddTask extends StatelessWidget {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is UploadTaskSuccessState) {
          showSnackBar(
            context,
            'Done Upload Task',
          );
        }
      },
      builder: (context, state) {
        var cubit = TaskCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  elevation: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    height: MediaQuery.of(context).size.height * .9,
                    width: MediaQuery.of(context).size.width * .9,
                    color: Colors.white,
                    child: ListView(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'All field are required',
                            style: styles(
                              font: 20,
                              color: Colors.blue,
                              bold: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildText('Task category*'),
                              InkWell(
                                onTap: () {
                                  showFilterDialog(context);
                                },
                                child: _buildPaddingTextFiled(
                                  child: _buildTextField(
                                    context: context,
                                    enabled: false,
                                    controller: categoryController,
                                    label: cubit.categoryItem != null
                                        ? cubit.categoryItem!
                                        : 'choose task category',
                                  ),
                                ),
                              ),
                              _buildText('Task title'),
                              _buildPaddingTextFiled(
                                child: _buildTextField(
                                  context: context,
                                  controller: titleController,
                                ),
                              ),
                              _buildText(
                                'Task description',
                              ),
                              _buildPaddingTextFiled(
                                child: _buildTextField(
                                  context: context,
                                  maxLines: 5,
                                  maxLength: 1000,
                                  controller: descriptionController,
                                ),
                              ),
                              _buildText('DeadLine date*'),
                              InkWell(
                                onTap: () {
                                  _buildShowDatePicker(context);
                                },
                                child: _buildPaddingTextFiled(
                                  child: _buildTextField(
                                    context: context,
                                    controller: dateController,
                                    enabled: false,
                                    label: BlocProvider.of<TaskCubit>(context)
                                                .dateTime !=
                                            null
                                        ? _buildDateTimeFormat(context)
                                        : 'Pick up a date time ',
                                  ),
                                ),
                              ),
                              ConditionalBuilder(
                                  condition: state is! UploadTaskLoadingState,
                                  builder: (context) {
                                    return Align(
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            cubit.uploadTask(
                                              title: titleController.text,
                                              description:
                                                  descriptionController.text,
                                              date: cubit.dateTime,
                                              category: cubit.categoryItem,
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: defaultColor2,
                                            minimumSize: const Size(
                                              100,
                                              50,
                                            ),
                                          ),
                                          child: Text(
                                            'Upload',
                                            style: styles(
                                              font: 18,
                                            ),
                                          ),
                                        ));
                                  },
                                  fallback: (context) {
                                    return CircularProgressIndicator(
                                      color: defaultColor2,
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _buildDateTimeFormat(context) {
    String s =
        '${BlocProvider.of<TaskCubit>(context).dateTime!.year}-${BlocProvider.of<TaskCubit>(context).dateTime!.month}-${BlocProvider.of<TaskCubit>(context).dateTime!.day}';
    return s;
  }

  _buildShowDatePicker(context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(
        2025,
      ),
    ).then((value) {
      BlocProvider.of<TaskCubit>(context).choiceDateTime(value);
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  _buildPaddingTextFiled({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      child: child,
    );
  }

  _buildText(String text) {
    return Text(
      text,
      style: styles(
        font: 15,
        color: defaultColor2,
        bold: FontWeight.bold,
      ),
    );
  }

  _buildTextField({
    context,
    int maxLines = 1,
    int maxLength = 100,
    bool enabled = true,
    String label = '',
    controller,
  }) {
    return TextFormField(
      controller: controller,
      validator: (dynamic value) {
        if (value.isEmpty) {
          return 'not valid ';
        }
      },
      keyboardType: TextInputType.text,
      style: const TextStyle(
        color: Colors.black,
      ),
      cursorColor: Colors.pink,
      maxLines: maxLines,
      maxLength: maxLength,
      enabled: enabled,
      decoration: InputDecoration(
        filled: true,
        labelText: label,
        labelStyle: styles(
          font: 13,
          bold: FontWeight.w500,
          color: Colors.black,
        ),
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}
