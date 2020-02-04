import 'package:demo_app/model/crew.dart';

class ActorModel extends CrewModel {
  ActorRoles role;
  
  ActorModel(String name, {String role}) {
    this.name = name;
    if (role == ActorRoles.actor.toString().split('.').last) {
      this.role = ActorRoles.actor;
    } else {
      this.role = ActorRoles.NA;
    }  
  }
}

enum ActorRoles {
  actor,
  NA
}