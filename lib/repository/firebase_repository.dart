import 'dart:io';
import 'package:meta/meta.dart';
import '../client/firebase_client.dart';
import '../model/user.dart';
import '../model/company.dart';
import '../model/profit.dart';

class FirebaseRepository {
  final FirebaseClient firebaseClient = new FirebaseClient();

  Future<bool> register({@required String name, @required String email, @required String password}) async => await firebaseClient.register(name: name, email: email, password: password);

  Future<bool> login({@required String email, @required String password}) async => await firebaseClient.login(email: email, password: password);

  Future<bool> logout() async => await firebaseClient.logout();

  Future<String> uploadPhoto({@required String uid, File imgFile}) async => await firebaseClient.uploadPhoto(uid: uid, imgFile: imgFile);

  Future<bool> addUser({@required User user}) async => await firebaseClient.addUser(user: user);

  Future<bool> updateUser({@required User user}) async => await firebaseClient.updateUser(user: user);

  Future<bool> addCompany({@required Company company, @required String userId}) async => await firebaseClient.addCompany(company: company, userId: userId);


  Future<bool> addNonProfit({@required Profit profit, @required String userId}) async => await firebaseClient.addNonProfit(profit: profit, userId: userId);

}