//
// ignore_for_file: avoid_redundant_argument_values

import 'dart:io' show File;

import 'package:equatable/equatable.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/services/services.dart';
import 'package:meno_flutter/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'broadcast_form_notifier.g.dart';

@riverpod
class CreateBroadcast extends _$CreateBroadcast {
  @override
  FutureOr<Broadcast> build() async {
    state = const AsyncLoading();
    final form = ref.read(broadcastFormProvider);

    final timezone = ref.read(timezoneProvider).valueOrNull;

    final result = await ref
        .read(broadcastFacadeProvider)
        .createBroadcast(
          title: form.title,
          description: form.description,
          cohosts: form.cohosts?.toList(),
          image: form.image,
          timezone: timezone,
        );

    return result.fold(
      (exception) => throw exception,
      (broadcast) => broadcast,
    );
  }
}

@riverpod
class BroadcastForm extends _$BroadcastForm {
  @override
  BroadcastFormState build() => const BroadcastFormState();

  void titleChanged(String value) {
    state = state.copyWith(title: SingleLineString(value));
  }

  void descriptionChanged(String value) {
    state = state.copyWith(description: MultiLineString(value));
  }

  Future<void> imageChanged({bool fromGallery = true}) async {
    final picker = ref.read(mediaPickerProvider);
    final file = await picker.getImage(fromGallery: fromGallery);
    if (file == null) return;
    state = state.copyWith(image: ImageFile(File(file.path)));
  }

  void onAddCohost(ID userId) {
    final cohosts = Set<ID>.from(state.cohosts ?? {});
    cohosts.add(userId);
    state = state.copyWith(cohosts: cohosts);
  }

  void onRemoveCohost(ID userId) {
    final cohosts = Set<ID>.from(state.cohosts ?? {});
    if (cohosts.isEmpty) return;
    cohosts.remove(userId);
    state = state.copyWith(cohosts: cohosts);
  }

  void onShouldRecordChanged(bool value) {
    state = state.copyWith(shouldRecord: value);
  }
}

class BroadcastFormState with EquatableMixin {
  const BroadcastFormState({
    this.title = SingleLineString.empty,
    this.description = MultiLineString.empty,
    this.image,
    this.cohosts,
    this.shouldRecord = false,
  });

  final SingleLineString title;
  final MultiLineString description;
  final ImageFile? image;
  final Set<ID>? cohosts;
  final bool shouldRecord;

  BroadcastFormState copyWith({
    SingleLineString? title,
    MultiLineString? description,
    ImageFile? image,
    Set<ID>? cohosts,
    bool? shouldRecord,
  }) {
    return BroadcastFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      cohosts: cohosts ?? this.cohosts,
      shouldRecord: shouldRecord ?? this.shouldRecord,
    );
  }

  @override
  List<Object?> get props => [title, description, image, cohosts, shouldRecord];
}

// @riverpod
// class BroadcastForm extends _$BroadcastForm {
//   @override
//   BroadcastFormState build() => const BroadcastFormState();

//   void titleChanged(String value) {
//     state = state.copyWith(
//       title: SingleLineString(value),
//       exception: null,
//       status: MenoFormStatus.initial,
//     );
//   }

//   void descriptionChanged(String value) {
//     state = state.copyWith(
//       description: MultiLineString(value),
//       exception: null,
//       status: MenoFormStatus.initial,
//     );
//   }

//   Future<void> imageChanged({bool fromGallery = true}) async {
//     final file = await ref
//         .read(mediaPickerProvider)
//         .getImage(fromGallery: fromGallery);

//     if (file != null) {
//       state = state.copyWith(
//         image: ImageFile(File(file.path)),
//         exception: null,
//         status: MenoFormStatus.initial,
//       );
//     }
//   }

//   void onAddCohost(ID userId) {
//     final cohosts = Set<ID>.from(state.cohosts ?? {});

//     cohosts.add(userId);

//     state = state.copyWith(
//       cohosts: cohosts,
//       exception: null,
//       status: MenoFormStatus.initial,
//     );
//   }

//   void onRemoveCohost(ID userId) {
//     final cohosts = Set<ID>.from(state.cohosts ?? {});

//     if (cohosts.isEmpty) return;

//     cohosts.remove(userId);

//     state = state.copyWith(
//       cohosts: cohosts,
//       exception: null,
//       status: MenoFormStatus.initial,
//     );
//   }

//   void onShouldRecordChanged(bool value) {
//     state = state.copyWith(
//       shouldRecord: value,
//       exception: null,
//       status: MenoFormStatus.initial,
//     );
//   }

//   Future<void> submit() async {
//     if (state.status == MenoFormStatus.inProgress) return;

    // final timezone = ref.read(timezoneProvider).valueOrNull;

    // final result = await ref
    //     .read(broadcastFacadeProvider)
    //     .createBroadcast(
    //       title: state.title,
    //       description: state.description,
    //       cohosts: state.cohosts?.toList(),
    //       image: state.image,
    //       timezone: timezone,
    //     );

//     state = result.fold(
//       (exception) =>
//           state.copyWith(status: MenoFormStatus.failure,exception:exception),
//       (profile) => state.copyWith(status: MenoFormStatus.success),
//     );
//   }
// }

// class BroadcastFormState with EquatableMixin {
//   const BroadcastFormState({
//     this.title = SingleLineString.empty,
//     this.description = MultiLineString.empty,
//     this.image,
//     this.cohosts,
//     this.shouldRecord = false,
//     this.status = MenoFormStatus.initial,
//     this.exception,
//   });

//   final SingleLineString title;
//   final MultiLineString description;
//   final ImageFile? image;
//   final Set<ID>? cohosts;
//   final MenoFormStatus status;
//   final bool shouldRecord;
//   final BroadcastException? exception;

//   BroadcastFormState copyWith({
//     SingleLineString? title,
//     MultiLineString? description,
//     ImageFile? image,
//     Set<ID>? cohosts,
//     MenoFormStatus? status,
//     bool? shouldRecord,
//     BroadcastException? exception,
//   }) {
//     return BroadcastFormState(
//       title: title ?? this.title,
//       description: description ?? this.description,
//       image: image ?? this.image,
//       cohosts: cohosts ?? this.cohosts,
//       status: status ?? this.status,
//       shouldRecord: shouldRecord ?? this.shouldRecord,
//       exception: exception ?? this.exception,
//     );
//   }

//   @override
//   List<Object?> get props => [
//     title,
//     description,
//     image,
//     cohosts,
//     status,
//     shouldRecord,
//     exception,
//   ];
// }
