enum PaymentMethod {
  momo,
  card
}

enum PaymentType{
  advance,
  standard
}

class PaymentReceipt {
  String id;
  String userId;
  String txtRef;
  double amount;
  PaymentType type;
  PaymentMethod method;
  DateTime paymentDate;

  PaymentReceipt({
    required this.id,
    required this.userId,
    required this.txtRef,
    required this.amount,
    required this.method,
    required this.type,
    required this.paymentDate,
});


  factory PaymentReceipt.fromJson (Map<String,dynamic> map) {
    PaymentMethod method = PaymentMethod.values.firstWhere((element) => element.name == map["method"]);
    PaymentType type = PaymentType.values.firstWhere((element) => element.name == map["type"]);

    return PaymentReceipt(
        id: map["id"],
        userId: map["userId"],
        txtRef: map["txtRef"],
        amount: map["amount"],
        method: method,
        type: type,
        paymentDate: DateTime.parse(map["paymentDate"])
    );

  }

  Map<String,dynamic> toJson() => {
    "id" : id,
    "userId" : userId,
    "txtRef" : txtRef,
    "amount" : amount,
    "method" : method.name,
    "type" : type.name,
    "paymentDate" : paymentDate.toIso8601String()
  };
}