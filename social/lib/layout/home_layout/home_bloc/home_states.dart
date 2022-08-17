abstract class HomeLayoutStates{}


class HomeLayoutInitialState extends HomeLayoutStates{}


//HERE WHEN LOADING THE HOME LAYOUT
class HomeLayoutLoadingState extends HomeLayoutStates{}

class HomeLayoutLoadingSuccessState extends HomeLayoutStates{}

class HomeLayoutLoadingErrorState extends HomeLayoutStates{
  final String error;

  HomeLayoutLoadingErrorState(this.error);
}


class HomeChangeBottomVanState extends HomeLayoutStates{}
class HomeChangeBottomNavAndAddPostState extends HomeLayoutStates{}


// here for profile image picker
class HomeProfileImagePickedSuccessState extends HomeLayoutStates{}
class HomeProfileImagePickedErrorState extends HomeLayoutStates{

}
// here for cover image picker
class HomeCoverImagePickedSuccessState extends HomeLayoutStates{}
class HomeCoverImagePickedErrorState extends HomeLayoutStates{

}

// HERE FOR UPLOAD PROFILE/COVER IMAGE
class HomeUploadProfileImageLoadingState extends HomeLayoutStates{}
class HomeUploadProfileImageSuccessState extends HomeLayoutStates{}
class HomeUploadProfileImageErrorState extends HomeLayoutStates{}

class HomeUploadCoverImageLoadingState extends HomeLayoutStates{}
class HomeUploadCoverImageSuccessState extends HomeLayoutStates{}
class HomeUploadCoverImageErrorState extends HomeLayoutStates{}

class HomeUpdateUserDataErrorState extends HomeLayoutStates{}
class HomeUpdateUserDataLoadingState extends HomeLayoutStates{}

// HERE TO ADD NEW POST

class HomeAddPostLoadingState extends HomeLayoutStates{}
class HomeAddPostSuccessState extends HomeLayoutStates{}
class HomeAddPostErrorState extends HomeLayoutStates{}
// here for post image picked
class HomePostImagePickedSuccessState extends HomeLayoutStates{}
class HomePostImagePickedErrorState extends HomeLayoutStates{}
class HomeRemovePostImageState extends HomeLayoutStates{}
// here to upload post image
class HomeUploadPostImageLoadingState extends HomeLayoutStates{}
class HomeUploadPostImageSuccessState extends HomeLayoutStates{}
class HomeUploadPostImageErrorState extends HomeLayoutStates{}


// here for get posts

class HomeGetPostsLoadingState extends HomeLayoutStates{}
class HomeGetPostsSuccessState extends HomeLayoutStates{}
class HomeGetPostsErrorState extends HomeLayoutStates{
  final String error;

  HomeGetPostsErrorState(this.error);
}

// here for like post
class HomeLikePostsSuccessState extends HomeLayoutStates{}
class HomeLikePostsErrorState extends HomeLayoutStates{
  final String error;

  HomeLikePostsErrorState(this.error);
}

// here to get all users
class HomeLoadingGetAllUsersState extends HomeLayoutStates{}
class HomeSuccessGetAllUsersState extends HomeLayoutStates{

}
class HomeErrorGetAllUsersState extends HomeLayoutStates{
  final String error;

  HomeErrorGetAllUsersState(this.error);
}

/// sent and receive message

class SendMessageSuccessState extends HomeLayoutStates{}
class SendMessageErrorState extends HomeLayoutStates{}
class GetMessageSuccessState extends HomeLayoutStates{}
class GetMessageErrorState extends HomeLayoutStates{}