import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_try/shared/default_widgets.dart';
import 'package:last_try/shop_app/search/search_cubit.dart';
import 'package:last_try/shop_app/search/search_states.dart';

class SearchScreen extends StatelessWidget {

  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            SearchCubit cubit = SearchCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defaultTextFiled(
                        controller: searchController,
                        inputType: TextInputType.text,
                        prefixIcon: Icons.search,
                        label: 'Search',
                        onSubmit: (text){
                          cubit.search(text);
                        },
                        // onChanged: (text){
                        //   cubit.search(text);
                        // },
                        textColor: Colors.grey[800],
                        borderColor: Colors.grey,
                        preIconColor: Colors.grey[700],
                      ),
                      SizedBox(height: 10,),
                      if(state is SearchLoadingState)
                      LinearProgressIndicator(
                        color: Colors.black,
                        backgroundColor: Colors.grey[200],
                      ),
                      SizedBox(height: 15,),
                      if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: buildSearchItem(cubit, index, context),
                          ),
                          itemCount: cubit.searchModel!.data!.data.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  Widget buildSearchItem(SearchCubit cubit, int index, BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Card(
        color: Colors.white,
        elevation: 0.3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        '${cubit.searchModel!.data!.data[index].image}',
                        width: 130,
                        height: 120,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${cubit.searchModel!.data!.data[index].name}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                fontSize: 14,
                                height: 1.3,
                                fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${cubit.searchModel!.data!.data[index].price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                fontSize: 12,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
