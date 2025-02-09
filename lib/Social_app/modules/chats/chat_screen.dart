import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Social_app/cubit/cubit.dart';
import 'package:todo/Social_app/cubit/states.dart';
import 'package:todo/Social_app/models/social_user_model.dart';
import 'package:todo/Social_app/modules/chat_details/chat_details_screen.dart';
import 'package:todo/shared/components/components.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: SocialCubit.get(context).users.isNotEmpty,
            builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(SocialCubit.get(context).users[index], context),
              separatorBuilder: (context, index) => const Divider(),
              itemCount:  SocialCubit.get(context).users.length,
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
        onTap: () {
          navigateTo(context, ChatDetailsScreen(
            userModel: model,
          ));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    '${model.image}'),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Text(
                '${model.name}',
                style: const TextStyle(
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      );
}
