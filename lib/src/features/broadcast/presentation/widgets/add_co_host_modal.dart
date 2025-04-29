import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/features/profile/profile.dart' show Profile;

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
      itemCount: fakeUsers.length,
      itemBuilder: (context, index) {
        final user = fakeUsers[index];
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
