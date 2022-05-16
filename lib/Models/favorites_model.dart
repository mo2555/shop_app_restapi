class FavoritesModel{
  String? message;
  bool? status;

  FavoritesModel({this.message,
  this.status});

  FavoritesModel.fromJson(dynamic json){
    message=json['message'];
    status = json['status'];
  }
}