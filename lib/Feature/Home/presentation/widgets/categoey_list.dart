import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashon_app/Feature/Home/data/category_model/datum.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:fashon_app/Feature/Home/presentation/screens/brands.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:fashon_app/core/utils/size_config.dart';
import 'package:fashon_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return SizedBox(
          height: SizeConfig.screenHeight! * .17,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: catItem(
                    model: HomeCubit.get(context).cat?.data?[index],
                    context: context),
              );
            },
            itemCount: HomeCubit.get(context).cat!.data!.length,
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}

Widget catItem({required Datummms? model, required context}) => InkWell(
      onTap: () {
        NavegatorPush(
            context,
            BrandPage(
              catId: model?.id,
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            width: 90,
            height: 90,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error_outline),
            imageUrl: "$IMGURL${model?.img}",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //     placeholder: (context, url) => placeholder,
            //     errorWidget: (context, url, error) => errorWidget,
          ),
          Text(
            "${model?.name}",
            style: StylesData.emailStyle,
          ),
        ],
      ),
    );
