import 'package:flutter/material.dart';

import '../../tokens/app_spacing.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.padded = false,
    this.safeArea = true,
    this.extendBody = false,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  final bool padded;
  final bool safeArea;

  final bool extendBody;

  @override
  Widget build(BuildContext context) {
    Widget content = body;
    if (padded) {
      content = Padding(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: content,
      );
    }
    if (safeArea) {
      content = SafeArea(child: content);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: appBar,
      body: content,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      extendBody: extendBody,
    );
  }
}
