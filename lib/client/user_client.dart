import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:sac_wallet/util/api_config.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'wallet_client.dart';
import '../model/user.dart';
import '../model/company.dart';
import '../model/profit.dart';
import '../util/text_util.dart';
import '../util/global.dart';



class UserClient {
  // DatabaseReference userRef;
  // DatabaseReference companyRef;
  // DatabaseReference profitRef;
  // StorageReference photoRef;
  SharedPreferences sharedPreferences;
  WalletClient walletClient;
  

  // FirebaseClient() {
  //   userRef = FirebaseDatabase.instance.reference().child(TextUtil.USER_REF_TITLE);
  //   companyRef = FirebaseDatabase.instance.reference().child(TextUtil.COMPANY_REF_TITLE);
  //   profitRef = FirebaseDatabase.instance.reference().child(TextUtil.PROFIT_REF_TITLE);
  //   photoRef = FirebaseStorage.instance.ref();
  //   walletClient = new WalletClient();
  // }

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> register({@required String username, @required String email, @required String password, @required String confirmed_password}) async {
    var client = http.Client();
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      var authResult = await client.post(ApiConfig.BASE_URL + '/register', headers: ApiConfig.headers, body:<String, String>{ 
        'username': username,
        'email': email,
        'password': password,
        'confirmed_password': confirmed_password
      });
      print(authResult.body.toString());
      // FirebaseUser firebaseUser = authResult.user;
      // IdTokenResult userToken = await firebaseUser.getIdToken();
      // Map<String, dynamic> createWalletResult = await walletClient.createWallet();
      // if(authResult.statusCode == 201){
      //   String wallet_address = createWalletResult[TextUtil.ADDRESS];
      //   String privateKey = createWalletResult[TextUtil.PRIVATE_RESPONSE_KEY];
      //   sharedPreferences.setString(access_token, client.get(authResult.b));
      //   GlobalValue.privateKey = privateKey;
      //   User user = new User(
      //     id: firebaseUser.uid,
      //     token: userToken.token,
      //     name: name,
      //     email: email,
      //     photo: "",
      //     country: "",
      //     eth_wallet_address: wallet_address,
      //     facebook_link: "",
      //     twitter_link: "",
      //     instagram_link: "",
      //     linkedin_link: "",
      //     enabledChat: false
      //   );
      //   return await addUser(user: user);
      // } else {
      //   return false;
      // }

    } catch (error) {
     print(error);

    }
  }

//   Future<bool> login({@required String email, @required String password}) async {
//     bool isSuccess;
//     try {
//       AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
//       FirebaseUser firebaseUser = authResult.user;
//       IdTokenResult userToken = await firebaseUser.getIdToken();
//       DataSnapshot snapshot = await userRef.child(firebaseUser.uid).once();
//       if(snapshot.value != null) {
//         User user = User.create(snapshot);
//         user.token = userToken.token;
//         isSuccess = await updateUser(user: user);
//         GlobalValue.setCurrentUser = user;
//         sharedPreferences = await SharedPreferences.getInstance();
//         //sharedPreferences.setString("wallet_address", user.eth_wallet_address);
//         String privateKey = sharedPreferences.getString(firebaseUser.uid);
//         sharedPreferences.setString("private_key", privateKey);
//         GlobalValue.setPrivateKey = privateKey;
//         return isSuccess;
//       }else{
//         print("Snapshot was null");
//       }
//     } catch (error) {
//       print(error.toString());
//       return false;
//     }

//     return isSuccess;
//   }

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