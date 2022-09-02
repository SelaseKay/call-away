import 'package:call_away/services/report_details_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportDetailsProvider = StateNotifierProvider<ReportDetailsService, ReportDetailsState>((ref){
  return ReportDetailsService();
});