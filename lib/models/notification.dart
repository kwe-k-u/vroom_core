enum NotificationSender {
  administrator,
  driver
}

enum NotificationAction{
  indicateLateness
}

class NotificationModel{
  final NotificationSender sender;
  final String message;
  final DateTime dateSent;
  final List<NotificationAction>? actions;


  NotificationModel({
    required this.sender,
    required this.message,
    required this.actions,
    required this.dateSent
});


  factory NotificationModel.fromJson(Map<String,dynamic> map) => NotificationModel(
    sender: NotificationSender.values.firstWhere((element) => element.name == map["sender"]),
    message: map["message"],
    dateSent: DateTime.parse(map["dateSent"]),
    actions: map['actions'] != null ? [NotificationAction.indicateLateness] : null
  );

}