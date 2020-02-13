import 'package:indoxx1/data/indoxxi/model/user.dart';

abstract class UserDatasource {
  Future init({bool isCreate});
  
  Future<UserModel> getUser({String tokenId});

  Future<String> addNewUser({String name, String email, String tokenId});

}