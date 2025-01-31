part of 'main_cubit.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object?> get props => [];
}

class MainLoading extends MainState {
  const MainLoading();
}

class MainSuccess extends MainState {
  final DataHelper dataHelper;
  const MainSuccess(this.dataHelper);
}