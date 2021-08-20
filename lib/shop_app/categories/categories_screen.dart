import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:last_try/shared/constants.dart';
import 'package:last_try/shared/default_widgets.dart';
import 'package:last_try/shop_app/shop_cubit/shop_cubit.dart';
import 'package:last_try/shop_app/shop_cubit/shop_state.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context)=>cubit.categoriesModel!=null,
          widgetBuilder: (context)=>buildCategoryItem(cubit),
          fallbackBuilder: (context)=>defaultProgressIndicator(
              color: indicatorColor
          ),
        );
      },
    );
  }

  Widget buildCategoryItem(ShopCubit cubit) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index){
              return Card(
                elevation: 0.3,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          '${cubit.categoriesModel!.data!.categoryDetails![index].image}',
                          width: 100,height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      '${cubit.categoriesModel!.data!.categoryDetails![index].name}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.arrow_forward_ios)
                    )
                  ],
                ),
              );
            },
            itemCount: cubit.categoriesModel!.data!.categoryDetails!.length,
          ),
        );
  }
}
