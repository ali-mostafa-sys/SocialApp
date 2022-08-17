import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home_layout/home_bloc/home_bloc.dart';
import 'package:social/layout/home_layout/home_bloc/home_events.dart';
import 'package:social/layout/home_layout/home_bloc/home_states.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/userDataModel.dart';
import 'package:social/shared/components/constants.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserDataModel userDataModel;
  ChatDetailsScreen({Key? key, required this.userDataModel}) : super(key: key);
  TextEditingController messageController=TextEditingController();
  ScrollController _scrollController=ScrollController();


  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context){
          HomeBloc.get(context)..add(GetMessageEvent(receiverId: userDataModel.uId.toString()));
          return BlocConsumer<HomeBloc, HomeLayoutStates>(
            listener: (context,state){
              if(state is GetMessageSuccessState){
                //_scro
                _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 3), curve: Curves.easeOut);



              }
            },
            builder: (context,state){
              final model=userDataModel;
              final bloc=HomeBloc.get(context);


              String messageText=messageController.text.toString();
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.blue,
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20 ,
                        backgroundImage: NetworkImage(model.image.toString()),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(model.name.toString(),style: TextStyle(color:Colors.white),),
                    ],
                  ),
                  leading:IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },

                      icon:Icon(Icons.arrow_back
                      ,color: Colors.white,
                      ),
                    color: Colors.blue,
                  ),

                ),
                body:
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        bloc.messages.length>0?
                       Expanded(
                         child: ListView.separated(

                           controller: _scrollController,
                               //.animateTo(position.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeOut),

                           physics: BouncingScrollPhysics(),
                             itemBuilder: (context,index){
                               var message=bloc.messages[index];
                               if(uId==message.senderId)
                                 return buildMessage(message);
                             return  buildMyMessage(message);

                             },
                             separatorBuilder: (context,index)=>SizedBox(height: 10,),
                             itemCount: bloc.messages.length),
                       ):Expanded(child: Container(),),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Type your message here...'
                                    ),
                                  )),
                              Container(
                                height: 50,
                                color: Colors.blue,

                                child: MaterialButton(

                                  onPressed: (){

                                    bloc..add(SendMessageEvent(
                                        text: messageController.text.toString(),
                                        dateTime: DateTime.now().toString(),
                                        receiverId: model.uId.toString()));
                                    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                                    messageController.text=messageText;
                                  }

                                  ,child: Icon(
                                  Icons.send,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              );
            },

          );
        },


    );
  }
  Widget buildMessage(MessageModel message)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5
      ),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(10),
            bottomEnd: Radius.circular(10),
            bottomStart: Radius.circular(10),

          )
      ),
      child: Text(message.text.toString()),
    ),
  );
  Widget buildMyMessage(MessageModel message)=> Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5

      ),
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(10),
            bottomEnd: Radius.circular(10),
            bottomStart: Radius.circular(10),

          )
      ),
      child: Text(message.text.toString()),
    ),
  );
}
