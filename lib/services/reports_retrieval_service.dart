import 'package:call_away/model/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ReportRetrievalState {}

class ReportRetrievalStateInitial extends ReportRetrievalState {}

class ReportRetrievalStateLoading extends ReportRetrievalState {}

class ReportRetrievalStateSuccess extends ReportRetrievalState {
  ReportRetrievalStateSuccess(this.reports);

  final List<Report> reports;
}

class ReportRetrievalStateError extends ReportRetrievalState {
  ReportRetrievalStateError(this.errorMessage);

  final String errorMessage;
}

class ReportRetrievalService extends StateNotifier<ReportRetrievalState> {
  ReportRetrievalService() : super(ReportRetrievalStateInitial());

  Future<void> getMyReports() async {
    print("getMyReports caled.");
    final user = FirebaseAuth.instance.currentUser;

    state = ReportRetrievalStateLoading();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("reports")
        .get()
        .then((value) {
      final jsonReports = value.docs.map((doc) => doc.data()).toList();

      final reports =
          jsonReports.map((report) => Report.fromJson(report)).toList();

      state = ReportRetrievalStateSuccess(reports);
    }).catchError((e) {
      state = ReportRetrievalStateError(e.toString());
    });
  }
}
