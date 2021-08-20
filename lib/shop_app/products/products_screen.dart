import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:last_try/shared/default_widgets.dart';
import 'package:last_try/shop_app/shop_cubit/shop_cubit.dart';
import 'package:last_try/shop_app/shop_cubit/shop_state.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context)=>cubit.homeModel!=null&&cubit.categoriesModel!=null,
          widgetBuilder: (context)=>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: buildProductsPage(cubit),
          ),
          fallbackBuilder: (context)=>defaultProgressIndicator(
            color: Colors.red.withOpacity(0.7)
          ),
        );
      },
    );
  }

  Column buildProductsPage(ShopCubit cubit) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCarouselSlider(cubit),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              buildCategoriesItems(cubit),
              SizedBox(height: 10,),
              Container(
                  color: Colors.grey[200],
                  child:GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.68,
                    ),
                    itemBuilder: (context,index)=>buildGridItem(cubit, index, context),
                    itemCount: cubit.homeModel!.data!.products!.length,
                  )
              ),
            ],
          );
  }

  Widget buildGridItem(ShopCubit cubit, int index, BuildContext context) {
    return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.bottomStart,
                                  children: [
                                    Image.network(
                                      '${cubit.homeModel!.data!.products![index].image}',
                                      width: double.infinity,
                                      height: 150,
                                      fit: BoxFit.fill,
                                    ),
                                    if(cubit.homeModel!.data!.products![index].discount!=0)
                                      Container(
                                        color: Colors.red,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: Text(
                                            'DISCOUNT',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Expanded(
                                  child: Text(
                                    '${cubit.homeModel!.data!.products![index].name}',
                                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 14,
                                      height: 1.3,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${cubit.homeModel!.data!.products![index].price} EGP',
                                        style:
                                        Theme.of(context).textTheme.bodyText1!.copyWith(
                                          fontSize: 12,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      if (cubit.homeModel!.data!.products![index].discount==0)
                                        Row(
                                          children: [
                                            SizedBox(width: 5,),
                                            Text(
                                              '${cubit.homeModel!.data!.products![index].oldPrice}',
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration.lineThrough),
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            cubit.changeFavourites(productID: cubit.homeModel!.data!.products![index].id);
                          },
                          icon: cubit.favourites[cubit.homeModel!.data!.products![index].id]==true?
                          Icon(Icons.favorite,color: Colors.red.withOpacity(0.7),):
                            Icon(Icons.favorite_border),
                        ),
                      ],
                    ),
                  );
  }

  Widget buildCategoriesItems(ShopCubit cubit) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 90,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index)=> ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Image.network(
                          '${cubit.categoriesModel!.data!.categoryDetails![index].image}',
                          width: 90,height: 90,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          width: 90,
                          color: Colors.black.withOpacity(.7),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              '${cubit.categoriesModel!.data!.categoryDetails![index].name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  separatorBuilder: (context,index)=>SizedBox(width: 15,),
                  itemCount: cubit.categoriesModel!.data!.categoryDetails!.length,
                ),
              ),
            );
  }

  Widget buildCarouselSlider(ShopCubit cubit) {
    return CarouselSlider.builder(
              itemCount: cubit.homeModel!.data!.banners!.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      '${cubit.homeModel!.data!.banners![index].image}',
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 0.98,
                initialPage: 0,
                enlargeCenterPage: true,
              ),
            );
  }
}
