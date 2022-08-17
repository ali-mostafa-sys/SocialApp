import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home_layout/home_bloc/home_bloc.dart';
import 'package:social/layout/home_layout/home_bloc/home_events.dart';
import 'package:social/layout/home_layout/home_bloc/home_states.dart';
import 'package:social/models/add_post_model.dart';
import 'package:social/shared/components/components.dart';

class FeedsScreen extends StatelessWidget {
   FeedsScreen({Key? key}) : super(key: key);
   final refreshKey=GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeLayoutStates>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        HomeBloc bloc = HomeBloc.get(context);
        double h = MediaQuery.of(context).size.height;
        double w = MediaQuery.of(context).size.width;
        return RefreshIndicator(
          key: refreshKey,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: ()async{
            await bloc..add(HomeGetPostsEvent());
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: bloc.model != null? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: w,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                          image: NetworkImage(
                              '${bloc.model!.image}'),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'communicate with friends',
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                if(bloc.userAddPostModel!.length>0)
                  ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>buildPostItem( context,  w,bloc.userAddPostModel![index],index),
                    separatorBuilder: (context,index)=>Container(),
                    itemCount: bloc.userAddPostModel!.length),
                SizedBox(height: 8,)

              ],
            ):Center(child: CircularProgressIndicator(),),
          ),
        );

      },

    );


  }
   Widget buildPostItem(context,w,UserAddPostModel? model,index) => Card(
     elevation: 10,
     clipBehavior: Clip.antiAliasWithSaveLayer,


     child: Padding(
       padding: const EdgeInsets.all(10.0),
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           // here for the title of post
           Padding(
             padding: EdgeInsets.all(4.0),

             child: Row(
               children: [
                 CircleAvatar(
                   radius: 25,
                   backgroundImage: NetworkImage(
                       '${model!.image}'),
                 ),
                 SizedBox(
                   width: 5,
                 ),
                 Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         children: [
                           Text(
                             '${model.name}',
                             style: Theme
                                 .of(context)
                                 .textTheme
                                 .bodyText1!
                                 .copyWith(color: Colors.black),
                           ),
                           SizedBox(
                             width: 5,
                           ),
                           Icon(
                             Icons.check_circle,
                             color: Colors.blue,
                             size: 16,
                           )
                         ],
                       ),
                       Text(
                         '${model.dateTime}',
                         style: Theme
                             .of(context)
                             .textTheme
                             .caption,
                       ),
                     ],
                   ),
                 ),
                 IconButton(
                     onPressed: () {}, icon: Icon(Icons.more_horiz)),
               ],
             ),

             //defaultDivider(w,1,Colors.grey,3),

             // here for the body
           ),
           defaultDivider(
               width: w,
               height: 0.5,
               color: Colors.grey,
               padding: 5),
           SizedBox(
             height: 10,
           ),
           // here for body
           Text('${model.text}',
             style: Theme
                 .of(context)
                 .textTheme
                 .subtitle1!
                 .copyWith(height: 1.0,),
             maxLines: 5,
             overflow: TextOverflow.ellipsis,
           ),
           SizedBox(height: 8,),
           Container(
             width: double.infinity,
             child: Wrap(
               children: [
                 Container(
                   height: 20,
                   child: MaterialButton(

                     onPressed: (){},
                     child:Text('#aliMostafa',
                       style: TextStyle(color: Colors.blue),) ,
                     minWidth: 1,
                     padding: EdgeInsets.zero,
                   ),
                 ),



               ],
             ),
           ),
           if(model.postImage!='')
             Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
               width: double.infinity,
               height: 170,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(5),
                 image: DecorationImage(


                   image: NetworkImage(
                     '${model.postImage}',),
                   fit:BoxFit.cover,


                 ),
               ),
             ),
           ),
           SizedBox(height: 8,),

           // here for tail
           Row(
             children: [
               Expanded(
                 child: Padding(
                   padding:  EdgeInsets.symmetric(vertical: 8),
                   child: Row(
                     children: [
                       Icon(Icons.favorite,size: 15,color: Colors.red,),
                       Text('${HomeBloc.get(context).likes![index]}',style: Theme.of(context).textTheme.caption,),
                     ],
                     // ${HomeBloc.get(context).likes![index]}
                   ),
                 ),
               ),
               Expanded(
                 child: Padding(
                   padding:  EdgeInsets.symmetric(vertical: 8),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       Icon(Icons.message,size: 15,color: Colors.amber,),
                       Text('0 comment',style: Theme.of(context).textTheme.caption,),
                     ],
                   ),
                 ),
               ),



             ],
           ),
           defaultDivider(width: w, height: 0.5, color: Colors.grey, padding: 5),
           SizedBox(
             height: 6,
           ),
           Row(
             children: [
               Expanded(
                 child: InkWell(

                     onTap: (){},
                   child: Padding(
                     padding:  EdgeInsets.symmetric(vertical: 8.0),
                     child: Row(children: [
                     CircleAvatar(
                       radius: 15,
                       backgroundImage: NetworkImage(
                           '${HomeBloc.get(context).model!.image}'),
                     ),
                     SizedBox(width: 15,),
                     Text('write a comment...',style: Theme.of(context).textTheme.caption,),
               ],),
                   ),
                 ),
               ),
               InkWell(
                 onTap: (){
                   HomeBloc.get(context)..add(HomeLiKePostEvent(postId: HomeBloc.get(context).postsId![index]));
                 },
                 child: Padding(
                   padding:  EdgeInsets.symmetric(vertical: 8),
                   child: Row(
                     children: [
                       HomeBloc.get(context).likePostAdd==true?
                       Icon(Icons.favorite,
                         color: Colors.red,size: 20,)
                           :Icon(Icons.favorite_border,
                         color: Colors.red,size: 20,),
                       Text('Like'),
                     ],
                   ),
                 ),
               )

             ],
           ),
         ],
       ),
     ),
   );

}
