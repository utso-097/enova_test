class ApiInfo {
  final String ip;

  ApiInfo({required this.ip});

  factory ApiInfo.fromJson(Map<String, dynamic> json) {
    return ApiInfo(
      ip: json['ip'],
    );
  }
}