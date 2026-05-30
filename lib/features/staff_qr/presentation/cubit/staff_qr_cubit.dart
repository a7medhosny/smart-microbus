import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../domain/usecases/check_in_usecase.dart';
import '../../domain/usecases/check_out_usecase.dart';
import 'staff_qr_state.dart';

class StaffQrCubit extends Cubit<StaffQrState> {
  final CheckInUseCase checkInUseCase;
  final CheckOutUseCase checkOutUseCase;

  StaffQrCubit({
    required this.checkInUseCase,
    required this.checkOutUseCase,
  }) : super(StaffQrInitial());

  Future<void> checkIn(String qrCode) async {
    emit(StaffQrLoading());

    final result =
        await checkInUseCase(qrCode);

    result.fold(
      (failure) {
        emit(
          StaffQrError(
            _mapFailureToMessage(
              failure,
            ),
          ),
        );
      },
      (_) {
        emit(
          StaffQrSuccess(
            "Check In Success",
          ),
        );
      },
    );
  }

  Future<void> checkOut(
    String qrCode,
  ) async {
    emit(StaffQrLoading());

    final result =
        await checkOutUseCase(qrCode);

    result.fold(
      (failure) {
        emit(
          StaffQrError(
            _mapFailureToMessage(
              failure,
            ),
          ),
        );
      },
      (_) {
        emit(
          StaffQrSuccess(
            "Check Out Success",
          ),
        );
      },
    );
  }

  String _mapFailureToMessage(
    Failure failure,
  ) {
    return failure.message;
  }
}