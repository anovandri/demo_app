import 'package:demo_app/model/crew.dart';

class DirectorModel extends CrewModel {
  DirectorRoles role;

  DirectorModel(String name, {String role}) {
    this.name = name;
    if (role == DirectorRoles.director.toString().split('.').last) {
      this.role = DirectorRoles.director;
    } else {
      this.role = DirectorRoles.NA;
    }
  }
}

enum DirectorRoles {
  director,
  NA
}