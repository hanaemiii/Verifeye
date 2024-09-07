import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:verifeye/bloc/account_bloc/account_bloc.dart';
import 'package:verifeye/bloc/account_bloc/account_event.dart';
import 'package:verifeye/bloc/authentication%20blocs/log_out_bloc.dart/log_out_event.dart';
import 'package:verifeye/bloc/authentication%20blocs/log_out_bloc.dart/log_out_state.dart';
import 'package:verifeye/bloc/main_bloc/main_bloc.dart';
import 'package:verifeye/bloc/main_bloc/main_event.dart';
import 'package:verifeye/core/firebase_services/firebase_auth.dart';

class LogOutBloc extends Bloc<LogOutEvent, LogOutState> {
  final MainBloc mainBloc;
  final AccountBloc accountBloc;

  LogOutBloc({
    required this.mainBloc,
    required this.accountBloc,
  }) : super(
          LogOutState(),
        ) {
    on<UserLogOutEvent>(userLogOut);
  }
  final AuthService authService = GetIt.I<AuthService>();

  Future<void> userLogOut(
      UserLogOutEvent event, Emitter<LogOutState> emit) async {
    await authService.signOut();
    mainBloc.add(
      ResetHomePageEvent(),
    );
    accountBloc.add(
      ResetAccountPageEvent(),
    );
    event.onSuccess?.call();
  }
}
