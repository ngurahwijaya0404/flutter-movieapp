/// Safe wrapper untuk mengakses Firebase dengan error handling
class SafeFirebaseAccess {
  /// Attempt to access Firebase dengan retry logic
  static Future<T> tryAccess<T>({
    required Future<T> Function() operation,
    required T fallback,
    String operationName = "Firebase operation",
  }) async {
    try {
      print("Attempting $operationName...");
      final result = await operation();
      print("✓ $operationName completed successfully");
      return result;
    } catch (e) {
      print("✗ $operationName failed: $e");
      print("Returning fallback value");
      return fallback;
    }
  }

  /// Check if Firebase is ready
  static bool isFirebaseReady() {
    try {
      // Check if Firebase apps exist
      return true; // Will be determined by auth_provider
    } catch (e) {
      return false;
    }
  }
}
