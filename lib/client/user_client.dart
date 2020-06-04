import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:sac_wallet/util/APIRequestHelper.dart';
import 'package:sac_wallet/util/ResponseMap.dart';
import 'package:sac_wallet/util/api_config.dart';
import 'package:sac_wallet/util/global.dart';
import 'package:sac_wallet/util/text_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'wallet_client.dart';
import '../model/user.dart';



class UserClient {
  
  SharedPreferences sharedPreferences;
  WalletClient walletClient;

  Future<bool> register({@required String username, @required String email, @required String password, @required String confirmed_password}) async {
    bool isRegistrationsuccessful = false;
    var requestBody = {
        'name': username,
        'email': email,
        'password': password,
        'password_confirmation': confirmed_password
      };
      var body = json.encode(requestBody);
      ResponseMap responseMap = await APIRequestHelper().doPostRequest(ApiConfig.REGISTRATION_URL, body);
      sharedPreferences = await SharedPreferences.getInstance();

      if(responseMap.body != null){
        final jsonResponse = convert.jsonDecode(responseMap.body);
        if(jsonResponse["message"] == TextUtil.REGISTRATION_SUCCESSFUL_MSG) {
          print("eth_wallet_address: ${jsonResponse["eth_wallet_address"]}");
          isRegistrationsuccessful = true;
          final userData = jsonResponse["user"];
          final user = User.fromApi(userData, jsonResponse["token"]);
          print(user.eth_wallet_address);
          final privateKey = user.privateKey;
          final currentUser = user;
          sharedPreferences.setString(TextUtil.PRIVATE_KEY, user.token);
          GlobalValue.privateKey = privateKey;
          GlobalValue.setCurrentUser = currentUser;

        }
      }
      return isRegistrationsuccessful;
  }

  Future<bool> login({@required String email, @required String password}) async {
    bool isLoginSuccessful = false;

    var requestBody = {
      'email': email,
      'password': password
    };

    var body = json.encode(requestBody);
    ResponseMap responseMap = await APIRequestHelper().doPostRequest(ApiConfig.LOGIN_URL, body);
    sharedPreferences = await SharedPreferences.getInstance();

    if(responseMap != null) {
      final jsonResponse = convert.jsonDecode(responseMap.body);
      if(jsonResponse["message"] == TextUtil.LOGIN_SUCCESSFUL_MSG) {
        isLoginSuccessful = true;
        print("token: ${jsonResponse["token"]}");
        final userData = jsonResponse["user"];
        print(jsonResponse["user"]);
        final user = User.fromApi(userData, jsonResponse["token"]);
        final privateKey = user.privateKey;
        final eth_wallet_address = user.eth_wallet_address;
        print("eth_wallet address: ${eth_wallet_address}");
        sharedPreferences.setString(TextUtil.PRIVATE_KEY, user.token);
        sharedPreferences.setString(TextUtil.ETH_WALLET_ADDRESS, user.eth_wallet_address);
        GlobalValue.privateKey = privateKey;
        User currentUser = new User(
          id: jsonResponse["ID"],
          token: jsonResponse["token"],
          name: jsonResponse["name"],
          email: email,
          photo: "",
          country: "",
          eth_wallet_address: jsonResponse["eth_wallet_address"],
          facebook_link: "",
          twitter_link: "",
          instagram_link: "",
          linkedin_link: "",
          enabledChat: false
        );
        GlobalValue.setCurrentUser = currentUser;

      }
    }

    return isLoginSuccessful;
    // try {
    //   AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    //   FirebaseUser firebaseUser = authResult.user;
    //   IdTokenResult userToken = await firebaseUser.getIdToken();
    //   DataSnapshot snapshot = await userRef.child(firebaseUser.uid).once();
    //   if(snapshot.value != null) {
    //     User user = User.create(snapshot);
    //     user.token = userToken.token;
    //     isSuccess = await updateUser(user: user);
    //     GlobalValue.setCurrentUser = user;
    //     sharedPreferences = await SharedPreferences.getInstance();
    //     //sharedPreferences.setString("wallet_address", user.eth_wallet_address);
    //     String privateKey = sharedPreferences.getString(firebaseUser.uid);
    //     sharedPreferences.setString("private_key", privateKey);
    //     GlobalValue.setPrivateKey = privateKey;
    //     return isSuccess;
    //   }else{
    //     print("Snapshot was null");
    //   }
    // } catch (error) {
    //   print(error.toString());
    //   return false;
    // }

    // return isSuccess;
  }

//   Future<bool> logout() async {
//     try {
//       FirebaseAuth.instance.signOut();
//       return true;
//     } catch (error) {
//       print(error);
//       return false;
//     }
//   }

//   Future<String> uploadPhoto({@required String uid, File imgFile}) async {
//     StorageUploadTask task = photoRef.child(uid + ".jpg").putFile(imgFile);
//     await task.onComplete;
//     String downloadUrl = await photoRef.child(uid + ".jpg").getDownloadURL();
//     return downloadUrl;
//   }

//   Future<bool> addUser({@required User user}) async {
//     try {
//       await userRef.child(user.id).set(user.toMap());
//       return true;
//     } catch (error) {
//       print(error);
//       return false;
//     }
//   }

//   Future<bool> updateUser({@required User user}) async {
//     try {
//       await userRef.child(user.id).update(user.toMap());
//       GlobalValue.setCurrentUser = user;
//       return true;
//     } catch (error) {
//       print(error);
//       return false;
//     }
//   }

//   Future<bool> addCompany({@required Company company, @required String userId}) async {
//     try {
//       await companyRef.child(userId).child(company.id).set(company.toMap());
//       return true;
//     } catch (error) {
//       print(error);
//       return false;
//     }
//   }

//   Future<bool> addNonProfit({@required Profit profit, @required String userId}) async {
//     try {
//       await profitRef.child(userId).child(profit.id).set(profit.toMap());
//       return true;
//     } catch (error) {
//       print(error);
//       return false;
//     }
//   }

 }