import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:working_os_app/presentation/screens/task_detail_screen.dart';


//https://image.flaticon.com/icons/png/128/390/390973.png

import '../../cubit/task/task_cubit.dart';
import '../widgets/widget.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TaskCubit.get(context);
        return Scaffold(
          appBar: buildAppBar(context, 'All Task '),
          drawer: buildDrawer(context),
          body: ConditionalBuilder(
            builder: (context) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      try{
                        navigateAndFinsh(
                          context: context,
                          screen: TaskDetailScreen(0,),
                        );
                      }catch(onError){
                        print(onError.toString());
                      }
                    },
                    onDoubleTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    cubit.deleteTask(cubit.tasks[index].id);
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                        size: 35,
                                      ),
                                      Text(
                                        'Delete',
                                        style: styles(
                                          font: 20,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.only(
                                right: 8,
                              ),
                              decoration: const BoxDecoration(
                                  border: Border(
                                right: BorderSide(
                                  color: Colors.black,
                                ),
                              ),),
                              child: cubit.tasks[index].isDone == true
                                  ? Image.asset('assets/images/index.jpg')
                                  : Image.asset('assets/images/indexz.jpg'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.tasks[index].title.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: styles(
                                      color: Colors.black,
                                      bold: FontWeight.bold,
                                      font: 15,
                                    ),
                                  ),
                                  Text(
                                    '***',
                                    style: styles(
                                      color: Colors.pink,
                                      font: 20,
                                    ),
                                  ),
                                  Text(
                                    cubit.tasks[index].description.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: styles(
                                      color: Colors.black45,
                                      font: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.pink,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: cubit.tasks.length,
              );
            },
            fallback: (context) {
              return Center(
                child: CircularProgressIndicator(
                  color: defaultColor2,
                ),
              );
            },
            condition: cubit.tasks.isNotEmpty,
          ),
        );
      },
    );
  }

  void buildSignOutDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Sign out ',
            style: styles(
              font: 20,
              color: Colors.black,
            ),
          ),
          content: Text(
            'Do you wanna Sign out !!!',
            style: styles(
              font: 15,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                closeWidget(context);
              },
              child: Text(
                'Cansel',
                style: styles(
                  font: 18,
                  color: Colors.blue,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                closeWidget(context);
              },
              child: Text(
                'Ok',
                style: styles(
                  font: 18,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void closeWidget(context) {
    Navigator.pop(context);
  }

  Widget buildListTitle(
    String title,
    IconData iconData,
    dynamic function,
  ) {
    return ListTile(
      onTap: function,
      title: Text(title),
      leading: Icon(
        iconData,
      ),
    );
  }
}
