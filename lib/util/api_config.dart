class ApiConfig {
  static final String BASE_URL = "https://sableassent.net/api/public/api/";
  static final headers = {'Content-Type': 'applicatin/json'};
  static final String API_BASE_URL = "https://evening-fjord-11708.herokuapp.com";
  static final String API_CREATE_WALLET = "${API_BASE_URL}/create_wallet";
  static final String API_CHECK_ADDRESS = "${API_BASE_URL}/check_address";
  static final String API_ETH_BALANCE = "${API_BASE_URL}/eth_balance";
  static final String API_SEND_TOKEN = "${API_BASE_URL}/send_token";
  static final String API_GET_TRANSACTION_HISTORY = "http://api.etherscan.io/api";
}