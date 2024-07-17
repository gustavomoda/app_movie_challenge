class ClientOptions {
  ClientOptions({
    required this.baseUrl,
    this.globalTimeout = const Duration(seconds: 30),
    this.connectTimeout = const Duration(seconds: 10),
    this.sendTimeout = const Duration(seconds: 10),
    this.receiveTimeout = const Duration(seconds: 10),
  });

  final String baseUrl;
  final Duration connectTimeout;
  final Duration sendTimeout;
  final Duration receiveTimeout;
  final Duration globalTimeout;
}
