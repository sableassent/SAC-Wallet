import 'package:flutter/material.dart';
import 'package:sac_wallet/app_config.dart';
import 'package:sac_wallet/util/api_config.dart';

import 'main_common.dart';

void main() {
  var configuredApp = AppConfig(
    config: ApiConfig(
        BASE_URL: "",
        ETHEREUM_NET: "api",
        CONTRACT_ADDRESS: "",
        kGoogleApiKey: "",
        ETHERSCAN_API_KEY: ""),
    child: MyApp(),
  );

  mainCommon();

  runApp(configuredApp);
}
