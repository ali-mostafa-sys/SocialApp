abstract class  RegisterStates{}


class RegisterInitialState extends RegisterStates{}


// HERE FOR LOGIN STATES
class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{}

class RegisterErrorState extends RegisterStates{
  final String error;

  RegisterErrorState(this.error);
}


//HERE TO CHANGE OBSECURE
class  RegisterChangeObSecureState extends  RegisterStates{}


// HERE FOR CREATE USERS
class RegisterCreateUserSuccessState extends RegisterStates{
  final String uId;

  RegisterCreateUserSuccessState(this.uId);
}

class RegisterCreateUserErrorState extends RegisterStates{
  final String error;

  RegisterCreateUserErrorState(this.error);
}