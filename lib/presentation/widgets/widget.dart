import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../constants/constants.dart';
import '../../cubit/task/task_cubit.dart';
import '../screens/add_task_screen.dart';
import '../screens/home_page_screen.dart';
import '../screens/auth/user_profile_screen.dart';
import '../screens/users_screen.dart';
void showSnackBar(context,message){
  final snackBar = SnackBar(
    content:  Text(message.toString()),
    duration:const  Duration(seconds: 2),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
Widget buildTextField({
  dynamic controller,
  dynamic keyboard,
  bool obscure = false,
  dynamic textLabel,
  dynamic icon,
  dynamic passwordIcon,
  dynamic valid,
}) {
  return TextFormField(
    controller: controller,
    validator: (dynamic value) {
      if (value.isEmpty) {
        return 'not valid ';
      }
    },
    keyboardType: keyboard,
    style: const TextStyle(
      color: Colors.white,
    ),
    obscureText: obscure,
    cursorColor: Colors.white,
    decoration: InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      labelText: textLabel,
      prefixIcon: icon,
      suffixIcon: passwordIcon,
      labelStyle: const TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
    ),
  );
}

TextStyle styles({
  double font = 14,
  Color color = Colors.white,
  FontWeight? bold,
}) {
  return TextStyle(
    color: color,
    fontSize: font,
    fontWeight: bold,
  );
}

navigateAndFinsh({
  context,
  screen,
}) {
  return Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return screen;
    },
  ));
}

Color defaultColor = Colors.white;
Color defaultColor2 = Colors.pink;

void showFilterDialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
          contentPadding: const EdgeInsets.all(5),
          title: Row(
            children: [
              Text(
                'Task category',
                style: styles(
                  font: 20,
                  color: defaultColor2,
                ),
              ),
              Icon(
                Icons.arrow_drop_down_outlined,
                color: defaultColor2,
              ),
            ],
          ),
          content: SizedBox(
            height: 200,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    BlocProvider.of<TaskCubit>(context)
                        .choiceCategoryItem(dialogListTitle[index]);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: defaultColor2,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            dialogListTitle[index],
                            overflow: TextOverflow.ellipsis,
                            style: styles(
                              font: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: dialogListTitle.length,
            ),
          ),
        );
      });
}

void closeWidget(context) {
  Navigator.pop(context);
}

buildAppBar(context, title) {
  return AppBar(
    title: Text(
      title.toString(),
      style: styles(
        color: Colors.pink,
        font: 20,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          showFilterDialog(context);
        },
        icon: const Icon(Icons.filter_list),
      ),
    ],
  );
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

buildDrawer(context) {
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Work Os ',
                style: styles(
                  font: 20,
                  color: Colors.black,
                  bold: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        buildListTitle(
          'All Tasks',
          Icons.task_outlined,
          () {
            navigateAndFinsh(
              context: context,
              screen: HomePageScreen(),
            );
          },
        ),
        buildListTitle(
          'My Account ',
          Icons.mark_email_unread_outlined,
          () {
            navigateAndFinsh(
              context: context,
              screen:  ProfileScreen(userModel:BlocProvider.of<TaskCubit>(context).userModel,isCurrentUser: true,),
            );
          },
        ),
        buildListTitle(
          'Users',
          Icons.people_outline,
          () {
            navigateAndFinsh(
              context: context,
              screen: const UsersScreen(),
            );
          },
        ),
        buildListTitle(
          'Add Task ',
          Icons.check_box_outlined,
          () {
            navigateAndFinsh(
              context: context,
              screen: AddTask(),
            );
          },
        ),
        const Divider(),
        buildListTitle(
          'Logout ',
          Icons.power_settings_new,
          () {
            buildSignOutDialog(context);
          },
        ),
        buildListTitle(
          'Close ',
          Icons.close_outlined,
          () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
