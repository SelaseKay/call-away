import 'package:call_away/services/report_submission_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportProvider =
    StateNotifierProvider<ReportSubmissionService, ReportSubmissionState>(
        (ref) {
  return ReportSubmissionService(ref);
});
