import 'package:call_away/services/reports_retrieval_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myReportsProvider =
    StateNotifierProvider.autoDispose<ReportRetrievalService, ReportRetrievalState>((ref) {
  return ReportRetrievalService();
});
