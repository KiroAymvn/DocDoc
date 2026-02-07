class ApiError {
  final int? statusCode;
  final String? nameError;
  final String? emailError;
  final String? phoneError;
  final String? genderError;
  final String? passwordError;
  final String ?message;

  ApiError({
      this.statusCode,
      this.nameError,
    this.emailError,
    this.phoneError,
    this.genderError,
    this.passwordError,
     this.message,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    // Helper to safely get the first error message from a list
    // because it will not always give me all the errors of the bad response
    // String? getFirstError(String key) {
    //   if (data is Map && data[key] is List && (data[key] as List).isNotEmpty) {
    //     return data[key][0].toString();
    //   }
    //   return null;
    // }

    String?getFirstError(String key){
      if(data is Map && data[key] !=null && data[key] is List ){
        return data[key][0];
      }
      return null;
    }
    return ApiError(
      statusCode: json['code'] as int?,
      message: json['message'] as String?,
      nameError: getFirstError('name'),
      emailError: getFirstError('email'),
      phoneError: getFirstError('phone'),
      genderError: getFirstError('gender'),
      passwordError: getFirstError('password'),
    );
  }}
