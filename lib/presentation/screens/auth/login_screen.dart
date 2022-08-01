import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:working_os_app/presentation/screens/auth/register-screen.dart';




import '../../../cubit/login/login_cubit.dart';
import '../../widgets/widget.dart';
import '../forget_password.dart';
import '../home_page_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if(state is LoginUserSuccessState)
            {
              navigateAndFinsh(context: context,screen: HomePageScreen());
            }else if(state is LoginUserErrorState){
            print(state.error);
            showSnackBar(context,state.error);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "https://media.istockphoto.com/photos/businesswoman-using-computer-in-dark-office-picture-id557608443?k=6&m=557608443&s=612x612&w=0&h=fWWESl6nk7T6ufo4sRjRBSeSiaiVYAzVrY-CLlfMptM=",
                    placeholder: (context, uri) {
                      return Image.asset(
                        'assets/images/wallpaper.jpg',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                      );
                    },
                    errorWidget: (context, uri, error) {
                      return Image.asset(
                        'assets/images/wallpaper.jpg',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                      );
                    },
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Text(
                            'Login',
                            style: styles(
                              color: Colors.white,
                              font: 30,
                              bold: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Don\'t have an account? ',
                                style: styles(
                                  color: Colors.white,
                                  font: 15,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateAndFinsh(
                                    context: context,
                                    screen: RegisterScreen(),
                                  );
                                },
                                child: Text(
                                  'SIGN UP ',
                                  style: styles(
                                    color: Colors.blue,
                                    font: 15,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                buildTextField(
                                  controller: emailController,
                                  keyboard: TextInputType.emailAddress,
                                  textLabel: 'Email',
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                buildTextField(
                                  controller: passwordController,
                                  keyboard: TextInputType.visiblePassword,
                                  textLabel: 'Password',
                                  obscure: cubit.obscure,
                                  passwordIcon: IconButton(
                                    onPressed: () {
                                      cubit.changeIcon();
                                    },
                                    icon: cubit.obscure
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: defaultColor,
                                          )
                                        : Icon(
                                            Icons.visibility,
                                            color: defaultColor,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {
                                navigateAndFinsh(
                                  context: context,
                                  screen: ForgetPasswordScreen(),
                                );
                              },
                              child: Text(
                                'Forget password?',
                                style: styles(
                                  font: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubit.loginUser(email: emailController.text,password: passwordController.text,);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(
                                    13,
                                  )),
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 40,
                              child: Text(
                                'Login',
                                style: styles(
                                  font: 17,
                                  bold: FontWeight.bold,
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
      ),
    );
  }
}
