import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social/layout/home_layout/home_social_screen.dart';
import 'package:social/modules/login_screen/login_screen.dart';
import 'package:social/modules/register_screen/register_cubit/register_cubit.dart';
import 'package:social/modules/register_screen/register_cubit/register_states.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/network/local/cache_helper/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          print(state);
          if(state is RegisterCreateUserSuccessState){
            CacheHelper.putStringData(key: 'uId', value: state.uId.toString()).then((value) {
              uId=state.uId.toString();
              navigatorReplace(
                  context, HomeSocialScreen());
            }).catchError((error){});

          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            body: SizedBox(
              height: h,
              width: w,
              child: Stack(
                children: [
                  Container(
                    decoration:const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.blue,


                            Colors.white,
                          ],
                        )
                    ),
                  ),
                  Center(
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Form(
                              key: formKey,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Register',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: h * 0.01,
                                    ),
                                    Text(
                                      'Register now to communicate with your friends',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    defaultTextForm(
                                      context: context,
                                        radius: 10,
                                        borderColor: Colors.white,
                                        controller: nameController,
                                        textInputType: TextInputType.text,
                                        labelText: 'Name',
                                        textStyle: TextStyle(
                                            color: Colors.white),
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return 'Name most n\'t be empty';
                                          } else {
                                            return null;
                                          }
                                        },
                                        preIcon: Icon(
                                          Icons.person,
                                          color:Colors.white,
                                        )),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    defaultTextForm(
                                        context: context,
                                        radius: 10,
                                        borderColor: Colors.white,
                                        controller: emailController,
                                        textInputType:
                                            TextInputType.emailAddress,
                                        labelText: 'Email',
                                        textStyle: TextStyle(
                                            color: Colors.white),
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return 'Email most n\'t be empty';
                                          } else {
                                            return null;
                                          }
                                        },
                                        preIcon: Icon(
                                          Icons.email_outlined,
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    defaultTextForm(
                                        context: context,
                                        radius: 10,
                                        borderColor: Colors.white,
                                        controller: phoneController,
                                        textInputType: TextInputType.phone,
                                        labelText: 'Phone',
                                        textStyle: TextStyle(
                                            color:Colors.white),
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return 'Phone most n\'t be empty';
                                          } else {
                                            return null;
                                          }
                                        },
                                        preIcon: Icon(
                                          Icons.phone,
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    defaultTextForm(
                                      context: context,
                                      radius: 10,
                                      borderColor: Colors.white,
                                      controller: passwordController,
                                      textInputType: TextInputType.text,
                                      labelText: 'Password',
                                      obSecure: cubit.obSecure,
                                      textStyle:
                                          TextStyle(color: Colors.white),
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'Password most n\'t be empty';
                                        } else if (value.length < 6) {
                                          return 'Password most be more than 6 characters ';
                                        } else {
                                          return null;
                                        }
                                      },
                                      preIcon: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            cubit.changeIconObSecure();
                                          },
                                          icon: cubit.obSecure
                                              ? Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.white,
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color: Colors.white,
                                                )),
                                    ),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    defaultTextForm(
                                      context: context,
                                      radius: 10,
                                      borderColor: Colors.white,
                                      controller: rePasswordController,
                                      textInputType: TextInputType.text,
                                      labelText: 're-Password',
                                      obSecure: cubit.obSecure,
                                      textStyle:
                                          TextStyle(color: Colors.white),
                                      validate: (value) {
                                        if (value != passwordController.text) {
                                          return 'The password must match ';
                                        } else if (value.isEmpty) {
                                          return 'Password most n\'t be empty';
                                        } else if (value.length < 6) {
                                          return 'Password most be more than 6 characters ';
                                        } else {
                                          return null;
                                        }
                                      },
                                      preIcon: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            cubit.changeIconObSecure();
                                          },
                                          icon: cubit.obSecure
                                              ? Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.white,
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color: Colors.white,
                                                )),
                                    ),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    defaultButton(
                                        context: context,
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.userRegister(
                                                name: nameController.text,
                                                phone: phoneController.text,
                                                email: emailController.text,
                                                password:
                                                    passwordController.text);
                                          }
                                        },
                                        text: 'Register',
                                        fontSize: 30,
                                        internalPadding: 15,
                                        textColor: Colors.blue,
                                        borderRadiusOfButton: 10,
                                        fitColor: Colors.white),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'I have an account ?',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              navigatorTo(
                                                  context, LoginScreen());
                                            },
                                            child: Text(
                                              'Login Now !!',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 17,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                  Colors.white,
                                                  decorationStyle:
                                                      TextDecorationStyle.solid,
                                                  decorationThickness: 2,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
