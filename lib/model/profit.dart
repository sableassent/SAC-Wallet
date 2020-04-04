import 'package:firebase_database/firebase_database.dart';
import '../util/text_util.dart';

class Profit {
  String id;
  String profitName;
  String userName;
  String userWalletAddress;
  String email;
  String phone;
  String organization;
  String location;
  String status;

  Profit({this.id, this.profitName, this.userName, this.userWalletAddress, this.email, this.phone, this.organization, this.location, this.status});

  factory Profit.fromServer(DataSnapshot snapshot) => Profit(
    id: snapshot.value[TextUtil.ID],
    profitName: snapshot.value[TextUtil.PROFIT_NAME],
    userName: snapshot.value[TextUtil.USER_NAME],
    userWalletAddress: snapshot.value[TextUtil.USER_WALLET_ADDRESS],
    email: snapshot.value[TextUtil.EMAIL],
    phone: snapshot.value[TextUtil.PHONE],
    organization: snapshot.value[TextUtil.ORGANIZATION],
    location: snapshot.value[TextUtil.LOCATION],
    status: snapshot.value[TextUtil.STATUS]
  );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[TextUtil.ID] = id;
    map[TextUtil.PROFIT_NAME] = profitName;
    map[TextUtil.USER_NAME] = userName;
    map[TextUtil.USER_WALLET_ADDRESS] = userWalletAddress;
    map[TextUtil.EMAIL] = email;
    map[TextUtil.PHONE] = phone;
    map[TextUtil.ORGANIZATION] = organization;
    map[TextUtil.LOCATION] = location;
    map[TextUtil.STATUS] = status;
    return map;
  }
}