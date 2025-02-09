import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Shop_app/cubit/cubit.dart';
import 'package:todo/Shop_app/cubit/states.dart';
import 'package:todo/Shop_app/modules/search/search_screen.dart';
import 'package:todo/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Salla'),
            actions: [
              IconButton(onPressed: () {
                navigateTo(context, ShopSearchScreen());
              }, icon: const Icon(Icons.search)),
            ],
          ),
          body: cubit.BottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
              BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories',),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites',),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings',),
            ],
          ),
        );
      },
    );
  }
}
