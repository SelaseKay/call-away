import 'package:call_away/model/report_label_type.dart';
import 'package:call_away/report_tag_state.dart';
import 'package:flutter/cupertino.dart';

class ReportStatusTag extends StatelessWidget {
  const ReportStatusTag({Key? key, this.label = ReportLabelType.delivered})
      : super(key: key);

  final ReportLabelType label;

  ReportTagState getTagState() {
    switch (label) {
      case ReportLabelType.delivered:
        return DeliveredReportTagState();
      case ReportLabelType.received:
        return ReceivedReportTagState();
      case ReportLabelType.pending:
        return PendingReportTagState();
      case ReportLabelType.resolved:
        return ResolvedReportTagState();
      default:
        return DeliveredReportTagState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: getTagState().tagColor,
          borderRadius: const BorderRadius.all(Radius.circular(32.0))),
      padding:
          const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
      child: Center(
        child: Text(
          getTagState().title,
          style: TextStyle(
            color: getTagState().textColor,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
