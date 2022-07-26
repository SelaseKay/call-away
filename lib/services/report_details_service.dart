import 'package:call_away/model/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ReportDetailsState {}

class ReportDetailsStateInitial extends ReportDetailsState {}

class ReportDetailsStateLoading extends ReportDetailsState {}

class ReportDetailsStateSuccess extends ReportDetailsState {
  ReportDetailsStateSuccess(this.report);

  final Report report;
}

class ReportDetailsStateError extends ReportDetailsState {
  ReportDetailsStateError(this.errorMessage);

  final String errorMessage;
}

class ReportDetailsService extends StateNotifier<ReportDetailsState> {
  ReportDetailsService() : super(ReportDetailsStateInitial());

  Future<void> getReport(String reportId) async{
    state = ReportDetailsStateLoading();

    FirebaseFirestore.instance
        .collection("reports")
        .doc(reportId)
        .get()
        .then((value) {
      final report = Report.fromJson(value.data()!);
      state = ReportDetailsStateSuccess(report);
    }).catchError((e) {
      state = ReportDetailsStateError(e.toString());
    });
  }
}
