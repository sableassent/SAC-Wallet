import 'package:http/http.dart' as http;
import 'dart:async';
import 'ResponseMap.dart';
class APIRequestHelper {

  static final int SUCCESS_CODE = 200;

  Future<ResponseMap> doGetRequest(final String url, final String apiKey) async{
    print("getting data from url: $url");
    int responseCode = 0;
    String body;
    String error;
      var response = await http.get(url,
          headers: {"Authorization": apiKey},
      );
      responseCode = response.statusCode;
      if(response.statusCode == 200){
        body =  response.body.toString();
      }else{
        //
      }
    return ResponseMap(responseCode, body, error);
  }

  Future<ResponseMap> doPostRequest(final String url, final String requestBody) async{
    int responseCode = 0;
    String returnBody;
    String error;
    print(requestBody.toString());
      var response = await http.post(url,
          body: requestBody,
        headers: {"Authorization": "", "Content-Type": "application/json", },
      );
      responseCode = response.statusCode;
      if(response.statusCode == 201){
        print("Success");
        returnBody =  response.body.toString();
      }
      //print("Response from ${url} - ${response.body.toString()} - Code: ${response.statusCode}");
    return ResponseMap(responseCode, returnBody, error);
  }


  Future<ResponseMap> doDeleteRequest(final String url) async{
    int responseCode = 0;
    String returnBody;
    String error;
      var response = await http.delete(url,
          headers: {"Authorization": "",
            "Content-Type": "application/json",
            "userType": ""}
      );
      responseCode = response.statusCode;
      if(response.statusCode == 200){
        returnBody =  response.body.toString();
      }
    return ResponseMap(responseCode, returnBody, error);
  }


}