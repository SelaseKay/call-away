import 'dart:io';

import 'package:call_away/model/report_label_type.dart';
import 'package:call_away/model/report_status.dart';
import 'package:call_away/provider/camera_image_provider.dart';
import 'package:call_away/provider/location_provider.dart';
import 'package:call_away/provider/report_submission_state_provider.dart';
import 'package:call_away/services/location_service.dart';
import 'package:call_away/services/report_submission_service.dart';
import 'package:call_away/ui/custom-widget/custom_layout.dart';
import 'package:call_away/problem_type.dart';
import 'package:call_away/utils/user_input_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/report.dart';

class ReportFormScreen extends ConsumerStatefulWidget {
  ReportFormScreen(
      {Key? key,
      this.problemType = ProblemType.waterProblem,
      this.topLeftSvg = "assets/images/contact-us.svg"})
      : super(key: key);

  final ProblemType problemType;

  final String topLeftSvg;

  @override
  ConsumerState<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends ConsumerState<ReportFormScreen> {
  final _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final snackBar = (String text) => SnackBar(content: Text(text));

  ThemeData _getTheme() {
    if (widget.problemType == ProblemType.electricityProblem) {
      return ThemeData(
        primaryColor: const Color(0xFF6C6461),
        primaryColorLight: const Color(0xFF6C6461).withOpacity(0.45),
      );
    } else if (widget.problemType == ProblemType.others) {
      return ThemeData(
        primaryColor: const Color(0xFF654A69),
        primaryColorLight: const Color(0xFF654A69).withOpacity(0.45),
      );
    }
    return ThemeData(
        primaryColor: const Color(0xFF039BE5),
        primaryColorLight: const Color(0xFF039BE5).withOpacity(0.45));
  }

  String _getHeading() {
    if (widget.problemType == ProblemType.electricityProblem) {
      return "Electricity Problem";
    } else if (widget.problemType == ProblemType.others) {
      return "Others";
    }
    return "Water Problem";
  }

  @override
  Widget build(BuildContext context) {
    final image = ref.watch(cameraImageProvider);
    final locationState = ref.watch(locationProvider);
    final reportSubState = ref.watch(reportSubmissionStateProvider);

    ref.listen<XFile?>(cameraImageProvider, (previous, next) {
      ref.read(locationProvider.notifier).getDeviceCurrentLocation();
    });

    ref.listen<DeviceLocationState>(locationProvider, (previous, next) {
      if (next is DeviceLocationErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar(next.errorText));
      }
    });

    ref.listen<ReportSubmissionState>(reportSubmissionStateProvider,
        (previous, next) {
      if (next is ReportSubmissionStateLoading) {
        FocusScope.of(context).unfocus();
      } else if (next is ReportSubmissionStateSuccess) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.successMessage)));
        Navigator.pop(context);
      } else if (next is ReportSubmissionStateError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.errorMessage)));
      }
    });

    return Theme(
      data: _getTheme(),
      child: Stack(
        children: [
          CustomLayout(
              lightShadeBgColor: _getTheme().primaryColorLight,
              darkShadeBgColor: _getTheme().primaryColor,
              topLeftSvg: widget.topLeftSvg,
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
                      _AddPhotoButton(
                        image: image,
                        onPressed: () async {
                          ref
                              .read(cameraImageProvider.notifier)
                              .getImageFromCamera();
                        },
                      ),
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
                                  color:
                                      const Color(0xFF000000).withOpacity(0.55),
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
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                          border: Border.all(
                            width: 1.5,
                            color: const Color(0xFF000000).withOpacity(
                              0.32,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4.0,
                              ),
                              child: locationState is DeviceLocationSuccessState
                                  ? SvgPicture.asset(
                                      'assets/images/location_active.svg')
                                  : SvgPicture.asset(
                                      'assets/images/location.svg'),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 56.0),
                                child: locationState
                                        is DeviceLocationSuccessState
                                    ? Text(locationState.location,
                                        style: GoogleFonts.prompt(
                                          color: const Color(0xFF407BFF),
                                          fontWeight: FontWeight.w400,
                                          wordSpacing: 0.1,
                                          fontSize: 14.0,
                                        ))
                                    : Text(
                                        "location of the problem will be generated automatically after adding picture.",
                                        style: GoogleFonts.prompt(
                                          color: const Color(0xFF7C7C7C)
                                              .withOpacity(0.45),
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

                // description Section

                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
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
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          maxLines: 4,
                          controller: _descriptionController,
                          validator: (value) =>
                              Validator.valiedateReportDescription(value!),
                          decoration: InputDecoration(
                            focusColor: _getTheme().primaryColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5,
                                color: _getTheme().primaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5,
                                color:
                                    const Color(0xFF000000).withOpacity(0.32),
                              ),
                            ),
                            hintText:
                                'Type a brief description of the problem...',
                          ),
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
                      padding: const EdgeInsets.only(
                        top: 40.0,
                        bottom: 40.0,
                      ),
                      child: SizedBox(
                        height: 48.0,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: _getTheme().primaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (ref
                                        .read(cameraImageProvider.notifier)
                                        .state ==
                                    null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Image field should not be empty"),
                                    ),
                                  );
                                } else if (ref
                                    .read(locationProvider.notifier)
                                    .state is! DeviceLocationSuccessState) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Location field should not be empty"),
                                    ),
                                  );
                                } else {
                                  final location = (ref
                                          .read(locationProvider.notifier)
                                          .state as DeviceLocationSuccessState)
                                      .location;
                                  ref
                                      .read(reportSubmissionStateProvider
                                          .notifier)
                                      .submitReport(
                                        Report(
                                          location: location,
                                          description: _descriptionController
                                              .text
                                              .trim(),
                                          problemType: widget.problemType,
                                          statuses: {
                                            "Delivered": Timestamp.now().toDate().toString(),
                                            "Pending": "N/A",
                                            "Resolved": "N/A",
                                          },
                                          // statuses: [
                                          //   ReportStatus(
                                          //     time: Timestamp.now()
                                          //         .toDate()
                                          //         .toString(),
                                          //     label: ReportLabelType.delivered,
                                          //   ),
                                          //   null,
                                          //   null,
                                          //   null
                                          // ],
                                          currentStatus: ReportLabelType.delivered,
                                        ),
                                      );
                                }
                              }
                            },
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
          locationState is DeviceLocationLoadingState ||
                  reportSubState is ReportSubmissionStateLoading
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

class _AddPhotoButton extends StatelessWidget {
  const _AddPhotoButton({Key? key, required this.onPressed, this.image})
      : super(key: key);

  final VoidCallback onPressed;

  final XFile? image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 120.0,
          width: 104.0,
          decoration: BoxDecoration(
              image: image != null
                  ? DecorationImage(
                      fit: BoxFit.fill, image: FileImage(File(image!.path)))
                  : null,
              border: Border.all(
                color: const Color(0xFF9B9B9B),
                width: 1.5,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(16.0),
              )),
          child: InkWell(
              onTap: onPressed,
              child: Center(
                child: SvgPicture.asset('assets/images/add_photo.svg'),
              )),
        ),
      ],
    );
  }
}
