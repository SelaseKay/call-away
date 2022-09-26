import 'package:call_away/model/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportStreamProvider =
    StreamProvider.autoDispose.family<Report, String>((ref, id) async* {
  final reportsStream = FirebaseFirestore.instance
      .collection("reports")
      .where("userId", isEqualTo: id)
      .snapshots();

  await for (var changes in reportsStream) {
    for (var change in changes.docChanges) {
      if (change.type == DocumentChangeType.modified) {
        final report = Report.fromJson(change.doc.data()!);
        yield report;
      }
    }
  }
});
