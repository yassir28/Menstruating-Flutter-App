import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menstruating/models/queen.dart';

class DataBaseService {
  final String uid;
  DataBaseService({this.uid});

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Queens');

  Future updateUserData(
      {int periodLength, int periodCycle, Timestamp periodDate}) async {
    return await userCollection.doc(uid).set({
      'period length': periodLength,
      'period cycle': periodCycle,
      'period date': periodDate
    }, SetOptions(merge: true));
  }

// queen list from snapshot
  List<Queen> _queenListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Queen(
        periodCycle: doc.data()['period cycle'] ?? 28,
        periodLength: doc.data()['period length'] ?? 3,
        periodDate: doc.data()['period date'] ?? null,
      );
    }).toList();
  }

// when data change in db we use can use this stream to provide us with changes
  Stream<List<Queen>> get queens {
    return userCollection
        .snapshots()
        .map((snapshot) => _queenListFromSnapshot(snapshot));
  }
}
