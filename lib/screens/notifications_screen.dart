import 'package:call_away/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor: const Color(0xFFA1887F),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(0xFFE39F60), // Your accent color
          ),
          dividerTheme: const DividerThemeData(
            thickness: 1.5,
            color: Color(0xFFDDD3D0),
          ),
          textTheme: const TextTheme(
              headline6: TextStyle(color: Color(0xFFA1887F)),
              subtitle1: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF252525),
              ),
              subtitle2: TextStyle(color: Color(0xFF999999)),
              bodyText1: TextStyle(color: Color(0xFFD9D9D9)))),
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: AppBarSection(
                title: "Notifications",
                isRightWidgetVisible: false,
              ),
            ),
            Expanded(
                child: ListView(
              children: const [
                Padding(
                    padding: EdgeInsets.only(top: 32.0),
                    child: _NoticationsItem()),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: _NoticationsItem(
                    title: "Electricity Company of Ghana",
                    description: "We are working on the problem",
                  ),
                )
              ],
            ))
          ]),
        )),
      ),
    );
  }
}

class _NoticationsItem extends StatelessWidget {
  const _NoticationsItem(
      {Key? key,
      this.isUnreadNotification = true,
      this.title = "Ghana Water Company",
      this.description = "We have received your report",
      this.time = "5 mins ago"})
      : super(key: key);

  final bool isUnreadNotification;
  final String title;
  final String description;
  final String time;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: isUnreadNotification,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: CircleAvatar(
                        radius: 4.0,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Baseline(
                          baselineType: TextBaseline.alphabetic,
                          baseline: 42.0,
                          child: Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.prompt(
                                color:
                                    const Color(0xFF000000).withOpacity(0.71),
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0),
                          ),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.prompt(
                              color: const Color(0xFF000000).withOpacity(0.44),
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Baseline(
                baselineType: TextBaseline.alphabetic,
                baseline: 42.0,
                child: Text(time,
                    style: GoogleFonts.prompt(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0)),
              ),
            )
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 20.0), child: Divider())
      ],
    );
  }
}
