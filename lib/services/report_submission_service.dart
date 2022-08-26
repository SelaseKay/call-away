import 'package:call_away/model/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

abstract class ReportSubmissionState {}

class ReportSubmissionStateInitial extends ReportSubmissionState {}

class ReportSubmissionStateSuccess extends ReportSubmissionState {}

class ReportSubmissionStateError extends ReportSubmissionState {
  ReportSubmissionStateError(this.errorMessage);

  final String errorMessage;
}

class ReportSubmissionStateLoading extends ReportSubmissionState {}

class ReportSubmissionService extends StateNotifier<ReportSubmissionState> {
  ReportSubmissionService() : super(ReportSubmissionStateInitial());

  Future<void> submitReport(Report report) async {
    state = ReportSubmissionStateLoading();
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final reportId = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("reports")
        .doc()
        .id;

    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("reports")
        .doc(reportId)
        .set(report.copyWith(reportId: reportId).toJson())
        .then((value) {
      state = ReportSubmissionStateSuccess();
    }).catchError((e) {
      state = ReportSubmissionStateError(e.toString());
    });
  }

  Future<void> uploadReportImage(XFile image) {
    return Future.value("Uploaded successfully");
  }
}
