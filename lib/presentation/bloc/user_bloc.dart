import 'package:bloc/bloc.dart';
import 'package:indoxx1/common/util/shared_preferences.dart';
import 'package:indoxx1/common/util/shared_preferences_key.dart';
import 'package:indoxx1/data/indoxxi/repository/indoxxi_repository.dart';
import 'package:indoxx1/data/indoxxi/repository/user_repository.dart';
import 'package:indoxx1/presentation/bloc/event/user_event.dart';
import 'package:indoxx1/presentation/bloc/state/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  @override
  UserState get initialState => UserUninitializedState();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserFetchEvent) {
      try {
        final res = await UserRepository().getUser(tokenId: event.tokenId);
        yield UserLoadedState(res: res);
      } catch (_) {
        yield UserErrorState();
      }
    }

    if (event is UserAddNewEvent) {
      try {
        final res = await UserRepository().addNewUser(name: event.name, email: event.email, tokenId: event.tokenId);
        yield UserAddNewState(res: res);
      } catch (_) {
        yield UserErrorState();
      }
      
    }
  }
}