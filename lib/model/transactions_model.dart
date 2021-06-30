class TransactionsModel {
  String hash;
  String timeStamp;
  String blockNumber;
  String nonce;
  String blockHash;
  String from;
  String contractAddress;
  String to;
  String value;
  String tokenName;
  String tokenSymbol;
  String tokenDecimal;
  String transactionIndex;
  String gas;
  String gasPrice;
  String gasUsed;
  String cumulativeGasUsed;
  String input;
  String confirmations;
  String type;

  TransactionsModel(
      {this.hash,
      this.timeStamp,
      this.blockHash,
      this.nonce,
      this.blockNumber,
      this.from,
      this.contractAddress,
      this.to,
      this.value,
    this.tokenName,
    this.tokenSymbol,
    this.tokenDecimal,
    this.transactionIndex,
    this.gas,
    this.gasPrice,
    this.gasUsed,
    this.cumulativeGasUsed,
    this.input,
    this.confirmations,
    this.type});

  // Mapping of <databasecolumnname>: to json key
  Map<String, dynamic> toMap() {
    return {
      'hash': hash,
      'timeStamp': timeStamp,
      'blockNumber': blockNumber,
      'nonce': nonce,
      'blockHash': blockHash,
      'fromuser': from,
      'contractAddress': contractAddress,
      'touser': to,
      'value': value,
      'tokenName': tokenName,
      'tokenSymbol': tokenSymbol,
      'tokenDecimal': tokenDecimal,
      'transactionIndex': transactionIndex,
      'gas': gas,
      'gasPrice': gasPrice,
      'gasUsed': gasUsed,
      'cumulativeGasUsed': cumulativeGasUsed,
      'input': input,
      'confirmations': confirmations,
      'type': type
    };
  }

  factory TransactionsModel.fromJSON(Map<String, dynamic> dataObj) =>
      TransactionsModel(
        hash: dataObj["hash"],
        timeStamp: dataObj["timeStamp"],
        blockNumber: dataObj["blockNumber"],
        nonce: dataObj["nonce"],
        blockHash: dataObj["blockHash"],
        from: dataObj["from"],
        contractAddress: dataObj["contractAddress"],
        to: dataObj["to"],
        value: dataObj["value"],
        tokenName: dataObj["tokenName"],
        tokenSymbol: dataObj["tokenSymbol"],
        tokenDecimal: dataObj["tokenDecimal"],
        transactionIndex: dataObj["transactionIndex"],
        gas: dataObj["gas"],
        gasPrice: dataObj["gasPrice"],
        gasUsed: dataObj["gasUsed"],
        cumulativeGasUsed: dataObj["cumulativeGasUsed"],
        input: dataObj["input"],
        confirmations: dataObj["confirmations"],
          type: dataObj["type"]
      );
}
