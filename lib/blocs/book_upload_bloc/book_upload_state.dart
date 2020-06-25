import 'package:meta/meta.dart';

@immutable
class BookUploadState {
  final bool isNameValid;
  final bool isFileValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isNameValid && isFileValid;

  BookUploadState({
    @required this.isNameValid,
    @required this.isFileValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory BookUploadState.initial() {
    return BookUploadState(
      isNameValid: true,
      isFileValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory BookUploadState.loading() {
    return BookUploadState(
      isNameValid: true,
      isFileValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory BookUploadState.failure() {
    return BookUploadState(
      isNameValid: true,
      isFileValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory BookUploadState.success() {
    return BookUploadState(
      isNameValid: true,
      isFileValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  BookUploadState update({
    bool isNameValid,
    bool isFileValid,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isFileValid: isFileValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  BookUploadState copyWith({
    bool isNameValid,
    bool isFileValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return BookUploadState(
      isNameValid: isNameValid ?? this.isNameValid,
      isFileValid: isFileValid ?? this.isFileValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''BookUploadState {
      isNameValid: $isNameValid,
      isFileValid: $isFileValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}