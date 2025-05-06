//
// ignore_for_file: avoid_redundant_argument_values

import 'dart:io' show File;

import 'package:equatable/equatable.dart';
import 'package:meno_flutter/src/config/config.dart' show OrderBy;
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/features/profile/profile.dart' show Profile;
import 'package:meno_flutter/src/services/services.dart';
import 'package:meno_flutter/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'broadcast_form_notifier.g.dart';

@riverpod
class SelectedCoHosts extends _$SelectedCoHosts {
  @override
  Set<Profile> build() {
    final cohosts = ref.watch(broadcastFormProvider.select((s) => s.cohosts));
    return {...cohosts};
  }

  void add(Profile user) {
    final cohosts = Set<Profile>.from(state);
    cohosts.add(user);
    state = cohosts;
  }

  void remove(Profile? user) {
    final cohosts = Set<Profile>.from(state);
    cohosts.remove(user);
    state = cohosts;
  }
}

@riverpod
class BroadcastForm extends _$BroadcastForm {
  IBroadcastFacade get _facade => ref.read(broadcastFacadeProvider);
  @override
  BroadcastFormState build() {
    return BroadcastFormState(
      title: SingleLineString(''),
      description: MultiLineString(''),
    );
  }

  Future<void> initialize(ID id) async {
    state = state.copyWith(status: MenoFormStatus.inProgress, isEdit: true);
    final result = await _facade.getBroadcasts(
      id: id,
      sortBy: 'startTime',
      orderBy: OrderBy.ASC,
      status: BroadacstStatus.inactive.name,
    );
    state = result.fold(
      (exception) =>
          state.copyWith(status: MenoFormStatus.failure, exception: exception),
      (paginatedBroadcasts) => state.copyWith(
        status: MenoFormStatus.success,
        broadcast: paginatedBroadcasts.items.first,
      ),
    );
  }

  void titleChanged(String value) {
    state = state.copyWith(
      title: SingleLineString(value),
      exception: null,
      status: MenoFormStatus.initial,
    );
  }

  void descriptionChanged(String value) {
    state = state.copyWith(
      description: MultiLineString(value),
      exception: null,
      status: MenoFormStatus.initial,
    );
  }

  Future<void> imageChanged([
    MenoImageSource source = MenoImageSource.gallery,
  ]) async {
    final picker = ref.watch(mediaPickerProvider);
    final file = await picker.getImage(source);
    if (file == null) return;
    state = state.copyWith(
      image: ImageFile(File(file.path)),
      exception: null,
      status: MenoFormStatus.initial,
    );
  }

  void onAddCohost(List<Profile> users) {
    final cohosts = Set<Profile>.from(state.cohosts);
    cohosts.addAll(users);
    state = state.copyWith(
      cohosts: cohosts,
      exception: null,
      status: MenoFormStatus.initial,
    );
  }

  void onRemoveCohost(List<Profile> users) {
    final cohosts = Set<Profile>.from(state.cohosts);
    if (cohosts.isEmpty) return;
    cohosts.removeAll(users);
    state = state.copyWith(
      cohosts: cohosts,
      exception: null,
      status: MenoFormStatus.initial,
    );
  }

  void onShouldRecordChanged(bool value) {
    state = state.copyWith(
      shouldRecord: value,
      exception: null,
      status: MenoFormStatus.initial,
    );
  }

  Future<void> submit() async {
    if (state.status == MenoFormStatus.inProgress) return;

    state = state.copyWith(status: MenoFormStatus.inProgress, exception: null);

    final timezone = ref.read(timezoneProvider).valueOrNull;

    final cohosts = state.cohosts.map((e) => e.id).toList();

    final result = await _facade.createBroadcast(
      title: state.title,
      description: state.description,
      cohosts: cohosts,
      image: state.image,
      timezone: timezone,
    );

    state = result.fold(
      (exception) =>
          state.copyWith(status: MenoFormStatus.failure, exception: exception),
      (broadcast) =>
          state.copyWith(status: MenoFormStatus.success, broadcast: broadcast),
    );
  }
}

class BroadcastFormState with EquatableMixin {
  const BroadcastFormState({
    required this.title,
    required this.description,
    this.image,
    this.cohosts = const {},
    this.shouldRecord = false,
    this.status = MenoFormStatus.initial,
    this.exception,
    this.broadcast,
    this.isEdit = false,
  });

  final SingleLineString title;
  final MultiLineString description;
  final ImageFile? image;
  final Set<Profile> cohosts;
  final bool shouldRecord;
  final MenoFormStatus status;
  final BroadcastException? exception;
  final Broadcast? broadcast;
  final bool isEdit;

  BroadcastFormState copyWith({
    SingleLineString? title,
    MultiLineString? description,
    ImageFile? image,
    Set<Profile>? cohosts,
    bool? shouldRecord,
    MenoFormStatus? status,
    BroadcastException? exception,
    Broadcast? broadcast,
    bool? isEdit,
  }) {
    return BroadcastFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      cohosts: cohosts ?? this.cohosts,
      shouldRecord: shouldRecord ?? this.shouldRecord,
      status: status ?? this.status,
      exception: exception ?? this.exception,
      broadcast: broadcast ?? this.broadcast,
      isEdit: isEdit ?? this.isEdit,
    );
  }

  bool get isValid => title.isValid && description.isValid;

  @override
  List<Object?> get props => [
    title,
    description,
    image,
    cohosts,
    shouldRecord,
    isEdit,
  ];
}
