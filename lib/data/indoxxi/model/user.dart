import 'package:indoxx1/data/omdb/model/base.dart';

class UserModel extends BaseModel {
  String _tokenId;
  String _name;
  String _email;

  UserModel.userFromJson(Map<String, dynamic> parsedJson) {
    this._tokenId = parsedJson['token_id'];
    this._name = parsedJson['name'];
    this._email = parsedJson['email'];
  }

  String get tokenId => _tokenId;
  String get name => _name;
  String get email => _email;
}