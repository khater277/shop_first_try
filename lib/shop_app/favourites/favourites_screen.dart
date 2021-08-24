import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:last_try/shared/constants.dart';
import 'package:last_try/shared/default_widgets.dart';
import 'package:last_try/shop_app/shop_cubit/shop_cubit.dart';
import 'package:last_try/shop_app/shop_cubit/shop_state.dart';
import 'package:line_icons/line_icons.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.favouritesModel != null,
          widgetBuilder: (context) => Conditional.single(
            context: context,
            conditionBuilder: (context) => state is! ShopFavouritesErrorState,
            widgetBuilder: (context) => Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    state is! ShopChangeFavouritesSuccessState &&
                    state is! ShopFavouritesChangeState,
                widgetBuilder: (context) => Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          cubit.favouritesModel!.data!.data.length != 0,
                      widgetBuilder: (context) => ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: buildFavItem(cubit, index, context),
                        ),
                        itemCount: cubit.favouritesModel!.data!.data.length,
                      ),
                      fallbackBuilder: (context) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Please add some products",
                              style:
                                  TextStyle(fontSize: 23, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Icon(
                              Icons.menu,
                              color: Colors.grey,
                              size: 160,
                            ),
                          ],
                        ),
                      ),
                    ),
                fallbackBuilder: (context) =>
                    defaultProgressIndicator(icon:LineIcons.heart)),
            fallbackBuilder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Please add some products",
                    style: TextStyle(fontSize: 23, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Icon(
                    Icons.menu,
                    color: Colors.grey,
                    size: 160,
                  ),
                ],
              ),
            ),
          ),
          fallbackBuilder: (context) => defaultProgressIndicator(
            icon:LineIcons.heart,
          ),
        );
      },
    );
  }

  Widget buildFavItem(ShopCubit cubit, int index, BuildContext context) {
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
                        '${cubit.favouritesModel!.data!.data[index].product!.image}',
                        width: 130,
                        height: 120,
                        fit: BoxFit.fill,
                      ),
                    ),
                    if (cubit.favouritesModel!.data!.data[index].product!
                            .discount !=
                        0)
                      Container(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            'DISCOUNT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${cubit.favouritesModel!.data!.data[index].product!.name}',
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
                              '${cubit.favouritesModel!.data!.data[index].product!.price}',
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
                            if (cubit.favouritesModel!.data!.data[index]
                                    .product!.discount !=
                                0)
                              Text(
                                '${cubit.favouritesModel!.data!.data[index].product!.oldPrice}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough),
                              ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  ShopCubit.get(context).changeFavourites(
                                    productID: cubit.favouritesModel!.data!
                                        .data[index].product!.id,
                                  );
                                },
                                icon: cubit.favourites[cubit.favouritesModel!
                                            .data!.data[index].product!.id] ==
                                        false
                                    ? Icon(Icons.favorite_border)
                                    : Icon(
                                        Icons.favorite,
                                        color: Colors.red.withOpacity(0.7),
                                      )),
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
