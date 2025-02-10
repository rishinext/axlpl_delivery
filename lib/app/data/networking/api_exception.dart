class AppException implements Exception {
  final String message;

  const AppException(this.message);

  factory AppException.connectivity() =>
      const AppException("No Internet Connection");

  factory AppException.unauthorized() =>
      const AppException("Unauthorized Access");

  factory AppException.forbidden() => const AppException("Access Forbidden");

  factory AppException.notFound() => const AppException("Resource Not Found");

  factory AppException.badGateway() =>
      const AppException("Bad Gateway - Server Error");

  factory AppException.serverError() =>
      const AppException("Internal Server Error");

  factory AppException.errorWithMessage(String message) =>
      AppException(message);

  factory AppException.error() => const AppException("Something went wrong");
}
