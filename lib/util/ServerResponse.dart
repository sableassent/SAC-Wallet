class ServerResponse{
  static const int VALIDATION_ERROR = 500;
  static const int SUCCESS = 200;
  String message;
  int id;
  String code;
  ServerResponse(this.code, this.message, this.id);

  ServerResponse.toJson(Map<String, dynamic> response){
    message = response["responseMessage"];
    id = response["responseID"] as int;
    code = response["status"];
  }

}