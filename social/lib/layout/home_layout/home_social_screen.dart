import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home_layout/home_bloc/home_bloc.dart';
import 'package:social/layout/home_layout/home_bloc/home_events.dart';
import 'package:social/layout/home_layout/home_bloc/home_states.dart';
import 'package:social/modules/add_post/add_post_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/components/constants.dart';

class HomeSocialScreen extends StatelessWidget {
  const HomeSocialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeLayoutStates>(
      listener: (context, state) {
        if(state is HomeChangeBottomNavAndAddPostState){
          navigatorTo(context, AddPostScreen());
        }
      },
      builder: (context, state) {
        HomeBloc bloc = HomeBloc.get(context);
        double h = MediaQuery.of(context).size.height;
        double w = MediaQuery.of(context).size.width;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              bloc.appBarTitle[bloc.currentIndex],
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notification_important_outlined,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                  ))
            ],
          ),
          body: bloc.screens[bloc.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: bloc.bottomBarItems,
            currentIndex: bloc.currentIndex,
            onTap: (index) {
              bloc..add(HomeChangeBottomNaveEvent(index,));
            },
          ),
        );
      },
    );
  }
}
