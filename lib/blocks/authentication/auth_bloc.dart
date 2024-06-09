import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanban_board/repositories/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(Unauthenticated()) {
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try{
        await _authRepository.signIn(email: event.email, password: event.password);
        emit(Authenticated());
      }
      catch(error){
        emit(AuthError(message: error.toString()));
        emit(Unauthenticated());
      }
    });
    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try{
        await _authRepository
            .signUp(email: event.email, password: event.password);
        emit(Authenticated());
      }
      catch(error){
        emit(AuthError(message: error.toString()));
        emit(Unauthenticated());
      }
    });
    on<GoogleSignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await _authRepository.signInWithGoogle();
        emit(Authenticated());
      } catch (error) {
        emit(AuthError(message: error.toString()));
        emit(Unauthenticated());
      }
    });
    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await _authRepository.signOut();
      emit(Unauthenticated());
    });
  }
}
