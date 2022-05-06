import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vroom_core/models/bus.dart';
import 'package:vroom_core/models/notification.dart';
import 'package:vroom_core/models/payment_receipt.dart';
import 'package:vroom_core/models/ticket.dart';
import 'package:vroom_core/models/trip.dart';
import 'package:vroom_core/utils/extensions.dart';


Future<List<Bus>> getAvailableBuses({DateTime? date}) async {
  List<Bus> buses = [];
  DateTime _date = DateTime.now();

  if (date == null){//if no bus date is given, check buses for today
    DateTime now = DateTime.now();
    _date = DateTime(now.year, now.month, now.day);
  } else {
    _date = DateTime(date.year, date.month, date.day);
  }


  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  QuerySnapshot<Map<String, dynamic>> results = await firestore.collection("public/bus_system/departure")
      .where("departureDate", isEqualTo: _date.toIso8601String(),).get();


  for (QueryDocumentSnapshot<Map<String,dynamic>> trip in results.docs) {
    Map<String,dynamic> data = {};
    // data["id"] = DateTime.parse(trip.id);
    data.addAll(trip.data());
    buses.add(Bus.fromJson(trip.data()));
  }

  return buses;
}

Future<List<Ticket>> getUserHistory(String id) async {
  List<Ticket> reciepts = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot<Map<String, dynamic>> results = await firestore.collection("public/bus_system/departure")
  .where("userId",isEqualTo: id).get();

  for (QueryDocumentSnapshot<Map<String,dynamic>> document in results.docs){
    reciepts.add(Ticket.fromJson(document.data()));
  }



  return reciepts;
}

Future<double> getAdvancePaymentBalance(String userId) async{

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentSnapshot<Map<String, dynamic>> results = await firestore.doc("public/user_info/$userId/advance_balance").get();

  if (results.exists){
    return results.data()!["balance"];
  }

  return 0;
}

Future<void> recordPayment(PaymentReceipt receipt) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  DocumentReference<Map<String, dynamic>> doc =  firestore.collection("public/transactions/payments").doc(receipt.id);
  
  await doc.set(receipt.toJson());
  if (receipt.type == PaymentType.advance) {
    await recordAdvancedPayment(userId: receipt.userId, amount: receipt.amount);
  }
}


Future<List<PaymentReceipt>> getUserTransactions (String userId) async {
  List<PaymentReceipt> receipts = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> docs = await firestore.collection("public/transactions/payments").where("userId", isEqualTo: userId).get();

  for (DocumentSnapshot<Map<String,dynamic>> e in docs.docs){
    receipts.add(PaymentReceipt.fromJson(e.data()!));
  }
  return receipts;
}


Future<void> recordAdvancedPayment({required String userId, required double amount}) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentSnapshot<Map<String, dynamic>> balance = await firestore.doc("public/user_info/$userId/advance_balance").get();

  if (balance.exists) {
    double current = await balance.data()!["balance"];
    current += amount;
    await balance.reference.update({"balance" : current});
  } else {
    await balance.reference.set({"balance" : amount});
  }
}

Future<List<NotificationModel>> getNotifications() async {
  List<NotificationModel> notifications = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot<Map<String, dynamic>> results = await firestore.collection("public/communication/notifications").get();
  // print(results.toString());

  for (QueryDocumentSnapshot<Map<String,dynamic>> document in results.docs){
    // print(document.data()['actions'] ?? NotificationAction.indicateLateness);
    notifications.add(NotificationModel.fromJson(document.data()));
  }
  // print(notifications);
  return notifications;
}


Future<String> uploadImage({required String id, required File image}) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  TaskSnapshot upload = await storage.ref("users/profile/$id").putFile(image);
  return await upload.ref.getDownloadURL();
}

Future<Ticket?> getUnusedTicket(String userId) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot<Map<String, dynamic>> results = await firestore
      .collection("public/communication/notifications").where("userId",isEqualTo: "userId" )
      .where("status", isEqualTo: "active").get();
  // print(results.toString());

  if (results.docs.isNotEmpty){
    return Ticket.fromJson(results.docs.first.data());
  }

  return null;
}





Future<List<Trip>> getTrips({DateTime? date}) async {
  List<Trip> trips = [];
  DateTime _date = DateTime.now().noTime();

  if (date != null){
    _date = date.noTime();
  }


  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot<Map<String, dynamic>> results = await firestore.collection("public/bus_system/departure")
      .where("tripDate", isEqualTo: _date.toIso8601String()).get();
  // .collection(_date.toIso8601String()).get();



  for (QueryDocumentSnapshot<Map<String,dynamic>> trip in results.docs) {
    Map<String,dynamic> data = {};
    // data.addAll(trip.data());
    data.addAll(trip.data());
    data['id'] = trip.id;
    trips.add(Trip.fromJson(trip.data()));
  }

  return trips;
}

Future<Trip?> getUpcomingTrip (String userId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> result = await firestore
      .collection("public/bus_system/departure")
      .where("driverId", isEqualTo: userId)
      .get();

  for (QueryDocumentSnapshot<Map<String,dynamic>> doc in result.docs){
    Trip trip =  Trip.fromJson(result.docs.first.data());
    if (trip.tripDate.noTime().isAfter(DateTime.now().noTime()) && trip.setOffTime.isAfter(DateTime.now().toTimeOfDay())){
      return trip;
    }
  }

  return null;
}

Future<List<Bus>> getAllBuses() async {
  List<Bus> bus = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> docs = await firestore.collection("public/bus_system/buses").get();
  for (DocumentSnapshot<Map<String,dynamic>> info in docs.docs){
    bus.add(Bus.fromJson(info.data()!));
  }
  return bus;
}

Future<void> editTrip(Trip trip) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  await firestore.collection("public/bus_system/departure").doc(trip.tripId).set(trip.toJson());

}

Future<void> uploadTrip(Trip trip) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference doc = firestore.collection("public/bus_system/departure").doc();
  trip.tripId = doc.id;
  await doc.set(trip.toJson());

}

Future<List<Ticket>> getTripTickets(String tripId) async {
  List<Ticket> tickets = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot<Map<String, dynamic>> results = await firestore.collection("public/transactions/tickets").where("tripId", isEqualTo: tripId).get();

  for (DocumentSnapshot<Map<String,dynamic>> doc in results.docs){
    tickets.add(Ticket.fromJson(doc.data()!));
  }

  return tickets;
}


Future<Ticket?> getTripById(String id) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentSnapshot<Map<String, dynamic>> result = await firestore.collection("public/transactions/tickets").doc(id).get();
  if (result.exists){
    return Ticket.fromJson(result.data()!);
  }
  return null;
}
