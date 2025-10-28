/// Abstract interface for authentication endpoints
abstract class MetadataAuthEndpointInterface {
  /// Stream of authentication state changes
  Stream get authStateStream;

  /// Authenticate the user
  Future<void> authenticate();

  /// Check if the user is authenticated
  bool isAuthenticated();

  /// Logout the user
  Future<void> logout();
}
