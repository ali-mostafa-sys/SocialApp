import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social/layout/home_layout/home_social_screen.dart';
import 'package:social/modules/login_screen/login_cubit/login_cubit.dart';
import 'package:social/modules/login_screen/login_cubit/login_states.dart';
import 'package:social/modules/register_screen/register_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/network/local/cache_helper/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginSuccessState){

            CacheHelper.putStringData(key: 'uId', value: state.uId.toString()).then((value) {
              uId=state.uId.toString();
              navigatorReplace(
                  context, HomeSocialScreen());
            }).catchError((error){});


            navigatorTo(
                context, HomeSocialScreen());
          }else if(state is LoginErrorState){
            defaultToast(msg: state.error.toString(), backgroundColor: Colors.red, textColor: Colors.white);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.person,size: 70,color: Colors.blue[300],),
                                    )
,
                                    SizedBox(
                                      height: h * 0.01,
                                    ),

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
                                            color: Colors.white
                                        ),
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
                                      controller: passwordController,
                                      textInputType: TextInputType.text,
                                      labelText: 'Password',
                                      obSecure: cubit.obSecure,
                                      textStyle:
                                          TextStyle(color: Colors.white),
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'Password most n\'t be empty';
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
                                          cubit.userLogin(email: emailController.text, password: passwordController.text);
                                          }
                                        },
                                        text: 'Login',
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
                                          'Don\'t have an account ?',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              navigatorTo(
                                                  context, RegisterScreen());
                                            },
                                            child:const Text(
                                              'Register Now !!',
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
