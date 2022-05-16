class LoginModel {
  LoginModel({
    this.status,
    this.message,
    this.data,});

  LoginModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  Data? data;

}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

}
/*{"status":true,"message":"تم تسجيل الدخول بنجاح","data":{"id":14375,"name":"Mohamed Elshenawy","email":"medoyousef444@gmail.com","phone":"01224127110","image":"https://student.valuxapps.com/storage/uploads/users/YaTe7dYoO4_1652528707.jpeg","points":0,"credit":0,"token":"hhxf6oElqWs7lN3rCzV50t8DizBlrrGf8yktwDmo0DN1vxh58qaK1cyMumwWkN5h8X2AfZ"}}*/
