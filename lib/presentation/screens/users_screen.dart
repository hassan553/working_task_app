import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:working_os_app/presentation/screens/auth/user_profile_screen.dart';

import '../../cubit/task/task_cubit.dart';
import '../widgets/widget.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TaskCubit.get(context);
        return Scaffold(
          appBar: buildAppBar(context, 'All Users'),
          drawer: buildDrawer(context),
          body: ConditionalBuilder(
            condition: cubit.users.isNotEmpty,
            builder: (context) => ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    navigateAndFinsh(context: context,screen: ProfileScreen(userModel: cubit.users[index],));
                  },
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              right: 8,
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            child:CircleAvatar(
                              radius: 30,
                              backgroundImage:NetworkImage(cubit.users[index].image??' '),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.users[index].name.toString(),
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
                                  cubit.users[index].jobTitle.toString(),
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
                            Icons.email_outlined,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: cubit.users.length,
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: defaultColor2,
              ),
            ),
          ),
        );
      },
    );
  }
  userImage(context,index){
    if(BlocProvider.of<TaskCubit>(context).users[index].image==null){
       return const AssetImage('assets/images/wallpaper');
    }else
      {
       return  NetworkImage(BlocProvider.of<TaskCubit>(context).users[index].image);
      }
  }
}
