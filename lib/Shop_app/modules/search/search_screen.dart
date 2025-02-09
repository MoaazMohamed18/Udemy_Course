import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Shop_app/modules/search/cubit/cubit.dart';
import 'package:todo/Shop_app/modules/search/cubit/states.dart';
import 'package:todo/shared/components/components.dart';

class ShopSearchScreen extends StatelessWidget {
  ShopSearchScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          label: 'Search',
                          prefix: Icons.search,
                          validate: (String? value) {
                            if(value!.isEmpty) {
                              return 'Enter text to search';
                            }
                            return null;
                          },
                          onSubmit: (String text) {
                            SearchCubit.get(context).search(text);
                          },
                      ),
                      const SizedBox(height: 10.0,),
                      if(state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(height: 10.0,),
                      if(state is SearchSuccessState)
                        Expanded(
                        child: ListView.separated(
                        itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model.data!.data[index], context, isOldPrice: false),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: SearchCubit.get(context).model.data!.data.length,
                      ),)
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
