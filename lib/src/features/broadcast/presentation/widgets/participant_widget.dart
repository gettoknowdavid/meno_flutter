import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart'
    show Participant, ParticipantRole;
import 'package:skeletonizer/skeletonizer.dart';

class ParticipantWidget extends StatelessWidget {
  const ParticipantWidget({required this.participant, super.key, this.onTap});
  final Participant participant;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isHost = participant.role == ParticipantRole.HOST;
    final isCohost = participant.role == ParticipantRole.COHOST;

    return GestureDetector(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 88,
          minHeight: 72,
          maxWidth: 80,
          minWidth: 80,
        ),
        child: Column(
          children: [
            SizedBox.square(
              dimension: 48,
              child: Stack(
                children: [
                  MenoAvatar(radius: 24, url: participant.imageUrl),
                  if (isHost || isCohost)
                    const Positioned(
                      left: 28,
                      top: 28,
                      child: _Microhpone(key: Key('ParticipantMicrophoneIcon')),
                    ),
                ],
              ),
            ),
            const MenoSpacer.v(Insets.sm),
            MenoText.micro(
              participant.fullName.getOrCrash(),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (isHost) ...[
              const MenoSpacer.v(Insets.xs),
              const _Subtitle('Host'),
            ],
            if (isCohost) ...[
              const MenoSpacer.v(Insets.xs),
              const _Subtitle('Co-host'),
            ],
          ],
        ),
      ),
    );
  }
}

class _Microhpone extends StatelessWidget {
  const _Microhpone({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);

    return Skeleton.ignore(
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: colors.brandPrimary,
          shape: BoxShape.circle,
          border: Border.all(width: 1.5, color: colors.staticWhite),
        ),
        child: Icon(MIcons.microphone_off, size: 10, color: colors.staticWhite),
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle(this.data);
  final String data;

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return MenoText.nano(
      data,
      weight: MenoFontWeight.regular,
      color: colors.labelDisabled,
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
