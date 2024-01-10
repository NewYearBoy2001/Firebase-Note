import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(UnauthenticatedState());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is LoginEvent) {
      try {
        emit(AuthenticatedState(userEmail: event.email));
      } catch (error) {
        emit(UnauthenticatedState());
      }
    } else if (event is RegisterEvent) {
      try {
        emit(AuthenticatedState(userEmail: event.email));
      } catch (error) {
        emit(UnauthenticatedState());
      }
    }
  }
}
