import 'package:call_away/components/app_bar.dart';
import 'package:call_away/report_tag_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MyReportsScreen extends StatelessWidget {
  const MyReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          dividerTheme: const DividerThemeData(
            thickness: 1.5,
            color: Color(0xFFDDD3D0),
          ),

          primaryColor: const Color(0xFFA1887F),
          textTheme: const TextTheme(
            headline6: TextStyle(color: Color(0xFFA1887F)),
              bodyText1: TextStyle(color: Colors.black, fontSize: 16.0),
              subtitle1: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF949494)))),
      child: Scaffold(
          body: SafeArea(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: AppBarSection(
                title: "My Reports",
                isRightWidgetVisible: false,
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 16.0),
                children: const [
                  Padding(
                    padding:  EdgeInsets.only(top: 32.0),
                    child: _ReportItem(),
                  ),
                  SizedBox(height: 16.0,),
                  _ReportItem(),
                  SizedBox(height: 16.0,),
                  _ReportItem()
                ],
              ),
            )
          ],
        ),
      ))),
    );
  }
}

class _ReportItem extends StatelessWidget {
  const _ReportItem(
      {Key? key,
      this.title = "Report#njo24",
      this.date = "23 Apr, 2022 21:08"})
      : super(key: key);
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/report.svg',
              height: 24.0,
              width: 24.0,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.prompt(
                        textStyle: Theme.of(context).textTheme.bodyText1),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    date,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.prompt(
                        textStyle: Theme.of(context).textTheme.subtitle1),
                  ),
                ],
              ),
            ),
            const _ReportTag()
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Divider(),
        )
      ],
    );
  }
}

class _ReportTag extends StatelessWidget {
  const _ReportTag({Key? key, this.tagStatus = ReportTagStatus.delivered})
      : super(key: key);

  final ReportTagStatus tagStatus;

  ReportTagState getTagState() {
    switch (tagStatus) {
      case ReportTagStatus.delivered:
        return DeliveredReportTagState();
      case ReportTagStatus.received:
        return ReceivedReportTagState();
      case ReportTagStatus.pending:
        return PendingReportTagState();
      case ReportTagStatus.resolved:
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
          borderRadius: const BorderRadius.all(Radius.circular(32.0))
        ),
        padding:
            const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
        child: Center(
            child: Text(
          getTagState().title,
          style: TextStyle(
            color: getTagState().textColor,
            fontSize: 14.0,
          ),
        )));
  }
}
