import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/userDataModel.dart';
import 'package:social/modules/register_screen/register_cubit/register_states.dart';
import 'package:social/shared/components/constants.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool obSecure = true;

  void changeIconObSecure() {
    obSecure = !obSecure;
    emit(RegisterChangeObSecureState());
  }

  void userRegister(
      {required String name,
      required String phone,
      required String email,
      required String password}) async{
    emit(RegisterLoadingState());
   await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
     print(value.user!.uid);
     print(value.user!.email);
     createUserData(name: name, phone: phone, email: email, uId: value.user!.uid);
    // emit(RegisterSuccessState());
   }).catchError((error){
     print(error.toString());
     emit(RegisterErrorState(error.toString()));
   });
  }


  void createUserData({
    required String name,
    required String phone,
    required String email,
    required String uId,
  })async{
    UserDataModel model=UserDataModel(name: name, email: email, phone: phone, uId: uId,isEmailVerified: false,image: 'https://img.freepik.com/free-photo/happy-smiling-athletic-woman-with-arms-outstretched_1150-4184.jpg?size=626&ext=jpg',bio: 'write your bio..',cover: 'https://img.freepik.com/free-photo/happy-smiling-athletic-woman-with-arms-outstretched_1150-4184.jpg?size=626&ext=jpg');
   await FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {
     uId=uId;
      emit(RegisterCreateUserSuccessState(uId.toString()));
    }).catchError((error){

      emit(RegisterCreateUserErrorState(error.toString()));
    });

  }
}
