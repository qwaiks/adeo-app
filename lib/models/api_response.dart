

class ApiResponse {
  int get totalDataCount => body["meta"]["total"];

  int get totalPageCount => body["meta"]["last_page"];



  List get data => body["data"];

  Map get mappedData => body["data"];

  bool get allGood => errors.isEmpty;
  int code;
  String message;
  dynamic body;
  List errors;

  ApiResponse({
    this.code,
    this.message,
    this.body,
    this.errors,
  });

  factory ApiResponse.parse(response) {
    if (response != null) {
      int code = response.statusCode;
      dynamic body = response.data ?? null; // Would mostly be a Map
      List errors = [];
      String message = "";

      switch (code) {
        case 200:
          if (body is String) {
            message = body;
          } else {
            if (body.containsKey("data")) {
              if (body["data"] is Map) {
                message = body["data"]["message"];
              }
            }
          }
          break;
        case 201:
          message = body["message"];
          break;
        case 204:
          message = "Operation successful";
          break;
        case 401:
          if (body["error"] != null) errors.add(body["error"]);
          if (body["error"] == null) {
            errors.add(body["message"]);
            // Log em out

          }
          message = errors[0];

          break;
        case 403:
          if (body["data"] == null)
            errors.add(body["message"]);
          else
            errors.add(body["data"]["message"]);
          message = errors[0];
          break;
        case 422:
          body["errors"].forEach((final String key, final value) {
            for (int i = 0; i < body["errors"][key].length; i++) {
              errors.add(body["errors"][key][i]);
            }
          });
          message = errors[0];
          break;
        case 500:
          message = "Whoops! Something went wrong, please contact support.";
          errors.add(message);
          //print(body);
          break;
        default:
          message = "Unknown application error.";
          errors.add(message);
          break;
      }

      return ApiResponse(
        code: code,
        message: message,
        body: code == 204
            ? null
            : body is String
                ? null
                : body,
        errors: errors,
      );
    } else {
      return ApiResponse(
        code: 500,
        message: "Something went wrong. Please try again.",
      );
    }
  }
}
