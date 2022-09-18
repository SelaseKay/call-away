import 'package:call_away/model/report_label_type.dart';
import 'package:call_away/provider/report_details_provider.dart';
import 'package:call_away/services/report_details_service.dart';
import 'package:call_away/ui/components/app_bar.dart';
import 'package:call_away/ui/components/overlay_loading_screen.dart';
import 'package:call_away/ui/components/report_status_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/report.dart';

class ReportDetailsScreen extends ConsumerStatefulWidget {
  const ReportDetailsScreen({
    Key? key,
    required this.reportId,
  }) : super(key: key);

  final String reportId;

  @override
  ConsumerState<ReportDetailsScreen> createState() =>
      _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends ConsumerState<ReportDetailsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(reportDetailsProvider.notifier).getReport(widget.reportId);
  }

  @override
  Widget build(BuildContext context) {
    final imageHeight = MediaQuery.of(context).size.height * 0.32;

    final reportDetailsState = ref.watch(reportDetailsProvider);

    ref.listen(reportDetailsProvider, (previous, next) {
      if (next is ReportDetailsStateError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.errorMessage)));
        Navigator.pop(context);
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
          headline6: TextStyle(
            color: Color(0xFFA1887F),
          ),
          bodyText1: TextStyle(
            color: Color(0xFF979797),
            fontSize: 16.0,
          ),
          bodyText2: TextStyle(
            color: Color(0xFF727272),
          ),
          subtitle1: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: Color(0xFF949494),
          ),
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: reportDetailsState is ReportDetailsStateLoading
              ? const OverlayLoadingScreen()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: AppBarSection(
                          title:
                              "Report#${(reportDetailsState as ReportDetailsStateSuccess).report.reportId.toString().substring(0, 8)}",
                          action: null,
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 24.0,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ),
                              child: Image.network(
                                height: imageHeight,
                                width: double.infinity,
                                fit: BoxFit.fill,
                                reportDetailsState.report.imageUrl,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return SizedBox(
                                    height: imageHeight,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Color(
                                          0xFFDBAC65,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            _ReportItem(
                              title: "Location",
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xFF818181),
                                  ),
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                  Text(
                                    reportDetailsState.report.location,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            _ReportItem(
                              title: "Description",
                              child: Text(
                                reportDetailsState.report.description,
                                style: GoogleFonts.prompt(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText1),
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            _ReportItem(
                              title: "Problem Type",
                              child: Text(
                                reportDetailsState.report.problemType.name,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            _ReportStatusTable(
                              report: reportDetailsState.report,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class _ReportItem extends StatelessWidget {
  const _ReportItem({Key? key, required this.title, required this.child})
      : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.prompt(
            textStyle: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        child
      ],
    );
  }
}

class _ReportStatusTable extends StatelessWidget {
  const _ReportStatusTable({
    Key? key,
    required this.report,
  }) : super(key: key);

  final Report report;

  @override
  Widget build(BuildContext context) {
    var statuses = report.status;

    return Column(
      children: [
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Staus",
              style: GoogleFonts.prompt(
                textStyle: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            const Icon(
              Icons.schedule,
              color: Color(0xFFFF9963),
            ),
          ],
        ),
        const Divider(),
        const SizedBox(
          height: 8.0,
        ),
        _ReportStatusItem(
          dateTime:
              statuses[0] == null ? "N/A" : statuses[0]!.time.substring(0, 16),
          child: const ReportStatusTag(
            label: ReportLabelType.delivered,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        _ReportStatusItem(
          dateTime:
              statuses[1] == null ? "N/A" : statuses[1]!.time.substring(0, 16),
          child: const ReportStatusTag(
            label: ReportLabelType.received,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        _ReportStatusItem(
          dateTime:
              statuses[2] == null ? "N/A" : statuses[2]!.time.substring(0, 16),
          child: const ReportStatusTag(
            label: ReportLabelType.pending,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        _ReportStatusItem(
          dateTime:
              statuses[3] == null ? "N/A" : statuses[3]!.time.substring(0, 16),
          child: const ReportStatusTag(
            label: ReportLabelType.resolved,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}

class _ReportStatusItem extends StatelessWidget {
  const _ReportStatusItem({
    Key? key,
    required this.child,
    required this.dateTime,
  }) : super(key: key);

  final Widget child;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        child,
        Text(
          dateTime,
          style: GoogleFonts.prompt(
            textStyle: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
