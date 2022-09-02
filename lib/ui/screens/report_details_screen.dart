import 'package:call_away/provider/report_details_provider.dart';
import 'package:call_away/services/report_details_service.dart';
import 'package:call_away/ui/components/app_bar.dart';
import 'package:call_away/ui/components/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            color: Color(0xFFC3C3C3),
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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: AppBarSection(
                        title:
                            "Report${(reportDetailsState as ReportDetailsStateSuccess).report.reportId.toString().substring(0, 8)}",
                        isRightWidgetVisible: false,
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 24.0,
                            ),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  16.0,
                                ),
                              ),
                            ),
                            width: double.infinity,
                            height: imageHeight,
                            child: Image.network(
                              reportDetailsState.report.imageUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          _ReportItem(
                            title: "Location",
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Color(0xFF979797),
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                Text(
                                  reportDetailsState.report.location,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ),
                          _ReportItem(
                            title: "Description",
                            child: Text(
                              reportDetailsState.report.description,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              reportDetailsState is ReportDetailsStateLoading
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
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(
          height: 8.0,
        ),
        child
      ],
    );
  }
}
