import 'package:flutter/material.dart';
import 'package:indoxx1/data/omdb/model/actor.dart';
import 'package:indoxx1/data/omdb/model/director.dart';
import 'package:indoxx1/data/omdb/model/role_enum.dart';
import 'package:indoxx1/data/omdb/model/writer.dart';

class CrewModel {
  String name;
  RoleEnum role;

  CrewModel({String name, RoleEnum role}) {
    this.name = name;
    this.role = role;
  }
} 

class CrewFactory {
  String name;
  String role;

  CrewFactory({@required String name, @required String role}) {
    this.name = name;
    this.role = role;
  }

  CrewModel getCrew() {
    if (this.role == RoleEnum.actor.toString().split(',').last) {
      return ActorModel(name: this.name, role: RoleEnum.actor);
    } else
    if (this.role == RoleEnum.director.toString().split(',').last) {
      return DirectorModel(name: this.name, role: RoleEnum.director);
    } else
    if (this.role == RoleEnum.writer.toString().split(',').last) {
      return WriterModel(name: this.name, role: RoleEnum.writer);
    }
  }
}