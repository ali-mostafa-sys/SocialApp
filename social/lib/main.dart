import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home_layout/home_bloc/home_bloc.dart';
import 'package:social/layout/home_layout/home_bloc/home_events.dart';
import 'package:social/layout/home_layout/home_social_screen.dart';
import 'package:social/modules/login_screen/login_screen.dart';
import 'package:social/shared/bloc_observer.dart';
import 'package:social/shared/network/local/cache_helper/cache_helper.dart';
import 'package:social/shared/styles/themes.dart';

import 'shared/components/constants.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  
await Firebase.initializeApp();
await CacheHelper.init();

  BlocOverrides.runZoned(
        () {
      // Use blocs...
    },
    blocObserver: MyBlocObserver(),
  );
  late Widget widgets;
  uId= await CacheHelper.getStringData(key: 'uId')??null;
  if(uId!=null){
    widgets=HomeSocialScreen();
  }else{
    widgets=LoginScreen();
  }

  runApp( MyApp(widgets: widgets,));
}

class MyApp extends StatelessWidget {
  Widget widgets;
  MyApp({required this.widgets});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(


      providers: [
        BlocProvider(create: (context)=> HomeBloc()..add(OnHomeLayoutLoadingEvent())..add(HomeGetPostsEvent())..add(HomeGetAllUsersEvent())),
      ],
      child: MaterialApp(

        title: 'Flutter Demo',
        theme: lightTheme,
        home:  widgets,


        debugShowCheckedModeBanner: false,

      ),
    );
  }
}

