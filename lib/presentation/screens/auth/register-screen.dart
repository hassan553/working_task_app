import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


//data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAkFBMVEX///+23P5HiMc4gcTK2eyjzPNEhsa74P8xfsM/g8S63//1+Ps2gMSZuNw3gcS94v/R3++Ht+Ww1/uXw+2iv+Ds8vmPveni6/WBsuJRj8tim9NsoteyyuWs1Pnc5/N1o9Ncl9C+0ummwuFwpdmGrdeFrNfB1OpXkcudyPB4q922zObN3O1hl810otKaut7B5v+DB68mAAAO5UlEQVR4nO1daZuiOBBuSBsIRPFWxFu70dZ2//+/W6gKh4oHEAzu9vthdmaeHZqXJHWn6uPjD3/4wx/+K7BH83b78Hloz0e26neRDHu+6i+W1OSctwghwX9Melys56rfSw7sw8nlnDBKqZ5C8EfGuTcdqH6/krCnv4wz/SYo4YuD6pcsgc9fk9Db9ARJ7n6rftFisE86T9Oj4b6McbZl+fENT6R94owm5AJO7tIbd4a93a6x6/WGY88P/jL+H8yt6hfOi1Pq7YPfep1d1zIMC6DBr4ahNcY+iz4Dc0eq3zkPVjTmx8iy0wi5aRmwnNlYZ9Eyvs9pHHgtGi2fO54ZmeRiktbQFRzNvuo3fxKrmB/xdvfpCY4dsVXNk+p3fwpbIUAp8x4sX8KxO8Fl5GvVb/8Y9pEIfsuG8xQ9gDHGf2Z+qibwCCOh5qjey8EvgDNkqP1rbsSNhAXDPO25/ZlaxR5SPKrmcBcjJvR7zgVEikPYqHyqmsUdDARBd5Z3AQHOnsEBrq/naOuwRdmkCL0Qlgv//mu1OtTTQfaRoFdoAYFhg6AaDVxk4jdr51QtGBI0ihIM9qmXOByBe6yfamWq9nlpgprWOPOVKTN/68NxDgTpsvAWBRhL/Rw18qrEG5XiF5zEnhkcwjP/mNG2am6AJh7CRrklDNANMGv0xhMaOY7UrIOxOsJDOCx1CFMI/ePdJnIy+Zdqfh8fRwqHsIAlc4el0R2LdSQL1QQ/cQlnMgmGMCKviqiWNz4Q7Mjaoyk4nVo4jt+whG5pKZOFwOWAnWoqlai4hL1KGAamHEWHUyHBthm+gl/BHkWKPbBWWVMdwwWtcAkDOGM4i6YyA86u8BQijCUoI2VacUpAkFbIUJupXUT4wKxbIUHN2FOFJ3EQblI6kWrOXKGL8Q01DHGTSpIzt55ibMJFJGoSGyBJqYxN6nj67tZWANeYqjFP4UcvJShDa8h04nWzlxGDVEQFQfDt2VjCJu3CZqDDzGW0QNZwFaYbHsNGeYKo9AJxMsk6jdYu3CtMhf29DX8yKb+EwnCBgHJWpMBSdhDB6vZL6woR0hehmd71sXaWisxvOwwZ0U1ZQWNg5kkXPj3rXH0yPIjk9aFwCNCUNtkcsYJ8qouwxfiSogXfgL++KKXNJej76Ayaqw/bQ67skiKKGvL6BOpKgii1NoIgSMomx1W8jImA9U1+Xs5wzcqa3cZMlGJwUYnRFxSH5xujq0hdQCSYliDoxHUYcWZ0auoZ4WUwCNjrizVCdUiLx/KdxlJkVXnKqhYULx4bCiH2+qjiV6gsivr3RnfDosqUMyF5wjTPJH0ULZcq8fNDhrpbSB0a3X2UmiDHCz23xeBT+igarhqjBnwnN79JYxkNL0m9XFd7HTGfnBJhxhutoWUZs7EbVdZSssxQ4zbQT+9T6z3OYUDO6vb2blKayVh2dcknSBu2Sx6tqwnVPJClUEbqICwtzAt6LksKa3VmNm9Zml/wEZIDgNri9dWLmBnNZhcs166z3yxdN1yqqPg5cSEoITf5Rfs0MQhV2TR90PjXNo3laMONC+nqcB/r16Ccru96CuBbx8kCZXbpD9ill4lDSxsuCcviJdgxzr4elsvAh4lOovAtXh8U/iYX8gD4jfWb9ChlxNSfqgYCqz6KxCrzDzEQdWYkO70zfsEuja4hEMJN3Tt9P1tgSVPRdGNC1fj4g1ZI4izUFmvyYDMSHqg9/7j4+vraNvvT73au6lE45MK9dsI9q6Q0E35wqhCqG5WlU8KXzdW8zLYamCmtT9SoQ1Gul9JarjCl+XJa/swck226U6QsLqOJhiDIj1Jit1MWqUSroyhME72ECGMYe+GuS/rWEOei+4ChAVWLXM5j86GdEqaolYOTKU1rhUILCpEgb0GXsp6bBzZIg72BexSFjDylhYktK4rSqKkbgpMHtpWF1fYy7Q7UFzPxaLKS9+Qc+IqjbZhbITLN/28RrBSpJzWJ/J/YbgPrX67ZEQWcHVf6o59HLO9QoMuNaI6EHMM8vqpyE7AefQctR13urZ4BpkXwypASfR9iIQwPS5cv0EFSBwyhUMFUdSUKD+LQgmMoOSgtGBrgKvpSH50DWFDjOWg5yi0IEQyr+Hg5MEcRWkmCTzDsgLXrK6r6auOVUdZAhnLPCjIcLoW/ouTS/iC6E7sHhpKlgbAJI4+aq7jvtYgcXhe2kin3HZChGwUNmAKNODDjeMykKoapYGTr9Yv4kyoS0atiqMc0FcRLm+xFDPEwKojqQ+7J39DKGRKIACnwEMFk83escob+P4oypJhdc+LLdFUxDCw3RRlSUYuxr5zhTFNU6i2KL+PbrRUxpEunociBagsHzq+WIRviFS8FJbS2yA8NWbUMNQcvPSgw2yDwTjStUoaBb9aFT+lJffpzwMK2sSNUYjUM2Q7LF4mKnhmYH9ItIWsqskstqPnSlfgWH79wPjr/YCF6NQzHuISKgm1tvAPcxYB3JQxZF692qfGAo3vcEwjaVuMfTnCDKJEzIeb4nTuVecBsqPqKJVYv0WVluxSPuMJrsnaqvWV1HrCu8qrzwXwBQ1Npd0xRfK5LjyYO4gebqpIWAs3oTSSn+Ebxc5W3VOyboghD7l7Cvj46NWvQ4uwTi2IlB8M+IZRH9Fo04bGhsuZGxW9RYC3LqS6tzSool8CvJvWRZQDBMLm1db7SvOEVwLZpSX0kl78tygCiUlKFKfgtStzebGA1rcxajLWycr0bgCo0mS5O6Jip6hWRiV/JkQasEFDe5ysFKD2XeGzgYCsqZssG9OKRWFEDYWY10adbgDJXaW4OSFL6K+lpcvDdkhkRg8wdr1n7ayqxOmuEkVgpz5IHjIDLWURYQlKHvpdpYN8vKToa47CmhCfJBd5lk2F++4ruGz4C3hqUcBthDbmmOvb2xluDrbLCBgM0vE7aPoZLZah9OU+pBhjkJ+UC1Fvp9xpkoklKb7Ap7FGp9xqkwi/bUhVvqtd4DsQA8hi0VVQrHrArBqvxLA/MY1BSbBUPvAZtdR8Bz1GxAU4rTMaYtVQUCbYYjS/QwRkbt+i16MN+FxHFnEa4/Suafr3B4CdBkbl55E1bTCjjCrsiP4++SG6aT7+tvTUvW0bVGz+iEIzpzwmNddTShb3NhLmoBpxy9yFH+0ePqgFUNu7OiVSVO6H9e/p71GRJtcN7MgxHxhx/skkOpkszXfH/dgzjxaGE69tLkoOtngzzpMrby+dEE696eWYyjpTRc+UxTzUdoqaHV0bfjKEZaLnfZCDw+dCYdUKe8d/AEDXfk2EgSbYk3qzE/cHgi/3jRleKKCFb8HbflmGA718uSFJi+ovFwjXjP7d+Iw34zgyDNftcxBVOqRHdfPGZBNTem+FH2NTysn3URS3Q2zP8GHnnc6z5xVy192cYCNaFGc6Rx55fi0s//r/AMDiP383F0T8uTt/XAW1g+Aa+4Yfdnp4WR4jq5kut4LXf46L5k68r2CthH/oLZnLChLjMzzAUtIy0zNZv/1C7tMVofSQ8NdmvGMPExmtx/1SjkNuo75rXzQRLMESWnG1rQdK+cIHC/HThXXpFUr/rXb4Coy1P1euHmoAR3QdJk+tOJNx9p66vE3a21wPv8kqxvBLzlO8QvAzTl/thQ7McuCdE6fPSwsZWkD3H6jaG+6We7udKTV9VVcY88f/CtZt0GppjYfs2uCeUo9ANZ+Vi32XLcrRGZ5JaS9ryVUwIHiwSfkzf9CwjaYMpGtSRZzX4CV38VDNUy9B6m6RXKOXeyzOKzYgfpcTracZ5U2gHWmU8m9UXyQ7vvDl4SHJCooWkL44Vf0cRTsrovutk9LwWGuOZJMQaNYV7/RDL6e7jybKMve442ouoNQ3Th1pm03IxaFvnjwuZRRaAZM/bNbROtFkpX7zI0jnEIWq9Y92cJibGq5AHHZDmoq8ruTlv17I6evQD2UskzilewPHNaWkhxTGJDtCd1t1b8bCrwSRnHLVoeC59PhdSGNE4GMoms/tN9R1BUWetZvY6jpotMeOCXI8IOv9cs0k0IPhymIJsjMSGofTxFGejF5kDjPvry1zbvO9H5gKluyceJmw6SivVG58t/DFscmMO3BmsaJAM2tFec7o6tOftw2rd9FhiDTF/9szDohnIOq8wQxXFk1j2ELjrt9L2qcg2hb7enIcj1FNG2dPD6ZIGFZVlGcV1Suo+OIEpGI0lufKrUqDk0XE+e5jYqVXNeRalBNkj7m5/+YbHbnSiD5T5ppFnyomlifE7GbNNJECsINvknZ5jdDtLxuhZAABt9Rvmwj2Om+qmdQvb6nou2jPv5XQDn8iNR10Q5k72PS3L2nuEeI6Z9LMoynnIkzLmmmRgSGuzxq7X6+0as3DIR8FBSk4H1WyhoqQ7aPNcQvQOUasotUuKcu99YUneHePxlRAU5RZKY1nl1eA+RRBnUWYhMba5ZPt6EAwookSVd8f0BxvReHXYoggxflZWGeMIY5l+lTPUcwMb+Ze+GYCAQ0j1Smeo5wX2n5ZUL92/CoTVAdGwAgmKH2941EfKRBBd1Ej5fYrT+up1CBEYdi59D3OFS5gdCFMKEXbmZYNTOCBsXx9FkUDsU7ccQbhIphcdN1o19Nw5ritcDuqrF7DdfbnrtHhtclk3ORoBe+GV6gMALkXJ0dQVApVimUVcp6f01REGtCYo0XwBT3JtlzBexGVRgp+85ksYncTC7j7knutmkJ5DiNOCfQBw+kGxwdSvg16i8WZ6kGRtYexLaH2QU6xWbmEGZqSwn4j9N2oUusiGAd1TC/WlXLMaG2wJcCRaoW2KHXxVE3gMHGtXwE0U46rqvkkDlYh2TX6G32LkmGoCD2GNoeVI/vq+rRgiWX80Cs4m9Ovs+p6jWLwG+5Nt6n8Mo8HdNC/D9CzcmgMPYu4uXGfzjOsNMW42b10fChrVL/8ccEhi3uKF4/lc8VrDKtRJjdL30PchQOfnNb5xTs6z1UqKAcPJ8wpTMaz2PdbQGBeYJgR9c+m48R4YF5hHfGhhucN7AMvm81mmnxfzG98AOcf1rt6QYb648OUMzjdATjd/apJ3Q85avtHn+6GmnQj/8Ic//B/wL/mzEsUK2Li8AAAAAElFTkSuQmCC
import '../../../cach_helper/shared_preferences.dart';
import '../../../cubit/register/register_cubit.dart';
import '../../widgets/widget.dart';
import '../home_page_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var companyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterUserSuccessState) {
            navigateAndFinsh(
              context: context,
              screen: HomePageScreen(),
            );
           CatchHelper.setData(key: 'id',value: state.id,);
           print('user id ${state.id}');
          } else if (state is RegisterUserErrorState) {
            print(state.error);
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
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
                            'Sign Up',
                            style: styles(
                              color: Colors.white,
                              font: 30,
                              bold: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Already have an account? ',
                                style: styles(
                                  color: Colors.white,
                                  font: 15,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateAndFinsh(
                                    context: context,
                                    screen: LoginScreen(),
                                  );
                                },
                                child: Text(
                                  'Login ',
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
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: buildTextField(
                                        controller: nameController,
                                        keyboard: TextInputType.name,
                                        textLabel: 'Full name',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              13,
                                            ),
                                            child: cubit.profileImage == null
                                                ? Image.asset(
                                                    'assets/images/wallpaper.jpg',
                                                    width: 70,
                                                    height: 70,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.file(
                                                    cubit.profileImage!,
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                          Positioned(
                                            right: -7,
                                            top: -10,
                                            child: IconButton(
                                              onPressed: () {
                                                RegisterCubit.get(context)
                                                    .getImageGallery();
                                              },
                                              icon: Icon(
                                                Icons.camera_alt_outlined,
                                                color: defaultColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
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
                                  obscure: true,
                                  passwordIcon: const Icon(
                                    Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                buildTextField(
                                  controller: companyController,
                                  keyboard: TextInputType.text,
                                  textLabel: 'Job title ',
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                buildTextField(
                                  controller: phoneController,
                                  keyboard: TextInputType.phone,
                                  textLabel: 'Phone number  ',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubit.registerUser(
                                  password: passwordController.text,
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  jobTitle: companyController.text,
                                );
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
                                'SIGN UP ',
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
