import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_sm/resources/dashboard_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashBoardRepository dashBoardRepository;
  DashboardBloc({required this.dashBoardRepository})
      : super(DashboardInitial()) {
    on<DashboardRequest>(
      ((event, emit) async {
        emit(DashboardLoading());
        final String pathEmailRequest =
            await dashBoardRepository.getPathEmailRequest();
        emit(DashboardLoaded(pathEmailRequest));
      }),
    );
  }
}
