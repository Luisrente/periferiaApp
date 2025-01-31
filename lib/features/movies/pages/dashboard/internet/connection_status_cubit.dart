import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:periferiamovies/core/network/check_internet_connection.dart';
import 'package:periferiamovies/main.dart';

class ConnectionStatusCubit extends Cubit<ConnectionStatus> {
  late StreamSubscription _connectionSubscription;

  ConnectionStatusCubit() : super(ConnectionStatus.online) {
    _connectionSubscription = internetChecker.internetStatus().listen(emit);
  }

  @override
  Future<void> close() {
    _connectionSubscription.cancel();
    return super.close();
  }
}