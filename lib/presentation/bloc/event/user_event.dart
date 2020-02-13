abstract class UserEvent {}

class UserFetchEvent extends UserEvent {
  String tokenId;

  UserFetchEvent({this.tokenId});

  @override
  String toString() => "UserFetchEvent:";
}

class UserAddNewEvent extends UserEvent {
  String name;
  String email;
  String tokenId;

  UserAddNewEvent({this.name, this.email, this.tokenId});

  @override
  String toString() => "UserAddNewEvent:";
}

class UserClearFetchEvent extends UserEvent {
  String tokenId;
  String name;
  String email;

  UserClearFetchEvent({this.tokenId, this.name, this.email});

  @override
  String toString() => "UserClearFetchEvent";
}