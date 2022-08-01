import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widgets/widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Forget Password ',
                    style: styles(
                      color: Colors.white,
                      font: 30,
                      bold: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      controller: passwordController,
                      validator: (dynamic value) {
                        if (value.isEmpty) {
                          return 'not valid ';
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: defaultColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        print('Done ');
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
                        'Reset now',
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
      )),
    );
  }
}
