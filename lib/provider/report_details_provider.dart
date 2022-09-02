import 'package:call_away/services/report_details_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportDetailsProvider = StateNotifierProvider.autoDispose<ReportDetailsService, ReportDetailsState>((ref){
  return ReportDetailsService();
});