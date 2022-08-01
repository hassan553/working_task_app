import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttericon/font_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:working_os_app/presentation/screens/auth/register-screen.dart';

import '../../../cubit/task/task_cubit.dart';
import '../../../models/user_model.dart';
import '../../widgets/widget.dart';



class ProfileScreen extends StatelessWidget{
  TextStyle _titleTextStyle = TextStyle(
      fontSize: 15, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold);

  var contentTextStyle = TextStyle(
      color: Colors.blue.shade900,
      fontSize: 13,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold);
  UserModel? userModel ;
  bool? isCurrentUser;
  ProfileScreen({Key? key,this.userModel,this.isCurrentUser=false,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TaskCubit.get(context);

        return Scaffold(
          //drawer: DrawerWidget(),
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: ConditionalBuilder(
            condition: cubit.email.isNotEmpty,
            fallback: (context) {
              return Center(
                child: CircularProgressIndicator(
                  color: defaultColor2,
                ),
              );
            },
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Stack(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child:
                                    Text(cubit.userModel.name, style: _titleTextStyle)),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                cubit.userModel.jobTitle,
                                style: contentTextStyle,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Contact Info',
                              style: _titleTextStyle,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: userInfo(
                                title: 'Email:',
                                content:cubit.userModel.email,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: userInfo(
                                  title: 'Phone number:',
                                  content: "01002033323"),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            isCurrentUser==true ? Container():   const Divider(
                              thickness: 1,
                            ),
                            isCurrentUser==true ? Container(): const SizedBox(
                              height: 20,
                            ),
                            isCurrentUser==true ? Container(): Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _contactBy(
                                    color: Colors.green,
                                    fct: () {
                                      _openWhatsApp(userModel?.phone);
                                    },
                                    icon:FontAwesome.whatsapp, ), //Icons.message_outlined),
                                _contactBy(
                                    color: Colors.red,
                                    fct: () {
                                      _openEmail(userModel?.email);
                                    },
                                    icon:Icons.email,),
                                _contactBy(
                                    color: Colors.purple,
                                    fct: () {
                                      _openCall(userModel?.phone);
                                    },
                                    icon: Icons.call_outlined),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                           isCurrentUser==true? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return RegisterScreen();
                                        },
                                      ),
                                    );
                                  },
                                  color: Colors.pink.shade700,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.logout,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Logout',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ):Container(),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * 0.26,
                          height: size.width * 0.26,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 8,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                cubit.image,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _contactBy(
      {required Color color, required Function fct, required IconData icon}) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: CircleAvatar(
          radius: 23,
          backgroundColor: Colors.white,
          child: IconButton(
            icon: Icon(
              icon,
              color: color,
            ),
            onPressed: () {
              fct();
            },
          )),
    );
  }
void _openWhatsApp(String phoneNumber)async{
    Uri url=Uri.parse('http://wa.me/$phoneNumber?text=connect with $phoneNumber');
    if(await canLaunchUrl(url))
      {
       await launchUrl(url);
      }
}
  void _openEmail(String email)async{
    Uri url=Uri.parse('mailto:$email');

    if(await canLaunchUrl(url))
    {
      await launchUrl(url);
    }
  }

  void _openCall(String phone)async{
    Uri url=Uri.parse('tel:$phone');

    if(await canLaunchUrl(url))
    {
      await launchUrl(url);
    }
  }
  Widget userInfo({required String title, required String content}) {
    return Row(
      children: [
        Text(
          title,
          style: _titleTextStyle,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: contentTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
