import 'package:indoxx1/data/indoxxi/datasource/user_datasource.dart';
import 'package:indoxx1/data/indoxxi/datasource/user_local_datasource.dart';
import 'package:indoxx1/data/indoxxi/model/user.dart';

class UserRepository {
  final UserDatasource userDatasource = UserLocalDatasourceImpl();

  Future init({bool isCreate}) => userDatasource.init(isCreate: isCreate);

  Future<UserModel> getUser({String tokenId}) =>
      userDatasource.getUser(tokenId: tokenId);

  Future<String> addNewUser({String name, String email, String tokenId}) =>
      userDatasource.addNewUser(name: name, email: email, tokenId: tokenId);
}
