import 'dart:io';

import 'package:call_away/model/mediaType.dart';
import 'package:call_away/model/report.dart';
import 'package:call_away/provider/camera_image_provider.dart';
import 'package:call_away/provider/video_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

abstract class ReportSubmissionState {}

class ReportSubmissionStateInitial extends ReportSubmissionState {}

class ReportSubmissionStateSuccess extends ReportSubmissionState {
  ReportSubmissionStateSuccess(this.successMessage);

  final String successMessage;
}

class ReportSubmissionStateError extends ReportSubmissionState {
  ReportSubmissionStateError(this.errorMessage);

  final String errorMessage;
}

class ReportSubmissionStateLoading extends ReportSubmissionState {}

class ReportSubmissionService extends StateNotifier<ReportSubmissionState> {
  ReportSubmissionService(this.ref) : super(ReportSubmissionStateInitial());

  final AutoDisposeStateNotifierProviderRef<ReportSubmissionService,
      ReportSubmissionState> ref;

  Future<void> submitReport(Report report) async {
    state = ReportSubmissionStateLoading();

    final userId = FirebaseAuth.instance.currentUser?.uid;

    final reportImage = ref.read(cameraImageProvider.notifier).state;

    late String imageUrl;

    if (report.mediaType == MediaType.IMAGE) {
      imageUrl = await _uploadReportImage(reportImage!);
    } else {
      final reportVideo = ref.read(videoProvider.notifier).state;
      imageUrl = await _uploadReportVideo(reportVideo![0]);
    }

    // final reportId = FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(userId);
    final reportId = FirebaseFirestore.instance.collection("reports").doc().id;

    FirebaseFirestore.instance
        .collection("reports")
        .doc(reportId)
        .set(report
            .copyWith(reportId: reportId, imageUrl: imageUrl, userId: userId)
            .toJson())
        .then((value) {
      state = ReportSubmissionStateSuccess("Report submitted successfully");
    }).catchError((e) {
      state = ReportSubmissionStateError(e.toString());
    });

    // FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(userId)
    //     .collection("reports")
    //     .doc(reportId)
    //     .set(report
    //         .copyWith(
    //           reportId: reportId,
    //           imageUrl: imageUrl,
    //         )
    //         .toJson())
    //     .then((value) {
    //   state = ReportSubmissionStateSuccess("Report submitted successfully");
    // }).catchError((e) {
    //   state = ReportSubmissionStateError(e.toString());
    // });
  }

  Future<String> _uploadReportImage(XFile image) async {
    final storageRef = FirebaseStorage.instance.ref();

    final reportImageRef = storageRef.child(image.name);

    final imageFile = File(image.path);

    var imageUrl = "";

    try {
      await reportImageRef.putFile(imageFile);
      imageUrl = await reportImageRef.getDownloadURL();
    } on FirebaseFirestore catch (e) {
      state = ReportSubmissionStateError(e.toString());
      return Future.error(e.toString());
    }
    return imageUrl;
  }

  Future<String> _uploadReportVideo(File image) async {
    final storageRef = FirebaseStorage.instance.ref();

    final reportImageRef = storageRef.child(const Uuid().v4());

    final imageFile = File(image.path);

    var imageUrl = "";

    try {
      await reportImageRef.putFile(imageFile);
      imageUrl = await reportImageRef.getDownloadURL();
    } on Exception {
      state = ReportSubmissionStateError('Error uploading video');
      return Future.error('Error uploading video');
    }
    return imageUrl;
  }
}
