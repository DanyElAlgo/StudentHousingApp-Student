import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:housing_design_system/housing_design_system.dart';
import 'package:student_lib/l10n/generated/app_localizations.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit(String value) {
    final String name = value.trim();
    final String target =
        name.isEmpty ? '/rooms' : '/rooms?name=${Uri.encodeQueryComponent(name)}';
    context.go(target);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.homeWelcome, style: text.headlineSmall),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.homeSubtitle,
          style: text.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppSearchBar(
          controller: _controller,
          hintText: l10n.homeSearchHint,
          onSubmitted: _submit,
        ),
      ],
    );
  }
}
