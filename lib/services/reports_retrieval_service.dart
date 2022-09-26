import 'package:call_away/model/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ReportsState {}

class ReportsStateInitial extends ReportsState {}

class ReportsStateLoading extends ReportsState {}

class ReportsStateSuccess extends ReportsState {
  ReportsStateSuccess(this.reports);

  final List<Report> reports;
}

class ReportsStateError extends ReportsState {
  ReportsStateError(this.errorMessage);

  final String errorMessage;
}

class ReportRetrievalService extends StateNotifier<ReportsState> {
  ReportRetrievalService() : super(ReportsStateInitial());

  Future<void> getMyReports() async {
    print("getMyReports called.");

    state = ReportsStateLoading();

    final user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection("reports")
        .orderBy("currentStatus", descending: true)
        .where("userId", isEqualTo: user!.uid)
        .get()
        .then((value) {
      final jsonReports = value.docs.map((doc) => doc.data()).toList();

      final reports =
          jsonReports.map((report) => Report.fromJson(report)).toList();

      state = ReportsStateSuccess(reports);
    }).catchError((e) {

      state = ReportsStateError(e.toString());
      print("Error: ${e.toString()}");
    });
  }
}
