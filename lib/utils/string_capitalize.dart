import 'package:call_away/model/report_label_type.dart';

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    }
}

  convertCurrentStatusToString(ReportLabelType labelType){
    return labelType.name.capitalize();
  }