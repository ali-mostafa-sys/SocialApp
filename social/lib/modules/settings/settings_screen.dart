import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home_layout/home_bloc/home_bloc.dart';
import 'package:social/layout/home_layout/home_bloc/home_states.dart';
import 'package:social/modules/edit_profil/edit_profil_screen.dart';
import 'package:social/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = HomeBloc.get(context).model;
        return SingleChildScrollView(
          child: Padding(

            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    '${userModel!.cover}'),
                              )),
                        ),
                      ),
                      CircleAvatar(
                        radius: 62,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              '${userModel.image}'),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '${userModel.name}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  '${userModel.bio}',
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text('3'),
                              Text(
                                'Post',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text('2'),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text('0'),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text('0'),
                              Text(
                                'Followings',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: defaultButton(
                          context: context,
                          onPressed: () {},
                          text: 'Add Photos',
                          fontSize: 15,
                          fitColor: Colors.blue,
                          borderRadiusOfButton: 5),
                    ),
                    SizedBox(width: 6,),
                    OutlinedButton(onPressed: (){
                      navigatorTo(context,EditProfileScreen());
                    }, child: Icon(Icons.edit))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
