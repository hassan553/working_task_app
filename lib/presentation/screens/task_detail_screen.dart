import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/task/task_cubit.dart';
import '../widgets/widget.dart';








class TaskDetailScreen extends StatelessWidget {
  int index;
  TaskDetailScreen(this.index, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var commentController = TextEditingController();
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TaskCubit.get(context);
        TaskCubit.get(context).getAllComments(index);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Back',
                style: styles(
                  font: 15,
                  color: Colors.blue.shade900,
                  bold: FontWeight.bold,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Human resources tasks ',
                  style: styles(
                    font: 20,
                    bold: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Card(
                  color: defaultColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Upload by ',
                              style: styles(
                                font: 16,
                                bold: FontWeight.w500,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            const Spacer(),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: defaultColor2,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  cubit.users[index].image.toString(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              '${cubit.users[index].name}\n${cubit.users[index].jobTitle} ',
                              style: styles(
                                font: 10,
                                bold: FontWeight.w600,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Text(
                              'Upload on : ',
                              style: styles(
                                font: 15,
                                bold: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              '2022-2-23 ',
                              style: styles(
                                font: 13,
                                bold: FontWeight.w600,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              //deadLine(context, index),
                              'deadLine:',
                              style: styles(
                                font: 15,
                                bold: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              '2022-2-30',
                              style: styles(
                                font: 13,
                                bold: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Text(
                            'Still have a time',
                            style: styles(
                              color: Colors.green,
                              bold: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Divider(),
                        Text(
                          'Done state:',
                          style: styles(
                            color: Colors.blue.shade900,
                            font: 16,
                            bold: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: (){
                                  cubit.updateTask(value: true,taskId: cubit.tasks[index].id,);
                                },
                                child:Text( 'Done:',
                                  style: styles(
                                    color: Colors.black,
                                    font: 13,
                                  ),
                                ),),
                                Opacity(
                                opacity:cubit.tasks[index].isDone==true? 1:0,
                                child: const Icon(
                                  Icons.check_box_outlined,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                onPressed: (){
                                  cubit.updateTask(value: false,taskId: cubit.tasks[index].id,);
                                },
                               child:Text( 'Not Done yet:',
                                style: styles(
                                  color: Colors.black,
                                  font: 13,
                                ),
                              ),),
                               Opacity(
                               opacity:cubit.tasks[index].isDone==false? 1:0,
                                child:const Icon(
                                  Icons.check_box_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Text(
                          'Task description',
                          style: styles(
                            color: Colors.blue.shade900,
                            font: 16,
                            bold: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          cubit.tasks[index].description ,
                          style: styles(
                            color: Colors.blue.shade900,
                            font: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        cubit.isComment
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      controller: commentController,
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
                                      maxLines: 6,
                                      maxLength: 2000,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.pink,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Column(
                                    children: [
                                      ElevatedButton(
                                        clipBehavior: Clip.hardEdge,
                                        style: ElevatedButton.styleFrom(
                                          primary: defaultColor2,
                                          minimumSize: const Size(
                                            80,
                                            40,
                                          ),
                                        ),
                                        onPressed: () {
                                          cubit.changeCommentState();
                                          cubit.taskComments(
                                            index: index,
                                            description: commentController.text,
                                          );
                                        },
                                        child: const Text('Post'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          cubit.changeCommentState();
                                        },
                                        child: Text(
                                          'Cansel',
                                          style: styles(
                                            font: 16,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : ElevatedButton(
                                clipBehavior: Clip.hardEdge,
                                style: ElevatedButton.styleFrom(
                                  primary: defaultColor2,
                                  minimumSize: const Size(
                                    double.infinity,
                                    50,
                                  ),
                                ),
                                onPressed: () {
                                  cubit.changeCommentState();
                                },
                                child: const Text('Add a comment'),
                              ),
                        const Divider(),
                        ConditionalBuilder(
                          condition: cubit.comments.isNotEmpty,
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(
                              color: defaultColor2,
                            ),
                          ),
                          builder: (context) => ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:  TaskCubit.get(context).comments.length,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                      right: 3,
                                    ),
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundColor: defaultColor2,
                                      child:  CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                          TaskCubit.get(context).comments[index].image,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          TaskCubit.get(context).comments[index].name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: styles(
                                            color: Colors.black,
                                            bold: FontWeight.bold,
                                            font: 15,
                                          ),
                                        ),
                                        Text(
                                          TaskCubit.get(context).comments[index].description,
                                          style: styles(
                                            color: Colors.black45,
                                            font: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  uploadON(context, index) {
    return '${TaskCubit.get(context).tasks[index].date}';
  }

  deadLine(context, index) {
    return '2022-12-18';
  }
}
