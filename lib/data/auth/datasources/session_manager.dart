import 'package:indoxx1/common/model/session.dart';

abstract class SessionManager {
  Future<Session> getSession();
  Stream<Session> getSessionStream();
  Future<void> setSession(Session session);
}