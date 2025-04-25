import 'dart:io';

import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:meno_flutter/src/shared/shared.dart';

class ImageFile extends ValueObject<File?> {
  factory ImageFile(File? input) {
    final validationResult = _validateFile(input);
    return ImageFile._(validationResult);
  }

  const ImageFile._(super.input);

  static const ImageFile empty = ImageFile._(Right(null));

  static final _allowedExtensions = ['jpg', 'jpeg', 'png'];

  static Either<ValueException<File?>, File?> _validateFile(File? input) {
    if (input == null) return const Right(null);

    final extension = input.path.split('.').last.toLowerCase();

    if (!_allowedExtensions.contains(extension)) {
      return Left(InvalidFileFormatException<File?>(input));
    }

    return Right(input);
  }
}
