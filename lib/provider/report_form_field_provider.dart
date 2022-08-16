import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageFieldProvider = StateProvider.autoDispose<XFile?>((ref) => null);

final locatoinFieldProvider = StateProvider.autoDispose((ref) => "");

final descriptionFieldProvider = StateProvider.autoDispose((ref) => "");