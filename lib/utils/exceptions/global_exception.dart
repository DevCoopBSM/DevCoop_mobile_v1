class GlobalException implements Exception {
  final String message;
  final String? code;

  GlobalException(this.message, {this.code});

  @override
  String toString() {
    return 'GlobalException{message: $message, code: $code}';
  }
}
