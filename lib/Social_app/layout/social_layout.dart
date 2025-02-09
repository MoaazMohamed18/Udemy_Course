import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Social_app/cubit/states.dart';
import 'package:todo/Social_app/modules/new_post/new_post_screen.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/styles/icon_broken.dart';
import '../cubit/cubit.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(IconBroken.Notification),),
              IconButton(onPressed: () {}, icon: const Icon(IconBroken.Search),),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload),
                  label: 'Post',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting),
                  label: 'Settings',
                ),
              ]),
        );
      },
    );
  }
}
