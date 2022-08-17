import 'package:flutter/material.dart';

abstract class HomeEvents{}


class OnHomeLayoutLoadingEvent extends HomeEvents{}


class HomeChangeBottomNaveEvent extends HomeEvents{
    int currentIndex=0;


  HomeChangeBottomNaveEvent( this.currentIndex,);
}

class HomeImageProfilePickerEvent extends HomeEvents{}

class HomeImageCoverPickerEvent extends HomeEvents{}


// here to upload images
class HomeUploadProfileImageEvent extends HomeEvents{}
class HomeUploadCoverImageEvent extends HomeEvents{}

class HomeUpDateUserDataEvent extends HomeEvents{
  final String name;
  final String bio;
  final String phone;

  HomeUpDateUserDataEvent({required this.name,required this.bio,required this.phone});


}
// here to add post and upload pos image
class HomeAddPostEvent extends HomeEvents{
  final String text;
  final String dateTime;

  HomeAddPostEvent({required this.text,required this.dateTime});
}
class HomeUploadPostImageEvent extends HomeEvents{
  final String text;
  final String dateTime;

  HomeUploadPostImageEvent({required this.text,required this.dateTime});
}
class HomePickPostImageEvent extends HomeEvents{}
class HomeRemovePostImageEvent extends HomeEvents{}

/// here for get posts
 class HomeGetPostsEvent extends HomeEvents{

 }

 // here for like post event

class HomeLiKePostEvent extends HomeEvents{
 final String postId;

  HomeLiKePostEvent({required this.postId});
}

class HomeGetAllUsersEvent extends HomeEvents{}

// her for send and receive message
class SendMessageEvent extends HomeEvents{
  final String text;
  final String dateTime;
  final String receiverId;
  SendMessageEvent({
    required this.text,
    required this.dateTime,
    required this.receiverId,
  });
}
class GetMessageEvent extends HomeEvents{
  final String receiverId;
  GetMessageEvent({required this.receiverId});
}
