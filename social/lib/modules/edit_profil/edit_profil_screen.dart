





import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/layout/home_layout/home_bloc/home_bloc.dart';
import 'package:social/layout/home_layout/home_bloc/home_events.dart';
import 'package:social/layout/home_layout/home_bloc/home_states.dart';
import 'package:social/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {

  TextEditingController name=TextEditingController();
  TextEditingController bio=TextEditingController();
  TextEditingController phone=TextEditingController();

  var formKey=GlobalKey<FormState>();


  //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeLayoutStates>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        var bloc=HomeBloc.get(context);
        var userModel=HomeBloc.get(context).model;
        name.text=userModel!.name!;
        bio.text=userModel.bio!;
        phone.text=userModel.phone!;




        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: Text('Editing Profile',
                  style: Theme.of(context).appBarTheme.titleTextStyle),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
                color: Theme.of(context).iconTheme.color,
              ),
              actions: [
                state is HomeUploadCoverImageLoadingState ?
                TextButton(onPressed: (){}, child: Container()):TextButton(
            onPressed: () {
              bloc..add(HomeUpDateUserDataEvent(name: name.text,bio: bio.text,phone: phone.text));
            },
            child: Text(
              'UPDATE',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.blue),
            ),
          ),
                SizedBox(
                  width: 7,
                )
              ]),
          body:SingleChildScrollView(
            child: Column(
              children: [
                if(state is HomeUpdateUserDataLoadingState ||state is HomeUploadCoverImageLoadingState)
                  LinearProgressIndicator(),
                Container(
                  height: 200,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            bloc.imageCover==null?
                            Container(
                              width: double.infinity,
                              height: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        '${userModel.cover}'),
                                  )),
                            ):
                            Container(
                              width: double.infinity,
                              height: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(bloc.imageCover!,scale: 1),
                                  )),
                            ),
                            IconButton(onPressed: (){

                              bloc..add(HomeImageCoverPickerEvent());
                              // if(bloc.imageCover!=null)
                              //   bloc..add(HomeUploadCoverImageEvent());
                            }, icon: CircleAvatar(
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,

                                child: Icon(Icons.camera_alt_outlined)),
                              color: Theme.of(context).iconTheme.color,),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          HomeBloc.get(context).image!=null?
                          CircleAvatar(
                            radius: 62,
                            backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage:FileImage(bloc.image!,scale: 1),
                            ),
                          ):
                          CircleAvatar(
                        radius: 62,
                        backgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage:NetworkImage('${userModel.image}'),
                        ),
                      ),
                          IconButton(onPressed: (){

                            bloc..add(HomeImageProfilePickerEvent());
                            // if(bloc.image!=null)
                            //   bloc..add(HomeUploadProfileImageEvent());
                            // Future.delayed(Duration(seconds: 2)).then((value) {
                            //   bloc..add(HomeImageProfilePickerEvent());
                            // });
                          }, icon: CircleAvatar(
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,

                              child: Icon(Icons.camera_alt_outlined)),color: Theme.of(context).iconTheme.color,)

                        ],// https://img.freepik.com/free-photo/happy-smiling-athletic-woman-with-arms-outstretched_1150-4184.jpg?size=626&ext=jpg
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        defaultTextForm(context: context,controller: name, textInputType: TextInputType.name, labelText: 'NAME', validate: (value){
                          if(value.isEmpty){
                            return 'Name must not be empty';
                          }else{
                            return null;
                          }
                        }, textStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color
                        ),
                        preIcon: Icon(Icons.person),
                          borderColor: Colors.black,
                          hintText: userModel.name.toString(),

                        ),
                        SizedBox(height: 8,),
                        defaultTextForm(context: context,controller: bio, textInputType: TextInputType.text, labelText: 'BIO', validate: (value){
                          if(value.isEmpty){
                            return 'Bio must not be empty';
                          }else{
                            return null;
                          }
                        }, textStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color
                        ),
                          preIcon: Icon(Icons.replay_circle_filled),
                          borderColor: Colors.black,
                          hintText: userModel.bio.toString(),

                        ),
                        //tttt
                        SizedBox(height: 8,),
                        defaultTextForm(context: context,controller: phone, textInputType: TextInputType.number, labelText: 'Phone', validate: (value){
                          if(value.isEmpty){
                            return 'Phone must not be empty';
                          }else{
                            return null;
                          }
                        }, textStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color
                        ),
                          preIcon: Icon(Icons.phone),
                          borderColor: Colors.black,
                          hintText: userModel.phone.toString(),

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
    );
  }
}
