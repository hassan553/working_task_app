import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:working_os_app/presentation/screens/auth/register-screen.dart';
import 'package:working_os_app/presentation/screens/home_page_screen.dart';


import 'cach_helper/shared_preferences.dart';
import 'cubit/task/task_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CatchHelper.init();

  var uId = CatchHelper.getData(key: 'uId');
  runApp(MyApp(
    uId: uId,
  ));
}

class MyApp extends StatelessWidget {
  String? uId;

  MyApp({
    Key? key,
    this.uId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit()
            ..getAllTasks()
            ..getAllUsers()
            ..getUser(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEDE7DC),
          appBarTheme: const AppBarTheme(
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarColor: Color(0xFFEDE7DC),
            ),
            color: Color(0xFFEDE7DC),
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          primaryColor: Colors.green,
        ),

         home: uId == null ?RegisterScreen():const HomePageScreen(),
      ),
    );
  }
}
