import 'package:demo_app/model/crew.dart';

class WriterModel extends CrewModel {
  WriterRoles role;

  WriterModel(String name, {String role}) {
    this.name = name;
    if (role == WriterRoles.created.toString().split('.').last) {
      this.role = WriterRoles.created;
    } else if (role == WriterRoles.story.toString().split('.').last) {
      this.role = WriterRoles.story;
    } else if (role == WriterRoles.created.toString().split('.').last) {
      this.role = WriterRoles.created;
    } else {
      this.role = WriterRoles.NA;
    }
  }
}

enum WriterRoles {
  screenplay,
  story,
  created,
  NA
}