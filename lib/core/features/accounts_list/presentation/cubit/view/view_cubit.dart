import 'package:bloc/bloc.dart';

enum view { grid, list }

class ViewCubit extends Cubit<view> {
  ViewCubit() : super(view.list);

  void toggleView() {
    emit(state == view.list ? view.grid : view.list);
  }
}
