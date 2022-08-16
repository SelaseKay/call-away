import 'dart:io';

import 'package:call_away/custom-widget/custom_layout.dart';
import 'package:call_away/problem_type.dart';
import 'package:call_away/viewmodel/report/report_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ReportFormScreen extends StatelessWidget {
  const ReportFormScreen(
      {Key? key,
      this.problemType = ProblemType.WaterProblem,
      this.topLeftSvg = "assets/images/contact-us.svg"})
      : super(key: key);

  final ProblemType problemType;

  final String topLeftSvg;

  ThemeData _getTheme() {
    if (problemType == ProblemType.ElectricityProblem) {
      return ThemeData(
          primaryColor: const Color(0xFF6C6461),
          primaryColorLight: const Color(0xFF6C6461).withOpacity(0.45));
    } else if (problemType == ProblemType.Others) {
      return ThemeData(
          primaryColor: const Color(0xFF654A69),
          primaryColorLight: const Color(0xFF654A69).withOpacity(0.45));
    }
    return ThemeData(
        primaryColor: const Color(0xFF039BE5),
        primaryColorLight: const Color(0xFF039BE5).withOpacity(0.45));
  }

  String _getHeading() {
    if (problemType == ProblemType.ElectricityProblem) {
      return "Electricity Problem";
    } else if (problemType == ProblemType.Others) {
      return "Others";
    }
    return "Water Problem";
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _getTheme(),
      child: CustomLayout(
          lightShadeBgColor: _getTheme().primaryColorLight,
          darkShadeBgColor: _getTheme().primaryColor,
          topLeftSvg: topLeftSvg,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                _getHeading(),
                style: GoogleFonts.prompt(
                    color: _getTheme().primaryColor,
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
                    height: 8.0,
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
                            padding: const EdgeInsets.only(right: 56.0),
                            child: Text(
                                "location of the problem will be generated automatically after adding picture.",
                                style: GoogleFonts.prompt(
                                  color:
                                      const Color(0xFF7C7C7C).withOpacity(0.45),
                                  fontWeight: FontWeight.normal,
                                  wordSpacing: 0.1,
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
                      focusColor: _getTheme().primaryColor,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.5, color: _getTheme().primaryColor)),
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
                            primary: _getTheme().primaryColor,
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

class _AddPhotoButton extends ConsumerWidget {
  const _AddPhotoButton({Key? key}) : super(key: key);

  // Future<void> getLostData() async {
  //   final LostDataResponse response = await picker.retrieveLostData();
  //   if (response.isEmpty) {
  //     return;
  //   }
  //   if (response.files != null) {
  //     for (final XFile file in response.files) {
  //       _handleFile(file);
  //     }
  //   } else {
  //     _handleError(response.exception);
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final XFile? reportImage = ref.watch(reportFieldImageProvider);

    return Row(
      children: [
        Container(
          height: 120.0,
          width: 104.0,
          decoration: BoxDecoration(
              image: reportImage != null
                  ? DecorationImage(
                      fit: BoxFit.fill,
                      image: FileImage(File(reportImage.path)))
                  : null,
              border: Border.all(
                color: const Color(0xFF9B9B9B),
                width: 1.5,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(16.0),
              )),
          child: InkWell(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                try {
                  XFile? image =
                      await picker.pickImage(source: ImageSource.camera);
                  ref.read(reportFieldImageProvider.notifier).state = image;
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              child: Center(
                child: SvgPicture.asset('assets/images/add_photo.svg'),
              )),
        ),
        // child: reportImage == null
        //     ? Center(
        //         child: SvgPicture.asset('assets/images/add_photo.svg'),
        //       )
        //     : Image.file(File(reportImage.path), fit: BoxFit.fill)),
      ],
    );
  }
}
