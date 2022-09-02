import 'package:call_away/model/report_label_type.dart';
import 'package:call_away/provider/my_reports_provider.dart';
import 'package:call_away/services/reports_retrieval_service.dart';
import 'package:call_away/ui/components/app_bar.dart';
import 'package:call_away/report_tag_state.dart';
import 'package:call_away/ui/components/loading_screen.dart';
import 'package:call_away/ui/screens/report_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MyReportsScreen extends ConsumerStatefulWidget {
  const MyReportsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MyReportsScreen> createState() => _MyReportsScreenState();
}

class _MyReportsScreenState extends ConsumerState<MyReportsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(myReportsProvider.notifier).getMyReports();
  }

  Widget? _getWidget(ReportsState state) {
    if (state is ReportsStateSuccess) {
      if (state.reports.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/empty_report_list.svg",
              height: 80.0,
              width: 80.0,
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              "No Report History",
              style: TextStyle(
                color: Color(0xFFA5A5A5),
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),
            ),
          ],
        );
      }
      return ListView.builder(
        itemCount: state.reports.length,
        itemBuilder: (context, index) {
          final report = state.reports[index];

          return Padding(
            padding:
                EdgeInsets.only(top: index == 0 ? 32.0 : 0.0, bottom: 16.0),
            child: _ReportItem(
              key: Key(index.toString()),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimatio) =>
                        ReportDetailsScreen(reportId: report.reportId!),
                  ),
                );
              },
              title: "Reports#${report.reportId.toString().substring(0, 8)}",
              date: report.status!.time.substring(0, 16),
            ),
          );
        },
      );
    } else if (state is ReportsStateError) {
      return Center(
        child: Text(
          state.errorMessage,
          style: const TextStyle(
            color: Color(0x00AFAFAF),
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
          ),
        ),
      );
    }
    return const Center();
  }

  @override
  Widget build(BuildContext context) {
    final myReportsState = ref.watch(myReportsProvider);

    ref.listen(myReportsProvider, (previous, next) {
      if (next is ReportsStateError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
          ),
        );
      }
    });

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
          child: Stack(
            children: [
              Padding(
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
                      child: _getWidget(myReportsState)!,
                    )
                  ],
                ),
              ),
              myReportsState is ReportsStateLoading
                  ? const LoadingScreen()
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportItem extends StatelessWidget {
  const _ReportItem({
    Key? key,
    this.title = "",
    this.date = "",
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final String date;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Row(
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
                        textStyle: Theme.of(context).textTheme.bodyText1,
                      ),
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
  const _ReportTag({Key? key, this.tagStatus = ReportLabelType.delivered})
      : super(key: key);

  final ReportLabelType tagStatus;

  ReportTagState getTagState() {
    switch (tagStatus) {
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
        )));
  }
}
