import 'package:call_away/problem_type.dart';
import 'package:image_picker/image_picker.dart';

class Report {
  String? id;
  final XFile image;
  final ProblemType problemType;
  final String description;

  Report(
      {required this.image,
      required this.problemType,
      required this.description});
}
