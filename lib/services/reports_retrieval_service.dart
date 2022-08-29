import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ReportRetrievalState {}

class ReportRetrievalStateInitial extends ReportRetrievalState {}

class ReportRetrievalStateLoading extends ReportRetrievalState {}

class ReportRetrievalStateSuccess extends ReportRetrievalState {}

class ReportRetrievalStateError extends ReportRetrievalState {
  ReportRetrievalStateError(this.errorMessage);

  final String errorMessage;
}

class ReportRetrievalService extends StateNotifier<ReportRetrievalState> {
  ReportRetrievalService(): super(ReportRetrievalStateInitial());

  Future<void> getMyReports(){
    
  }
}
