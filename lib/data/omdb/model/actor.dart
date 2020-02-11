import 'package:indoxx1/data/omdb/model/crew.dart';
import 'package:indoxx1/data/omdb/model/role_enum.dart';

class ActorModel extends CrewModel {

  ActorModel ({String name, RoleEnum role}) : super(name: name, role: role) {}
}