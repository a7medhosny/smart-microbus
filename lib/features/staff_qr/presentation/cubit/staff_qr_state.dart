abstract class StaffQrState {}

class StaffQrInitial extends StaffQrState {}

class StaffQrLoading extends StaffQrState {}

class StaffQrSuccess extends StaffQrState {
  final String message;

  StaffQrSuccess(this.message);
}

class StaffQrError extends StaffQrState {
  final String message;

  StaffQrError(this.message);
}