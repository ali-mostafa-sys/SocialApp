


import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/login_screen/login_cubit/login_states.dart';
import 'package:social/shared/components/constants.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit( ): super(LoginInitialState());

  static LoginCubit get(context)=> BlocProvider.of(context);

  bool obSecure=true;

  void changeIconObSecure(){
    obSecure = !obSecure;
    emit(LoginChangeObSecureState());
  }
  void userLogin(
      {required String email,
        required String password}) async{
    emit(LoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
    uId=value.user!.uid;
    emit(LoginSuccessState(value.user!.uid));
  }).catchError((error){
    print(error.toString());
    emit(LoginErrorState(error.toString()));
  });
  }

}