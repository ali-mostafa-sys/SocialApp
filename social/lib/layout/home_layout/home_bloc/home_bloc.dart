import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/layout/home_layout/home_bloc/home_events.dart';
import 'package:social/layout/home_layout/home_bloc/home_states.dart';
import 'package:social/models/add_post_model.dart';
import 'package:social/models/likes_model.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/userDataModel.dart';
import 'package:social/models/user_model.dart';
import 'package:social/modules/add_post/add_post_screen.dart';
import 'package:social/modules/chats/chats_screen.dart';
import 'package:social/modules/feeds/feeds_screen.dart';

import 'package:social/modules/settings/settings_screen.dart';
import 'package:social/modules/users/users_screen.dart';
import 'package:social/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeBloc extends Bloc<HomeEvents, HomeLayoutStates> {
  static HomeBloc get(context) => BlocProvider.of(context);
  // get message
  List<MessageModel> messages=[];
  void getMessages({
    required String receiverId,
})async{
    await FirebaseFirestore.instance.
    collection('users').doc(uId).
    collection('chats').doc(receiverId).
    collection('messages').orderBy('dateTime').snapshots().
    listen((event) {
      messages=[];
      event.docs.map((e) {
        messages.add(MessageModel.fromJson(e.data()));


      }).toString();
      emit(GetMessageSuccessState());
    });

  }

  // send message
  Future<void> sendMessage({
  required String receiverId,
  required String dateTime,
  required String text,
})async{
    MessageModel model=MessageModel(senderId: uId, receiverId: receiverId, dateTime: dateTime, text: text);
    await FirebaseFirestore.instance.
    collection('users').doc(uId).
    collection('chats').doc(receiverId).
    collection('messages').add(model.toMap())
        .then((value) {
          emit(SendMessageSuccessState());
    })
        .catchError((error){
          emit(SendMessageErrorState());
    });
    await FirebaseFirestore.instance.
    collection('users').doc(receiverId).
    collection('chats').doc(uId).
    collection('messages').add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    })
        .catchError((error){
      emit(SendMessageErrorState());
    });

}


  // GET ALL USERS

  List<UserDataModel> users=[];
  void getAllUsers(){
    users=[];
    emit(HomeLoadingGetAllUsersState());
    FirebaseFirestore.instance.collection('users').get().then((value) {

      value.docs.map((e) {
        if(e.data()['uId']!=uId){
          users.add(UserDataModel.fromJson(e.data()));
        }
      }


          ).toList();
      emit(HomeSuccessGetAllUsersState());
    }).catchError((error){
      emit(HomeErrorGetAllUsersState(error.toString()));
    });
  }

  // like post

  bool likePostAdd=false;

  Future<void> likePost(String postId) async {

    if(likePostAdd==false){
      likePostAdd=true;

      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .doc(uId)
          .set({
        'like': true,
      }).then((value) {
        emit(HomeLikePostsSuccessState());
      }).catchError((error) {
        emit(HomeLikePostsErrorState(error.toString()));
      });
    } else if(likePostAdd==true){
      likePostAdd=false;
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .doc(uId)
          .set({
        'like': false,
      }).then((value) {
        emit(HomeLikePostsSuccessState());
      }).catchError((error) {
        emit(HomeLikePostsErrorState(error.toString()));
      });
    }

  }

  // here for get posts
  List<UserAddPostModel?>?  userAddPostModel = [];
  List<String>? postsId = [];
  List<int>? likes = [];
  List<LikesModel>? likess = [];


  Future <void> getNumberOfLike()async{


  }

  // Future <void> getPosts() async {
  //   emit(HomeGetPostsLoadingState());
  //
  //   await FirebaseFirestore.instance.collection('posts').get().then((value) {
  //     value.docs.map((e) {
  //       userAddPostModel = [];
  //       postsId = [];
  //       likes = [];
  //       e.reference.collection('likes').snapshots().listen((event) {
  //         likes!.add(event.docs.length);
  //         userAddPostModel!.add(UserAddPostModel.fromJson(e.data()));
  //         postsId!.add(e.id);
  //         event.docs.map((element) {
  //           likess!.add(element.data()['likes']);
  //         }).toList();
  //       });
  //     }).toList();
  //
  //     emit(HomeGetPostsSuccessState());
  //   }).catchError((error) {
  //     emit(HomeGetPostsErrorState(error.toString()));
  //   });
  // }
  Future <void> getPosts() async {
    emit(HomeGetPostsLoadingState());

    await FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.map((e) {
        userAddPostModel = [];
        postsId = [];
        likes = [];
        likess=[];
        e.reference.collection('likes').get().then((value) {
          likes!.add(value.docs.length);
          userAddPostModel!.add(UserAddPostModel.fromJson(e.data()));
          postsId!.add(e.id);
        });
      }).toList();

      emit(HomeGetPostsSuccessState());
    }).catchError((error) {
      emit(HomeGetPostsErrorState(error.toString()));
    });
  }

  // here to add new post
  Future <void> createNewPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) async {
    emit(HomeAddPostLoadingState());
    UserAddPostModel postModel = UserAddPostModel(
        name: model!.name,
        uId: uId,
        image: model!.image,
        dateTime: dateTime,
        text: text,
        postImage: postImage ?? '');
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(HomeAddPostSuccessState());
    }).catchError((error) {
      emit(HomeAddPostErrorState());
    });
  }

  // here to upload post image
  String postImageUrl = '';

  Future<void> uploadPostImage({
    required String dateTime,
    required String text,
  }) async {
    emit(HomeUploadPostImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        postImageUrl = value;
        createNewPost(text: text, dateTime: dateTime, postImage: postImageUrl);
        emit(HomeUploadPostImageSuccessState());
      }).catchError((error) {
        emit(HomeUploadPostImageErrorState());
      });
    }).catchError((error) {
      emit(HomeUploadPostImageErrorState());
    });
  }

  // here for pick image for new post
  File? postImage;
  ImagePicker pickedPostImage = ImagePicker();

  Future getPostImage() async {
    final imagePicked =
        await pickedPostImage.pickImage(source: ImageSource.gallery);
    if (imagePicked == null) return;

    if (imagePicked != null) {
      File imageTemporary = File(imagePicked.path);
      postImage = imageTemporary;
      emit(HomePostImagePickedSuccessState());

      print('hello');
    } else {
      print('No image selected');
      emit(HomePostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(HomeRemovePostImageState());
  }

  // here for image picker profile photo

  File? image;
  ImagePicker picked = ImagePicker();

  Future getImageProfile() async {
    final imagePicked = await picked.pickImage(source: ImageSource.gallery);
    if (imagePicked == null) return;

    if (imagePicked != null) {
      File imageTemporary = File(imagePicked.path);
      image = imageTemporary;
      emit(HomeProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(HomeProfileImagePickedErrorState());
    }
  }

  // here for image picker cover photo
  File? imageCover;
  ImagePicker pickedCover = ImagePicker();

  Future getImageCover() async {
    final imagePicked =
        await pickedCover.pickImage(source: ImageSource.gallery);
    if (imagePicked == null) return;

    if (imagePicked != null) {
      File imageTemporary = File(imagePicked.path);
      imageCover = imageTemporary;
      emit(HomeCoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(HomeCoverImagePickedErrorState());
    }
  }

  //here for upload profile image
  String profileImageUrl = '';

  void uploadProfileImage() {
    emit(HomeUploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image!.path).pathSegments.last}')
        .putFile(image!)
        .then((value) {
      // here for get url of the photo
      value.ref.getDownloadURL().then((value) {
        print(value);
        profileImageUrl = value;
        print('hello');
        emit(HomeUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(HomeUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(HomeUploadProfileImageErrorState());
    });
  }

  // upload cover image
  String coverImageUrl = '';

  void uploadCoverImage() {
    emit(HomeUploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageCover!.path).pathSegments.last}')
        .putFile(imageCover!)
        .then((value) {
      // here for get url of the photo
      value.ref.getDownloadURL().then((value) {
        print(value);
        coverImageUrl = value;
        print('hello');
        emit(HomeUploadCoverImageSuccessState());
      }).catchError((error) {
        emit(HomeUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(HomeUploadProfileImageErrorState());
    });
  }

  // here to update user data
  void updateUserData({
    required String name,
    required String phone,
    required String bio,
  }) async {
    UserDataModel modelData = UserDataModel(
        name: name,
        email: model!.email,
        phone: phone,
        uId: uId,
        isEmailVerified: false,
        image: image == null ? model!.image : profileImageUrl,
        bio: bio,
        cover: imageCover == null ? model!.cover : coverImageUrl);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(modelData.toMap())
        .then((value) {
      getUserDataFromFirebase();
    }).catchError((error) {
      emit(HomeUpdateUserDataErrorState());
    });
  }

  //HERE FOR GET USER DATA MODEL
  UserDataModel? model;

  // HERE FOR BOTTOM NAVIGATION BAR
  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    AddPostScreen(),
   // UsersScreen(),
    SettingsScreen(),
  ];
  List<String> appBarTitle = ['Home', 'Chats', 'Add Post',  'Account'];

  /// here for get data from firebase
  void getUserDataFromFirebase() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      model = UserDataModel.fromJson(value.data()!);

      emit(HomeLayoutLoadingSuccessState());
    }).catchError((error) {
      //print(error.toString());
      emit(HomeLayoutLoadingErrorState(error.toString()));
    });
  }

  List<BottomNavigationBarItem> bottomBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.chat,
        ),
        label: 'Chats'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.add,
        ),
        label: 'Add Post'),
    // const BottomNavigationBarItem(
    //     icon: Icon(
    //       Icons.location_on_outlined,
    //     ),
    //     label: 'Users'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
        ),
        label: 'Account'),
  ];

  HomeBloc() : super(HomeLayoutInitialState()) {
    on<OnHomeLayoutLoadingEvent>((event, emit) async {
      emit(HomeLayoutLoadingState());

      getUserDataFromFirebase();
    });
    on<HomeChangeBottomNaveEvent>((event, emit) {
      if(event.currentIndex==1)
        getAllUsers();
      if (event.currentIndex == 2) {
        emit(HomeChangeBottomNavAndAddPostState());
      } else {
        currentIndex = event.currentIndex;
        emit(HomeChangeBottomVanState());
      }
    });
    on<HomeImageProfilePickerEvent>((event, state) async {
      getImageProfile().then((value) {
        emit(HomeProfileImagePickedSuccessState());
        uploadProfileImage();
      }).catchError((error) {
        print('${error.toString()}');
        emit(HomeProfileImagePickedErrorState());
      });
    });
    on<HomeImageCoverPickerEvent>((event, emit) {
      getImageCover().then((value) {
        uploadCoverImage();
        emit(HomeCoverImagePickedSuccessState());
      }).catchError((error) {
        emit(HomeCoverImagePickedErrorState());
      });
    });

    on<HomeUpDateUserDataEvent>((event, emit) {
      emit(HomeUpdateUserDataLoadingState());
      updateUserData(name: event.name, phone: event.phone, bio: event.bio);
      print('user data is updating');
    });
    on<HomeAddPostEvent>((event, emit) async{
     await createNewPost(text: event.text, dateTime: event.dateTime);
    });
    on<HomeUploadPostImageEvent>((event, emit) {
      uploadPostImage(dateTime: event.dateTime, text: event.text);
    });
    on<HomePickPostImageEvent>((event, emit) {
      getPostImage();
    });
    on<HomeRemovePostImageEvent>((event, emit) {
      removePostImage();
    });
    on<HomeGetPostsEvent>((event, emit)async {
     await getPosts();
    });
    on<HomeLiKePostEvent>((event, emit) {
      likePost(event.postId).then((value) {

      });
    });
    on<HomeGetAllUsersEvent>(
            (event,emit){
              getAllUsers();
            }
            );
    on<SendMessageEvent>(
        (event,emit){
          sendMessage(receiverId: event.receiverId, dateTime: event.dateTime, text: event.text);
        }
    );
    on<GetMessageEvent>(
        (event,emit){
          getMessages(receiverId: event.receiverId);
        }
    );
  }
}
