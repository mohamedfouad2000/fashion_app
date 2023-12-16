import 'package:bloc/bloc.dart';
import 'package:fashon_app/Feature/Home/data/brand_model/brand_model.dart';
import 'package:fashon_app/Feature/Home/data/category_model/category_model.dart';
import 'package:fashon_app/Feature/Home/data/fav_model/fav_model.dart';
import 'package:fashon_app/Feature/Home/data/products_model/products_model.dart';
import 'package:fashon_app/Feature/Home/data/profile_model/profile_model.dart';
import 'package:fashon_app/Feature/Home/data/slider_model/slider_model.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:fashon_app/Feature/Home/presentation/screens/shopping_cart.dart';
import 'package:fashon_app/Feature/Home/presentation/screens/fav_page.dart';
import 'package:fashon_app/Feature/Home/presentation/screens/settings.dart';
import 'package:fashon_app/Feature/Home/presentation/screens/main_home.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitState());
  static HomeCubit get(context) => BlocProvider.of(context);
  ProductsModel? pro;

  int? currentIndex = 0;
  void changeIndex({required value}) {
    emit(ChangeIndexLoading());
    currentIndex = value;
    if (value == 0) {
      getCategory();
      getSlider();
      getProduct(uId: UID).then((value) {
        emit(ChangeIndexSucc());
      });
    }
    if (value == 1) {
      getFav().then((value) {
        emit(ChangeIndexSucc());
      });
    }
  }

  Future<void> getProduct(
      {String? search, int? page, required int? uId}) async {
    pro = null;
    // favList = {};
    emit(GetProductLoading());
    DioHelper.getData(
        url: PRODUCT,
        query: {"search": search, "page": page, "user_id": uId}).then((value) {
      // print(value.data["status"]);

      pro = ProductsModel.fromJson(value.data);

      // print(pro!.status);
    }).then((value) {
      for (var element in pro!.data!.data!) {
        favList!.addAll({element.id: element.isFavorite == 0 ? false : true});
      }

      emit(GetProductSucc());

      // print(p[0].name);
    }).catchError((onError) {
      emit(GetProductError());

      // print(onError);
    });
  }

// TextEditingController searchController = TextEditingController();
  List<Widget> screens = [
    MainHome(
      searchController: TextEditingController(),
    ),
    const FavPage(),
    const ShoppingCart(),
    const Settings()
  ];
  SliderModel? slid;
  Future<void> getSlider() async {
    slid = null;
    emit(GetSliderLoading());
    DioHelper.getData(url: SLIDER).then((value) {
      // print(value.data["status"]);

      slid = SliderModel.fromJson(value.data);
      // print(slid!.result);
    }).then((value) {
      emit(GetSliderSucc());

      // print(p[0].name);
    }).catchError((onError) {
      emit(GetSliderError());

      // print(onError);
    });
  }

  // void start() {
  //   emit(GetStartLoading());
  //   getProduct().then((value) =>
  //       getSlider().then((value) => emit(GetStartSucc())).catchError((onError) {
  //         emit(GetStartError());
  //       }));
  // }
  CategoryModel? cat;
  void getCategory() {
    cat = null;

    emit(GetCategoryLoading());
    DioHelper.getData(
      url: CATEGORY,
    ).then((value) {
      // print("object ------------------- Is Value $value");
      cat = CategoryModel.fromJson(value.data);

      emit(GetCategorySucc());

      // print(value.data);
    }).catchError((error) {
      emit(GetCategoryError());
    });
  }

  BrandModel? brands;
  Future<void> getBrands() async {
    brands = null;
    emit(GetBrandsLoading());
    DioHelper.getData(url: BRAND).then((value) {
      // print(
      //     "value____________----------------------------________________- Is $value");
      brands = BrandModel.fromJson(value.data);
      // print("siu Yas Siu");
      // print(brands?.data!.length);
      // print("object");
      emit(GetBrandsSucc());
    }).catchError((error) {
      // print(error.toString());
      emit(GetBrandsError());
    });
  }

  Future<void> addOrRemoveFav({required int? id, bool indeta = false}) async {
    favList![id] = !favList![id]!;
    emit(AddOrRemoveFavLoading());

    DioHelper.postData(url: ADDORREMOVEFAV, token: TOKEN, data: {'favo_id': id})
        .then((value) {
      if (value.data['result'] == false) {
        favList![id] = !favList![id]!;
      }
      if (indeta) {
        getProduct(uId: UID);
      }

      // print(
      // "value _______________________________________________----------------------------_____________________________________ $value");
      emit(AddOrRemoveFavSucc(msq: value.data['error_mesage']));
    }).catchError((Error) {
      emit(AddOrRemoveFavError());
    });
  }

  IconData? favIcon = Icons.favorite;
  void changeIcon() {
    if (favIcon == Icons.favorite) {
      favIcon = Icons.favorite_border;
    } else {
      favIcon = Icons.favorite;
    }
    emit(ChangeFavIcon());
  }

  Future<void> getProfile() async {
    emit(GetProfileDataLoading());
    DioHelper.getData(url: PROFILE, token: TOKEN).then((value) {
      ProfileData = ProfileModel.fromJson(value.data);
      emit(GetProfileDataSucc());
    }).catchError((error) {
      emit(GetProfileDataError());
    });
  }

  FavModel? fav;
  Future<void> getFav() async {
    emit(GetFavProductLoading());
    DioHelper.getData(url: FAVORITE, token: TOKEN).then((value) {
      fav = FavModel.fromJson(value.data);
      emit(GetFavProductSucc());
    }).catchError((error) {
      emit(GetFavProductError());
    });
  }

  ProductsModel? searchProduct;

  void getProductByBrandAndCat({required int brandId, required int catId}) {
    searchProduct = null;
    emit(GetProductByBrandAndCatLoading());
    DioHelper.getData(
        url: 'products/t/ar/0/$catId/$brandId',
        query: {"user_id": UID}).then((value) {
      // print(value);
      searchProduct = ProductsModel.fromJson(value.data);
      for (var element in searchProduct!.data!.data!) {
        favList!.addAll({element.id: element.isFavorite == 0 ? false : true});
      }
      emit(GetProductByBrandAndCatSucc());
    }).catchError((onError) {
      emit(GetProductByBrandAndCatError());
    });
  }
}
