import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final reportFieldImageProvider = StateProvider.autoDispose<XFile?>((ref) => null);

final reportFieldLocationProvider = StateProvider.autoDispose((ref) => "");

final reportFieldDescriptionProvider = StateProvider.autoDispose((ref) => "");
