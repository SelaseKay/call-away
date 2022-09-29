import 'package:call_away/model/report_label_type.dart';
import 'package:call_away/provider/my_reports_provider.dart';
import 'package:call_away/services/reports_retrieval_service.dart';
import 'package:call_away/ui/components/app_bar.dart';
import 'package:call_away/ui/components/loading_screen.dart';
import 'package:call_away/ui/components/report_status_tag.dart';
import 'package:call_away/ui/screens/report_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:call_away/utils/string_capitalize.dart';


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

  _convertCurrentStatusToString(ReportLabelType labelType){
    return labelType.name.capitalize();
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

      return RefreshIndicator(
        child: ListView.builder(
          itemCount: state.reports.length,
          itemBuilder: (context, index) {
            final report = state.reports[index];
      
            return Padding(
              padding:
                  EdgeInsets.only(top: index == 0 ? 32.0 : 0.0, bottom: 16.0),
              child: _ReportItem(
                key: Key(
                  index.toString(),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimatio) =>
                          ReportDetailsScreen(reportId: report.reportId!),
                    ),
                  );
                },
                label: report.currentStatus!,
                title: "Report#${report.reportId.toString().substring(0, 8)}",
                date: report.statuses![_convertCurrentStatusToString(report.currentStatus!)]!,
              ),
            );
          },
          physics: const AlwaysScrollableScrollPhysics(),
        ),
        onRefresh: (){
          return ref.read(myReportsProvider.notifier).getMyReports();
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
            color: Color(0xFF949494),
          ),
        ),
      ),
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
                        action: null,
                      ),
                    ),
                    Expanded(
                      child: _getWidget(myReportsState)!,
                    )
                  ],
                ),
              ),
              myReportsState is ReportsStateLoading
                  ? const LoadingScreen(
                      loadingText: "Getting reports",
                    )
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
    required this.label,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final String date;
  final ReportLabelType label;

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
                      date.substring(0, 16),
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.prompt(
                          textStyle: Theme.of(context).textTheme.subtitle1),
                    ),
                  ],
                ),
              ),
              ReportStatusTag(
                label: label,
              ),
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
