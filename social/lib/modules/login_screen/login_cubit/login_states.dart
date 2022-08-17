abstract class  LoginStates{}


class LoginInitialState extends LoginStates{}


// HERE FOR LOGIN STATES
class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginStates{
  final String error;

  LoginErrorState(this.error);
}


//HERE TO CHANGE OBSECURE
class LoginChangeObSecureState extends LoginStates{}