class HomeModel {
  HomeModel({
    this.status,
    this.message,
    this.data,});

  HomeModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  dynamic message;
  Data? data;
  HomeModel copyWith({  bool? status,
    dynamic message,
    Data? data,
  }) => HomeModel(  status: status ?? this.status,
    message: message ?? this.message,
    data: data ?? this.data,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    this.banners,
    this.products,
    this.ad,});

  Data.fromJson(dynamic json) {
    if (json['banners'] != null) {
      banners = [];
      json['banners'].forEach((v) {
        banners?.add(Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    ad = json['ad'];
  }
  List<Banners>? banners;
  List<Products>? products;
  String? ad;
  Data copyWith({  List<Banners>? banners,
    List<Products>? products,
    String? ad,
  }) => Data(  banners: banners ?? this.banners,
    products: products ?? this.products,
    ad: ad ?? this.ad,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (banners != null) {
      map['banners'] = banners?.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['ad'] = ad;
    return map;
  }

}

class Products {
  Products({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,});

  Products.fromJson(dynamic json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;
  Products copyWith({  int? id,
    int? price,
    int? oldPrice,
    int? discount,
    String? image,
    String? name,
    String? description,
    List<String>? images,
    bool? inFavorites,
    bool? inCart,
  }) => Products(  id: id ?? this.id,
    price: price ?? this.price,
    oldPrice: oldPrice ?? this.oldPrice,
    discount: discount ?? this.discount,
    image: image ?? this.image,
    name: name ?? this.name,
    description: description ?? this.description,
    images: images ?? this.images,
    inFavorites: inFavorites ?? this.inFavorites,
    inCart: inCart ?? this.inCart,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['price'] = price;
    map['old_price'] = oldPrice;
    map['discount'] = discount;
    map['image'] = image;
    map['name'] = name;
    map['description'] = description;
    map['images'] = images;
    map['in_favorites'] = inFavorites;
    map['in_cart'] = inCart;
    return map;
  }

}

class Banners {
  Banners({
    this.id,
    this.image,
    this.category,
    this.product,});

  Banners.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }
  int? id;
  String? image;
  dynamic category;
  dynamic product;
  Banners copyWith({  int? id,
    String? image,
    dynamic category,
    dynamic product,
  }) => Banners(  id: id ?? this.id,
    image: image ?? this.image,
    category: category ?? this.category,
    product: product ?? this.product,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['category'] = category;
    map['product'] = product;
    return map;
  }

}