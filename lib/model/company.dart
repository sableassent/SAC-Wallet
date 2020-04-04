import 'package:firebase_database/firebase_database.dart';
import '../util/text_util.dart';

class Company {
  String id;
  String companyName;
  String userName;
  String userWalletAddress;
  String industry;
  String location;
  String year;
  String phone;
  String email;
  String website;
  String facebookLink;
  String twitterLink;
  String instagramLink;

  Company({this.id, this.companyName, this.userName, this.userWalletAddress, this.industry, this.location, this.year, this.phone, this.email, this.website, this.facebookLink, this.twitterLink, this.instagramLink});

  factory Company.fromServer(DataSnapshot snapshot) => Company(
    id: snapshot.value[TextUtil.ID],
    companyName: snapshot.value[TextUtil.COMPANY_NAME],
    userName: snapshot.value[TextUtil.USER_NAME],
    userWalletAddress: snapshot.value[TextUtil.USER_WALLET_ADDRESS],
    industry: snapshot.value[TextUtil.INDUSTRY],
    location: snapshot.value[TextUtil.LOCATION],
    year: snapshot.value[TextUtil.YEAR],
    phone: snapshot.value[TextUtil.PHONE],
    email: snapshot.value[TextUtil.EMAIL],
    website: snapshot.value[TextUtil.WEBSITE],
    facebookLink: snapshot.value[TextUtil.FACEBOOK_LINK],
    twitterLink: snapshot.value[TextUtil.TWITTER_LINK],
    instagramLink: snapshot.value[TextUtil.INSTAGRAM_LINK]
  );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[TextUtil.ID] = id;
    map[TextUtil.COMPANY_NAME] = companyName;
    map[TextUtil.USER_NAME] = userName;
    map[TextUtil.USER_WALLET_ADDRESS] = userWalletAddress;
    map[TextUtil.INDUSTRY] = industry;
    map[TextUtil.LOCATION] = location;
    map[TextUtil.YEAR] = year;
    map[TextUtil.PHONE] = phone;
    map[TextUtil.EMAIL] = email;
    map[TextUtil.WEBSITE] = website;
    map[TextUtil.FACEBOOK_LINK] = facebookLink;
    map[TextUtil.TWITTER_LINK] = twitterLink;
    map[TextUtil.INSTAGRAM_LINK] = instagramLink;
    return map;
  }
}