// import 'package:dartz/dartz.dart';
// import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
// import 'package:meno_flutter/src/shared/shared.dart';

// class BroadcastTitle extends ValueObject<String> {
//   factory BroadcastTitle(String input) {
//     final finalInput = toBeginningOfSentenceCase(input);
//     return BroadcastTitle._(
//       validateRequiredValue(finalInput).flatMap(validateSingleLine),
//     );
//   }

//   const BroadcastTitle._(this.value);

//   @override
//   final Either<ValueException<String>, String> value;
// }
