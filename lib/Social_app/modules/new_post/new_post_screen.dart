import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Social_app/cubit/cubit.dart';
import 'package:todo/Social_app/cubit/states.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/styles/colors.dart';

import '../../../shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({super.key});

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            actions: [
              defaultTextButton(
                  function: () {
                    DateTime now = DateTime.now();
                    String convertedDateTime = "${now.day.toString()}-${now.month.toString().padLeft(2,'0')}-${now.year.toString().padLeft(2,'0')} / ${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}";


                    if (SocialCubit.get(context).postImage == null) {
                      SocialCubit.get(context).createPost(
                          dateTime: convertedDateTime,
                          text: textController.text,
                      );
                    } else {
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                    }
                  },
                  text: 'Post'
              ),
            ],
            title: 'Create Post',
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  const SizedBox(height: 10.0,),
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2380&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        'Moaaz Mohamed',
                        style: TextStyle(
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0,),
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'What\'s in your mind?',
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0,),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: const CircleAvatar(
                        backgroundColor: defaultColor,
                        radius: 20.0,
                        child: Icon(
                          Icons.close,
                          size: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0,),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                                color: defaultColor,
                              ),
                              SizedBox(width: 5.0,),
                              Text(
                                  'Add Photo',
                                style: TextStyle(
                                  color: defaultColor,
                                ),
                              ),
                            ],
                          ),
                        ),),
                    Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            '# Tags',
                            style: TextStyle(
                              color: defaultColor,
                            ),
                          ),
                        ),),
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
