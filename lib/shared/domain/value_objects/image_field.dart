import 'dart:io';

import 'package:formz/formz.dart';

enum ImageFileValidationError { invalidFormat }

class ImageFile extends FormzInput<File?, ImageFileValidationError> {
  const ImageFile.pure([super.value]) : super.pure();

  const ImageFile.dirty([super.value]) : super.dirty();

  @override
  ImageFileValidationError? validator(File? value) {
    if (value == null) return null;
    final allowedExtensions = ['jpg', 'jpeg', 'png'];
    final extension = value.path.split('.').last.toLowerCase();
    if (!allowedExtensions.contains(extension)) {
      return ImageFileValidationError.invalidFormat;
    }
    return null;
  }
}

extension ImageFileValidationErrorX on ImageFileValidationError {
  String get text {
    switch (this) {
      case ImageFileValidationError.invalidFormat:
        return 'Invalid image format. Select only JPG, JPEG, PNG';
    }
  }
}
