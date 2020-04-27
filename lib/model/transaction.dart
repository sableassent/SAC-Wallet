class Transaction {
  String from;
  String to;
  String amount;
  String hash;
  String timeStamp;

  Transaction({this.from, this.to, this.amount, this.hash, this.timeStamp});
  Transaction.name(this.from, this.to, this.amount, this.hash, this.timeStamp);

  factory Transaction.fromJSON(Map<String, dynamic> dataObj) => Transaction(
    from: dataObj["from"],
    to: dataObj["to"],
    amount: dataObj["value"],
    hash: dataObj["hash"],
    timeStamp: dataObj["timeStamp"]
  );
}