abstract class HomeStates {}

class InitState extends HomeStates {}

class GetProductLoading extends HomeStates {}

class GetProductSucc extends HomeStates {}

class GetProductError extends HomeStates {}

class GetSliderLoading extends HomeStates {}

class GetSliderSucc extends HomeStates {}

class GetSliderError extends HomeStates {}

class GetStartLoading extends HomeStates {}

class GetStartSucc extends HomeStates {}

class GetStartError extends HomeStates {}

class ChangeIndexLoading extends HomeStates {}

class ChangeIndexSucc extends HomeStates {}

class ChangeIndexError extends HomeStates {}

class GetCategoryLoading extends HomeStates {}

class GetCategorySucc extends HomeStates {}

class GetCategoryError extends HomeStates {}

class GetBrandsLoading extends HomeStates {}

class GetBrandsSucc extends HomeStates {}

class GetBrandsError extends HomeStates {}

class AddOrRemoveFavLoading extends HomeStates {}

class AddOrRemoveFavSucc extends HomeStates {
  String msq;
  AddOrRemoveFavSucc({required this.msq});
}

class AddOrRemoveFavError extends HomeStates {}

class ChangeFavIcon extends HomeStates {}

class GetFavProductLoading extends HomeStates {}

class GetFavProductSucc extends HomeStates {}

class GetFavProductError extends HomeStates {}

class SearchProductLoading extends HomeStates {}

class SearchProductSucc extends HomeStates {}

class SearchProductError extends HomeStates {}

class GetProductByBrandAndCatLoading extends HomeStates {}

class GetProductByBrandAndCatSucc extends HomeStates {}

class GetProductByBrandAndCatError extends HomeStates {}

class GetProfileDataLoading extends HomeStates {}

class GetProfileDataSucc extends HomeStates {}

class GetProfileDataError extends HomeStates {}

class EditProfileDataLoading extends HomeStates {}

class EditProfileDataSucc extends HomeStates {
  String msq;
  EditProfileDataSucc({required this.msq});
}

class EditProfileDataError extends HomeStates {
  String msq;
  EditProfileDataError({required this.msq});
}

class GetCountLoading extends HomeStates {}

class GetCountSucc extends HomeStates {}

class GetCountError extends HomeStates {
  String msq;
  GetCountError({required this.msq});
}

class GetcityLoading extends HomeStates {}

class GetcitySucc extends HomeStates {}

class GetcityError extends HomeStates {
  String msq;
  GetcityError({required this.msq});
}

class ChangeNAmestate extends HomeStates {}

class OrderUserLoading extends HomeStates {}

class OrderUserSucc extends HomeStates {
  String msq;
  OrderUserSucc({required this.msq});
}

class OrderUserError extends HomeStates {
  String msq;
  OrderUserError({required this.msq});
}
