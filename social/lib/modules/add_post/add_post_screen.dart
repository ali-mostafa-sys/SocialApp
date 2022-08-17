import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home_layout/home_bloc/home_bloc.dart';
import 'package:social/layout/home_layout/home_bloc/home_events.dart';
import 'package:social/layout/home_layout/home_bloc/home_states.dart';
import 'package:social/shared/components/components.dart';

class AddPostScreen extends StatelessWidget {
  TextEditingController text=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeLayoutStates>(
        listener: (context, state) {
          if(state is HomeAddPostSuccessState){
            Navigator.pop(context);
            HomeBloc.get(context)..add(HomeGetPostsEvent());
            if(state is HomeGetPostsSuccessState){

            }
          }
        },
        builder: (context, state) {
          var bloc = HomeBloc.get(context);
          var model = HomeBloc.get(context).model;
          return Scaffold(
            appBar: defaultAppBar(
                title: const Text('Create Post'),
                context: context,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Theme.of(context).iconTheme.color,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      var dateTime=DateTime.now();
                      print(dateTime);
                      if(bloc.postImage==null){
                        bloc..add(HomeAddPostEvent(text:text.text ,dateTime:dateTime.toString() ));
                      }else{
                        bloc..add(HomeUploadPostImageEvent(text:text.text ,dateTime:dateTime.toString() ));
                      }
                    },
                    child: Text(
                      'POST',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.blue),
                    ),
                  ),
                ]),

            body: SingleChildScrollView(
              child: Padding(

                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    if(state is HomeAddPostLoadingState || state is HomeGetPostsLoadingState || state is HomeUploadPostImageLoadingState)
                      LinearProgressIndicator(),
                    if(state is HomeAddPostLoadingState)
                      SizedBox(
                        height: 10,
                      ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage('${model!.image}'),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${model.name}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                'Public ',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.75,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: double.infinity,

                                child: TextField(
                                 minLines: 7,
                                  maxLines: 9,
                                  style: Theme.of(context ).textTheme.bodyText1,
                                  controller: text,
                                  decoration: InputDecoration(
                                    hintText: 'What is on your mind',
                                    hintStyle: Theme.of(context).textTheme.caption,
                                    border:  InputBorder.none,
                                  ),

                                ),
                              ),

                              if(bloc.postImage!=null)
                                Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 160,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5)),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(bloc.postImage!,scale: 1),
                                          )),
                                    ),
                                    IconButton(onPressed: (){

                                      bloc..add(HomeRemovePostImageEvent());

                                    }, icon: CircleAvatar(
                                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

                                        child: Icon(Icons.close )),
                                      color: Theme.of(context).iconTheme.color,),
                                  ],
                                ),
                              SizedBox(
                                height: 15,
                              ),

                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: (){
                                      bloc..add(HomePickPostImageEvent());
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image,
                                          color: Theme.of(context).iconTheme.color,
                                        ),
                                        SizedBox(width: 5,),
                                        Text('Add Photo',
                                          style: Theme.of(context).textTheme.subtitle1,
                                        )
                                      ],
                                    ),
                                  ),
                                ),



                                Expanded(
                                  child: TextButton(
                                    onPressed: (){},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.tag,
                                          color: Theme.of(context).iconTheme.color,
                                        ),
                                        SizedBox(width: 5,),
                                        Text('tags',
                                          style: Theme.of(context).textTheme.subtitle1,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )

                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
          );
        });
  }
}
