import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home_layout/home_bloc/home_bloc.dart';
import 'package:social/layout/home_layout/home_bloc/home_states.dart';
import 'package:social/models/userDataModel.dart';
import 'package:social/models/user_model.dart';
import 'package:social/modules/chat_details/chat_datails_screen.dart';
import 'package:social/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final bloc = HomeBloc.get(context);
        final model = HomeBloc.get(context).users;
        return
          bloc.users.length>0
          ?ListView.separated(
          physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index)=>itemBuilder(context,model[index]),
            separatorBuilder: (context,index)=> defaultDivider(width: 200, height: 0.5, color: Colors.grey, padding: 2),
            itemCount: model.length):Center(child: CircularProgressIndicator(),);
      },
    );

  }
  Widget itemBuilder(context,UserDataModel model)=> InkWell(
    onTap: (){
      navigatorTo(context, ChatDetailsScreen(userDataModel: model));
    },
    child: Padding(
      padding: EdgeInsets.all(20.0),

      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                '${model.image}'),
          ),
          SizedBox(
            width: 7,
          ),
          Text(
            '${model.name}',
            style: Theme
                .of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.black),
          ),

        ],
      ),

      //defaultDivider(w,1,Colors.grey,3),

      // here for the body
    ),
  );
}
