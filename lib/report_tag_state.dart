import 'package:flutter/cupertino.dart';

enum ReportTagStatus { delivered, received, pending, resolved }

abstract class ReportTagState {
  Color get textColor;
  Color get tagColor;
  String get title;
}

class DeliveredReportTagState implements ReportTagState {
  @override
  Color get tagColor => const Color(0xFFE3F2FD);

  @override
  Color get textColor => const Color(0xFF42A5F5);
  
  @override
  String get title => "Delivered";
}

class ReceivedReportTagState implements ReportTagState {
  @override
  Color get tagColor => const Color(0xFFE8EAF6);

  @override
  Color get textColor => const Color(0xFF5C6BC0);

  @override
  String get title => "Received";
}

class PendingReportTagState implements ReportTagState {
  @override
  Color get tagColor => const Color(0xFFFFFBD4);

  @override
  Color get textColor => const Color(0xFFFDD835);

  @override
  String get title => "Pending";
}

class ResolvedReportTagState implements ReportTagState {
  @override
  Color get tagColor => const Color(0xFFA7FFEB);

  @override
  Color get textColor => const Color(0xFF26A69A);

  @override
  String get title => "Resolved";
}
