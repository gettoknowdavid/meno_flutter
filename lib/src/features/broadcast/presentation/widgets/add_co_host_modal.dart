import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/features/profile/profile.dart'
    show Profile, ProfileStats;
import 'package:meno_flutter/src/shared/domain/domain.dart';

final _users = [
  Profile(
    id: ID.fromString('1c326e7f-c331-4857-8125-52b13f312df8'),
    fullName: SingleLineString("Celebration Church Int'l"),
    numberOfSubscribers: 30000,
    stats: const ProfileStats(subscribers: 30000),
  ),
  Profile(
    id: ID.fromString('148290e6-992e-42d5-8048-110e237d4a21'),
    fullName: SingleLineString('The Catalyst Community Global'),

    numberOfSubscribers: 5606,
    stats: const ProfileStats(subscribers: 5606),
  ),
  Profile(
    id: ID.fromString('486478a3-1867-4a94-b2c8-436d196d8b99'),
    fullName: SingleLineString('Circle Church Global'),

    numberOfSubscribers: 5001,
    stats: const ProfileStats(subscribers: 5001),
  ),
  Profile(
    id: ID.fromString('9d76694b-4840-46c1-86db-d226f27c7eec'),
    fullName: SingleLineString('The New Global'),
    numberOfSubscribers: 8740,
    stats: const ProfileStats(subscribers: 8740),
  ),
  Profile(
    id: ID.fromString('c572a002-eac5-43f2-bdd5-2b7b2d28c637'),
    fullName: SingleLineString('The Equipping Center Global'),
    numberOfSubscribers: 6850,
    stats: const ProfileStats(subscribers: 6850),
  ),
  Profile(
    id: ID.fromString('2dd4cd64-3e34-4062-9753-6bb9651aed52'),
    fullName: SingleLineString('theupperroomfellowship'),
    numberOfSubscribers: 4550,
    stats: const ProfileStats(subscribers: 4550),
  ),
  Profile(
    id: ID.fromString('36f4e103-c51f-4e98-ae3a-5053e70ff5b0'),
    fullName: SingleLineString('Bayo Daini'),
    numberOfSubscribers: 40001,
    stats: const ProfileStats(subscribers: 40001),
  ),
  Profile(
    id: ID.fromString('b523f625-4854-4a7b-8c5f-64c490dd15fe'),
    fullName: SingleLineString('Godson Obielum'),
    numberOfSubscribers: 2235,
    stats: const ProfileStats(subscribers: 2235),
  ),
];

class AddCoHostModal extends HookConsumerWidget {
  const AddCoHostModal({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(broadcastFormProvider.notifier);

    final selectedCohosts = ref.watch(selectedCoHostsProvider);

    final cohostsEmpty = selectedCohosts.isEmpty;

    final selectedList = selectedCohosts.toList();

    return MenoModal(
      title: 'Add Co-host',
      padding: EdgeInsets.zero,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SearchBar(key: Key('AddCoHostSearchBar')),
            const MenoSpacer.v(16),
            const _HelperText(),
            const MenoSpacer.v(16),
            if (!cohostsEmpty) ...[
              const MenoSpacer.v(16),
              LimitedBox(
                maxHeight: 72,
                child: CoHostListWidget(
                  cohosts: selectedList,
                  onRemove: ref.read(selectedCoHostsProvider.notifier).remove,
                ),
              ),
              const MenoSpacer.v(16),
            ],
            const Expanded(child: _UsersListWidget()),
            if (!cohostsEmpty) ...[
              const MenoSpacer.v(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
                child: MenoPrimaryButton(
                  size: MenoSize.lg,
                  onPressed: () {
                    notifier.onAddCohost(selectedList);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Done'),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _UsersListWidget extends ConsumerWidget {
  const _UsersListWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCohosts = ref.watch(selectedCoHostsProvider);
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      separatorBuilder: (context, index) => const MenoSpacer.v(24),
      itemCount: _users.length,
      itemBuilder: (context, index) {
        final user = _users[index];
        return UsersListItem(
          user: user,
          isSelected: selectedCohosts.contains(user),
          canStillSelect: selectedCohosts.isEmpty,
          onSelected: ref.read(selectedCoHostsProvider.notifier).add,
        );
      },
    );
  }
}

class UsersListItem extends HookConsumerWidget {
  const UsersListItem({
    required this.user,
    required this.onSelected,
    super.key,
    this.isSelected = false,
    this.canStillSelect = true,
  });

  final Profile user;
  final bool isSelected;
  final bool canStillSelect;
  final ValueChanged<Profile> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subsriberCount =
        user.numberOfSubscribers ?? user.stats?.subscribers ?? 0;
    final formattedCount = NumberFormat.compact().format(subsriberCount);

    return MenoListTile(
      key: ValueKey('ColHostItem-${user.id}'),
      selected: isSelected,
      enabled: canStillSelect,
      headline: user.fullName.getOrCrash(),
      horizontalTitleGap: 8,
      leading: MenoAvatar(radius: 24, enabled: canStillSelect),
      subtitle: '$formattedCount subscribers',
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      trailing: SizedBox(
        height: 32,
        child: MenoSecondaryButton(
          disabled: !canStillSelect,
          onPressed: () => onSelected(user),
          child: const Text('Add as co-host'),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
      child: SearchBar(
        scrollPadding: EdgeInsets.zero,
        hintText: 'Search for a co-host',
        leading: Icon(MIcons.search, color: colors.labelPlaceholder, size: 16),
      ),
    );
  }
}

class _HelperText extends StatelessWidget {
  const _HelperText();

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
      child: Row(
        children: [
          Icon(MIcons.info_circle, size: 16, color: colors.labelPlaceholder),
          const MenoSpacer.h(Insets.xs),
          MenoText.caption(
            'Select not more than 1 co-host',
            weight: MenoFontWeight.regular,
            color: colors.labelPlaceholder,
          ),
        ],
      ),
    );
  }
}
