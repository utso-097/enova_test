class DynamicLinkResponse {
  String? message;
  bool? error;
  int? statusCode;
  int? optionalCode;
  List? data;

  DynamicLinkResponse(
      {this.message,
        this.error,
        this.statusCode,
        this.optionalCode,
        this.data});

  DynamicLinkResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    statusCode = json['statusCode'];
    optionalCode = json['optionalCode'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['statusCode'] = this.statusCode;
    data['optionalCode'] = this.optionalCode;
    data['data'] = this.data;
    return data;
  }
}