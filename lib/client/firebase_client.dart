import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'wallet_client.dart';
import '../model/user.dart';
import '../model/company.dart';
import '../model/profit.dart';
import '../util/text_util.dart';
import '../util/global.dart';

Future<FirebaseApp> conf() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'sacwallet', 
    options: FirebaseOptions(
      googleAppID: '1:556610869141:android:1966417e70ffc76955489c',
      apiKey:  'AIzaSyC4DQd2Z49XjknWQNOOe1wsU7IZKmEMAJE',
      databaseURL: 'https://sacwallet.firebaseio.com'
      )
    
    );
  
  return app;
}

class FirebaseClient {
  DatabaseReference userRef;
  DatabaseReference companyRef;
  DatabaseReference profitRef;
  StorageReference photoRef;
  SharedPreferences sharedPreferences;
  WalletClient walletClient;

  FirebaseClient() {
    userRef = FirebaseDatabase.instance.reference().child(TextUtil.USER_REF_TITLE);
    companyRef = FirebaseDatabase.instance.reference().child(TextUtil.COMPANY_REF_TITLE);
    profitRef = FirebaseDatabase.instance.reference().child(TextUtil.PROFIT_REF_TITLE);
    photoRef = FirebaseStorage.instance.ref();
    walletClient = new WalletClient();
  }

  Future<bool> register({@required String name, @required String email, @required String password}) async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      AuthResult authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      IdTokenResult userToken = await firebaseUser.getIdToken();
      Map<String, dynamic> createWalletResult = await walletClient.createWallet();
      if(createWalletResult[TextUtil.STATUS]){
        String wallet_address = createWalletResult[TextUtil.ADDRESS];
        String privateKey = createWalletResult[TextUtil.PRIVATE_RESPONSE_KEY];
        sharedPreferences.setString(firebaseUser.uid, privateKey);
        GlobalValue.privateKey = privateKey;
        User user = new User(
          id: firebaseUser.uid,
          token: userToken.token,
          name: name,
          email: email,
          photo: "",
          country: "",
          eth_wallet_address: wallet_address,
          facebook_link: "",
          twitter_link: "",
          instagram_link: "",
          linkedin_link: "",
          enabledChat: false
        );

        return await addUser(user: user);
      } else {
        return false;
      }

    } catch (error) {
      return false;
    }
  }

  Future<bool> login({@required String email, @required String password}) async {
    print('$email - $password');
    try {
      AuthResult authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      print("authResult: $authResult");
      FirebaseUser firebaseUser = authResult.user;
      IdTokenResult userToken = await firebaseUser.getIdToken();
      DataSnapshot snapshot = await userRef.child(firebaseUser.uid).once();
      User user = User.fromServer(snapshot);
      user.token = userToken.token;
      bool isSuccess = await updateUser(user: user);
      GlobalValue.setCurrentUser = user;
      sharedPreferences = await SharedPreferences.getInstance();
      String privateKey = sharedPreferences.getString(firebaseUser.uid);
      GlobalValue.setPrivateKey = privateKey;
      print(user);
      return isSuccess;
    } catch (error) {
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      FirebaseAuth.instance.signOut();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<String> uploadPhoto({@required String uid, File imgFile}) async {
    StorageUploadTask task = photoRef.child(uid + ".jpg").putFile(imgFile);
    await task.onComplete;
    String downloadUrl = await photoRef.child(uid + ".jpg").getDownloadURL();
    return downloadUrl;
  }

  Future<bool> addUser({@required User user}) async {
    try {
      await userRef.child(user.id).set(user.toMap());
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> updateUser({@required User user}) async {
    try {
      await userRef.child(user.id).update(user.toMap());
      GlobalValue.setCurrentUser = user;
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> addCompany({@required Company company, @required String userId}) async {
    try {
      await companyRef.child(userId).child(company.id).set(company.toMap());
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> addNonProfit({@required Profit profit, @required String userId}) async {
    try {
      await profitRef.child(userId).child(profit.id).set(profit.toMap());
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

}