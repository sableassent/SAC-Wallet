import 'package:firebase_database/firebase_database.dart';
import '../util/text_util.dart';

class User {
  String id;
  String token;
  String name;
  String description;
  String email;
  String photo;
  String country;
  String eth_wallet_address;
  String facebook_link;
  String twitter_link;
  String instagram_link;
  String linkedin_link;
  bool enabledChat;

  User({this.id, this.token, this.name, this.description, this.email, this.photo, this.country, this.eth_wallet_address, this.facebook_link, this.twitter_link, this.instagram_link, this.linkedin_link, this.enabledChat});

  factory User.fromServer(DataSnapshot snapshot) => User(
    id: snapshot.key,
    token: snapshot.value[TextUtil.TOKEN],
    name: snapshot.value[TextUtil.NAME],
    description: snapshot.value[TextUtil.DESCRIPTION],
    email: snapshot.value[TextUtil.EMAIL],
    photo: snapshot.value[TextUtil.PHOTO],
    country: snapshot.value[TextUtil.COUNTRY],
    eth_wallet_address: snapshot.value[TextUtil.ETH_WALLET_ADDRESS],
    facebook_link: snapshot.value[TextUtil.FACEBOOK_LINK],
    twitter_link: snapshot.value[TextUtil.TWITTER_LINK],
    instagram_link: snapshot.value[TextUtil.INSTAGRAM_LINK],
    linkedin_link: snapshot.value[TextUtil.LINKEDIN_LINK],
    enabledChat: snapshot.value[TextUtil.ENABLED_CHAT]
  );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[TextUtil.ID] = id;
    map[TextUtil.TOKEN] = token;
    map[TextUtil.NAME] = name;
    map[TextUtil.DESCRIPTION] = description;
    map[TextUtil.EMAIL] = email;
    map[TextUtil.PHOTO] = photo;
    map[TextUtil.COUNTRY] = country;
    map[TextUtil.ETH_WALLET_ADDRESS] = eth_wallet_address;
    map[TextUtil.FACEBOOK_LINK] = facebook_link;
    map[TextUtil.TWITTER_LINK] = twitter_link;
    map[TextUtil.INSTAGRAM_LINK] = instagram_link;
    map[TextUtil.LINKEDIN_LINK] = linkedin_link;
    map[TextUtil.ENABLED_CHAT] = enabledChat;
    return map;
  }

}