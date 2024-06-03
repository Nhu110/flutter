class UserModel {
  String? name ;
  String? pass ;

  UserModel({this.name , this.pass});
}

List<UserModel> users = [
  UserModel()
  ..name = 'Trang'
  ..pass = '123'
];