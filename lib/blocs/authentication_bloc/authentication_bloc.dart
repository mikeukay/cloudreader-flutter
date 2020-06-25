import 'package:cloudreader/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';

import 'authentication_state.dart';
import 'authentication_event.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({UserRepository userRepository})
      : _userRepository = userRepository != null ? userRepository : UserRepository();

  @override
  AuthenticationState get initialState => AuthenticationLoading();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationInitialize) {
      yield* _mapAuthenticationInitializeToState();
    } else if (event is AuthenticationSignInWithGoogleButtonPressed) {
      yield* _mapAuthenticationSignInWithGoogleButtonPressedToState();
    } else if (event is AuthenticationLogOut) {
      yield* _mapAuthenticationLogOutToState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationInitializeToState() async* {
    yield AuthenticationLoading();

    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      final user = await _userRepository.getUser();
      yield AuthenticationSuccess(user);
    } else {
      final user = await _userRepository.signInWithGoogleSilently();

      if(user == null) {
        yield AuthenticationFailure();
      } else {
        yield AuthenticationSuccess(user);
      }
    }
  }

  Stream<AuthenticationState> _mapAuthenticationSignInWithGoogleButtonPressedToState() async* {
    yield AuthenticationLoading();

    final user = await _userRepository.signInWithGoogle();
    if(user == null) {
      yield AuthenticationFailure();
    } else {
      yield AuthenticationSuccess(user);
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLogOutToState() async* {
    yield AuthenticationLoading();

    await _userRepository.signOut();

    yield AuthenticationFailure();
  }
}