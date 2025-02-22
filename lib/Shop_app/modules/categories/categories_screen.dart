import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Shop_app/cubit/cubit.dart';
import 'package:todo/Shop_app/cubit/states.dart';
import 'package:todo/Shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel.data!.data[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: ShopCubit.get(context).categoriesModel.data!.data.length,
        );
      },);
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 20.0,),
        Text(
          model.name,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios),
      ],
    ),
  );

}
