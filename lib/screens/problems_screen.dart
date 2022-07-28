import 'package:call_away/custom-widget/custom_layout.dart';
import 'package:call_away/problem_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProblemsScreen extends StatelessWidget {
  const ProblemsScreen(
      {Key? key,
      this.problemType = ProblemType.WaterProblem,
      this.pageHeading = "Water Problem",
      required this.themeData,
      this.topLeftSvg = "assets/images/contact-us.svg"})
      : super(key: key);

  final ProblemType problemType;
  final String pageHeading;
  final String topLeftSvg;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: themeData,
      child: CustomLayout(
          lightShadeBgColor: themeData.primaryColorLight,
          darkShadeBgColor: themeData.primaryColor,
          topLeftSvg: topLeftSvg,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                pageHeading,
                style: GoogleFonts.prompt(
                    color: themeData.primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // add photo section
                  const _AddPhotoButton(),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add Photo",
                          style: GoogleFonts.prompt(
                            color: const Color(0xFF010101),
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 88.0),
                          child: Text(
                            "Take a clear picture of the problem at hand",
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.prompt(
                              color: const Color(0xFF000000).withOpacity(0.55),
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                              height: 1.14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            //location section

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Location",
                    style: GoogleFonts.prompt(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF010101)),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        border: Border.all(
                            width: 1.5,
                            color: const Color(0xFF000000).withOpacity(0.32))),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: SvgPicture.asset('assets/images/location.svg'),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 108.0),
                            child: Text(
                                "location of the problem will be generated automatically after adding picture.",
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.prompt(
                                  color:
                                      const Color(0xFF7C7C7C).withOpacity(0.45),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                )),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            // description Sectoin

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: GoogleFonts.prompt(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF010101)),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.5,
                              color:
                                  const Color(0xFF000000).withOpacity(0.32))),
                      hintText: 'Type a brief description of the problem...',
                    ),
                  )
                ],
              ),
            ),

            // Submit Button

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: SizedBox(
                    height: 48.0,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: themeData.primaryColor,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)))),
                        onPressed: () {},
                        child: Text(
                          "Submit Report",
                          style: GoogleFonts.prompt(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w800),
                        )),
                  ),
                ),
              ],
            )
          ]),
    );
  }
}

class _AddPhotoButton extends StatefulWidget {
  const _AddPhotoButton({Key? key}) : super(key: key);

  @override
  State<_AddPhotoButton> createState() => __AddPhotoButtonState();
}

class __AddPhotoButtonState extends State<_AddPhotoButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 120.0,
          width: 104.0,
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFF9B9B9B),
                    width: 1.5,
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)))),
              onPressed: () {},
              child: Center(
                child: SvgPicture.asset('assets/images/add_photo.svg'),
              )),
        )
      ],
    );
  }
}
